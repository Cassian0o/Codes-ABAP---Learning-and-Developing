CLASS zmsc_cl_high_scores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.

ENDCLASS.


CLASS zmsc_cl_high_scores IMPLEMENTATION.

  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.

  METHOD list_scores.
    result = me->scores_list.
  ENDMETHOD.

  METHOD latest.
  
    DATA: lv_num_linhas TYPE i.
    
    lv_num_linhas = LINES( me->scores_list ).
    result = me->scores_list[ lv_num_linhas ].
    
  ENDMETHOD.

  METHOD personalbest.
    DATA: lt_scores_list TYPE integertab.

    lt_scores_list = me->scores_list.

    SORT lt_scores_list BY table_line DESCENDING.
    result = lt_scores_list[ 1 ].
      
  ENDMETHOD.

  METHOD personaltopthree.
    DATA: lt_scores_list TYPE integertab,
          lv_scores TYPE i.

    lt_scores_list = me->scores_list.

    SORT lt_scores_list BY table_line DESCENDING.

    LOOP AT lt_scores_list INTO lv_scores.
      
      IF sy-tabix > 3.
        EXIT.
      ENDIF.
      Append lv_scores to result.
    
    ENDLOOP.
    
  ENDMETHOD.


ENDCLASS.
