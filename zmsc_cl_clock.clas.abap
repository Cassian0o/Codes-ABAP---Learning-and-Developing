CLASS zmsc_cl_clock DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !hours   TYPE i
        !minutes TYPE i DEFAULT 0.

    METHODS get
      RETURNING
        VALUE(result) TYPE string.

    METHODS add
      IMPORTING
        !minutes TYPE i.

    METHODS sub
      IMPORTING
        !minutes TYPE i.

  PRIVATE SECTION.

    DATA hours   TYPE i.
    DATA minutes TYPE i.

    METHODS normalize.

ENDCLASS.



CLASS zmsc_cl_clock IMPLEMENTATION.

  METHOD constructor.

    me->hours = hours.
    me->minutes = minutes.

    me->normalize( ).
  ENDMETHOD.

  METHOD add.

    me->minutes = me->minutes + minutes.

    me->normalize( ).
  ENDMETHOD.

  METHOD sub.

    me->minutes = me->minutes - minutes.


    me->normalize( ).
  ENDMETHOD.

  METHOD get.

  DATA: lv_hours   TYPE string,
          lv_minutes TYPE string.

    IF me->hours < 10.
      lv_hours = |0{ me->hours }|.
    ELSE.
      lv_hours = |{ me->hours }|.
    ENDIF.

    IF me->minutes < 10.
      lv_minutes = |0{ me->minutes }|.
    ELSE.
      lv_minutes = |{ me->minutes }|.
    ENDIF.

    result = |{ lv_hours }:{ lv_minutes }|.
  ENDMETHOD.

  METHOD normalize.
    DATA: lv_total_minutes  TYPE i,
          lv_minutes_in_day TYPE i VALUE 1440.

    lv_total_minutes = ( me->hours * 60 + me->minutes ) MOD lv_minutes_in_day.

    IF lv_total_minutes < 0.
      lv_total_minutes = lv_total_minutes + lv_minutes_in_day.
    ENDIF.

    me->hours = lv_total_minutes DIV 60. 
    me->minutes = lv_total_minutes MOD 60.
  ENDMETHOD.

ENDCLASS.
