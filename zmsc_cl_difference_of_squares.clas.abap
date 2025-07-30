CLASS zmsc_cl_difference_of_squares DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      ret_difference_of_squares IMPORTING num         TYPE i
                                RETURNING VALUE(diff) TYPE i,
      ret_sum_of_squares        IMPORTING num                   TYPE i
                                RETURNING VALUE(sum_of_squares) TYPE i,
      ret_square_of_sum         IMPORTING num                  TYPE i
                                RETURNING VALUE(square_of_sum) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmsc_cl_difference_of_squares IMPLEMENTATION.
  METHOD ret_difference_of_squares.
    "Diferença entre o Square Of Sum e Sum of squares.
    Data: lv_result_square_of_sum  TYPE i,
          lv_result_sum_of_squares TYPE i.

    lv_result_square_of_sum = me->ret_square_of_sum( num ).
    lv_result_sum_of_squares = me->ret_sum_of_squares( num ).

    diff = lv_result_square_of_sum - lv_result_sum_of_squares.

  ENDMETHOD.

  METHOD ret_sum_of_squares.
      
    sum_of_squares = 0.

    DO num TIMES.
      
      sum_of_squares = sum_of_squares + ( sy-index * sy-index ).

    ENDDO.
  ENDMETHOD.

  METHOD ret_square_of_sum.

    Data: lv_sum TYPE i.
    
    DO num TIMES.

      lv_sum = lv_sum + sy-index.

    ENDDO.

    square_of_sum = lv_sum * lv_sum.

  ENDMETHOD.
ENDCLASS.
