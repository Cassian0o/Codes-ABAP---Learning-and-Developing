CLASS zmsc_cl_two_fer DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS two_fer
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zmsc_cl_two_fer IMPLEMENTATION.

  METHOD two_fer.
   DATA(name) = input.
    IF name IS INITIAL.
      name = 'you'.
    ENDIF.
    result = |One for { name }, one for me.|.
    "Formata a string "One for [nome], one for me." usando o valor de 'name' e atribui o resultado à variável 'result'."
  ENDMETHOD.

ENDCLASS.
