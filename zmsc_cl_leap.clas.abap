CLASS zmsc_cl_leap DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS leap
      IMPORTING
        year          TYPE i
      RETURNING
        VALUE(result) TYPE abap_bool.
ENDCLASS.

CLASS zmsc_cl_leap IMPLEMENTATION.

  METHOD leap.

    IF ( year MOD 400 EQ 0 ) OR ( year MOD 4 EQ 0 AND year MOD 100 NE 0 ).

      result = abap_true.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
