CLASS zmsc_cl_raindrops DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS raindrops
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zmsc_cl_raindrops IMPLEMENTATION.

METHOD raindrops.
    result = ''.

    IF input MOD 3 = 0.
      result = result && 'Pling'.
    ENDIF.

    IF input MOD 5 = 0.
      result = result && 'Plang'.
    ENDIF.

    IF input MOD 7 = 0.
      result = result && 'Plong'.
    ENDIF.

    IF result = ''.
      result = input.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
