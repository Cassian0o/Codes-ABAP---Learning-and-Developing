CLASS zcl_itab_combination DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF alphatab_type,
             cola TYPE string,
             colb TYPE string,
             colc TYPE string,
           END OF alphatab_type.
    TYPES alphas TYPE STANDARD TABLE OF alphatab_type.

    TYPES: BEGIN OF numtab_type,
             col1 TYPE string,
             col2 TYPE string,
             col3 TYPE string,
           END OF numtab_type.
    TYPES nums TYPE STANDARD TABLE OF numtab_type.

    TYPES: BEGIN OF combined_data_type,
             colx TYPE string,
             coly TYPE string,
             colz TYPE string,
           END OF combined_data_type.
    TYPES combined_data TYPE STANDARD TABLE OF combined_data_type WITH EMPTY KEY.

    METHODS perform_combination
      IMPORTING
        alphas             TYPE alphas
        nums               TYPE nums
      RETURNING
        VALUE(combined_data) TYPE combined_data.

  PROTECTED SECTION.
  PRIVATE SECTION.


ENDCLASS.

CLASS zcl_itab_combination IMPLEMENTATION.

  METHOD perform_combination.
  
    DATA alpha_index TYPE sy-tabix VALUE 1.
    DATA nums_index TYPE sy-tabix VALUE 1.
    
    " Verify if tables had the same number of rows.
    IF lines( alphas ) <> lines( nums ).
      RAISE EXCEPTION TYPE cx_sy_itab_line_not_found.
    ENDIF.

    " While the index of the alphabet and number tables are lower or equal to the number of lines of the tables. 
    WHILE alpha_index <= lines( alphas ) AND nums_index <= lines( nums ).

      combined_data = VALUE #( BASE combined_data (
        colx = alphas[ alpha_index ]-cola && nums[ nums_index ]-col1
        coly = alphas[ alpha_index ]-colb && nums[ nums_index ]-col2
        colz = alphas[ alpha_index ]-colc && nums[ nums_index ]-col3
      ) ).

      alpha_index = alpha_index + 1.
      nums_index = nums_index + 1.

    ENDWHILE. 

  ENDMETHOD.

ENDCLASS.
