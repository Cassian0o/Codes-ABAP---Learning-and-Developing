class ZMSC_CL_ITAB definition
  public
  final
  create public .

PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_type,
             group       TYPE group,
             number      TYPE i,
             description TYPE string,
           END OF initial_type,
           itab_data_type TYPE STANDARD TABLE OF initial_type WITH EMPTY KEY.

    METHODS fill_itab
           RETURNING
             VALUE(initial_data) TYPE itab_data_type.

    METHODS add_to_itab
           IMPORTING initial_data TYPE itab_data_type
           RETURNING
            VALUE(updated_data) TYPE itab_data_type.

    METHODS sort_itab
           IMPORTING initial_data TYPE itab_data_type
           RETURNING
            VALUE(updated_data) TYPE itab_data_type.

    METHODS search_itab
           IMPORTING initial_data TYPE itab_data_type
           RETURNING
             VALUE(result_index) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZMSC_CL_ITAB IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZMSC_CL_ITAB->ADD_TO_ITAB
* +-------------------------------------------------------------------------------------------------+
* | [--->] INITIAL_DATA                   TYPE        ITAB_DATA_TYPE
* | [<-()] UPDATED_DATA                   TYPE        ITAB_DATA_TYPE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD add_to_itab.
    DATA: w_initial_data LIKE LINE OF initial_data.

    updated_data = initial_data.

    w_initial_data-group = 'A'.
    w_initial_data-number = 19.
    w_initial_data-description = 'Group A-4'.

    APPEND w_initial_data to updated_data.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZMSC_CL_ITAB->FILL_ITAB
* +-------------------------------------------------------------------------------------------------+
* | [<-()] INITIAL_DATA                   TYPE        ITAB_DATA_TYPE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD fill_itab.
    initial_data = VALUE #( ( group = 'A' number = 10 description = 'Group A-2')
                            ( group = 'B' number = 5 description = 'Group B'  )
                            ( group = 'A' number = 6 description = 'Group A-1')
                            ( group = 'C' number = 22 description = 'Group C-1')
                            ( group = 'A' number = 13 description = 'Group A-3')
                            ( group = 'C' number = 500 description = 'Group C-2') ).
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZMSC_CL_ITAB->SEARCH_ITAB
* +-------------------------------------------------------------------------------------------------+
* | [--->] INITIAL_DATA                   TYPE        ITAB_DATA_TYPE
* | [<-()] RESULT_INDEX                   TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD search_itab.
    DATA(temp_data) = initial_data.

    READ TABLE temp_data WITH KEY number = 6 TRANSPORTING NO FIELDS.
    IF sy-subrc EQ 0.
      RESULT_INDEX = sy-tabix.
    ENDIF.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZMSC_CL_ITAB->SORT_ITAB
* +-------------------------------------------------------------------------------------------------+
* | [--->] INITIAL_DATA                   TYPE        ITAB_DATA_TYPE
* | [<-()] UPDATED_DATA                   TYPE        ITAB_DATA_TYPE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD sort_itab.
    updated_data = initial_data.

    SORT updated_data BY group ASCENDING number DESCENDING.
  ENDMETHOD.
ENDCLASS.