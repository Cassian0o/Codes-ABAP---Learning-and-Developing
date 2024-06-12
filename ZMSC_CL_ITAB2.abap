CLASS zmsc_cl_itab2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS fill_itab
      RETURNING
        VALUE(initial_data) TYPE initial_numbers.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZMSC_CL_ITAB2 IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZMSC_CL_ITAB2->FILL_ITAB
* +-------------------------------------------------------------------------------------------------+
* | [<-()] INITIAL_DATA                   TYPE        INITIAL_NUMBERS
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD fill_itab.
    initial_data = VALUE #( ( group = 'A' number = 10 )
                            ( group = 'B' number = 5   )
                            ( group = 'A' number = 6 )
                            ( group = 'C' number = 22 )
                            ( group = 'A' number = 13 )
                            ( group = 'C' number = 500 ) ).
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZMSC_CL_ITAB2->PERFORM_AGGREGATION
* +-------------------------------------------------------------------------------------------------+
* | [--->] INITIAL_NUMBERS                TYPE        INITIAL_NUMBERS
* | [<-()] AGGREGATED_DATA                TYPE        AGGREGATED_DATA
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD perform_aggregation.
  DATA(lt_aggregated_data) = VALUE aggregated_data( ).

  LOOP AT initial_numbers ASSIGNING FIELD-SYMBOL(<fs_initial>).
    READ TABLE lt_aggregated_data ASSIGNING FIELD-SYMBOL(<fs_aggregated>)
      WITH KEY group = <fs_initial>-group.
    IF sy-subrc <> 0.

      APPEND VALUE aggregated_data_type(
        group   = <fs_initial>-group
        count   = 1
        sum     = <fs_initial>-number
        min     = <fs_initial>-number
        max     = <fs_initial>-number
      ) TO lt_aggregated_data ASSIGNING <fs_aggregated>.
    ELSE.

      <fs_aggregated>-count   += 1.
      <fs_aggregated>-sum     += <fs_initial>-number.

      IF <fs_initial>-number < <fs_aggregated>-min.
        <fs_aggregated>-min = <fs_initial>-number.
      ENDIF.
      IF <fs_initial>-number > <fs_aggregated>-max.
        <fs_aggregated>-max = <fs_initial>-number.
      ENDIF.
    ENDIF.
  ENDLOOP.

  LOOP AT lt_aggregated_data ASSIGNING <fs_aggregated>.
    <fs_aggregated>-average = <fs_aggregated>-sum / <fs_aggregated>-count.
  ENDLOOP.

  aggregated_data = lt_aggregated_data.
ENDMETHOD.
ENDCLASS.