CLASS zmsc_cl_scrabble_score DEFINITION PUBLIC. 

     PUBLIC SECTION. 

        METHODS score 

            IMPORTING 

                input TYPE string OPTIONAL  
            RETURNING 

                VALUE(result) TYPE i.     

    PROTECTED SECTION.

    PRIVATE SECTION.

ENDCLASS.


CLASS msc_ IMPLEMENTATION. 

    METHOD score.


        DATA(sum) = 0.    "Variável local para armazenar a soma dos pontos

        DO strlen( input ) TIMES. 

            DATA(c) = to_upper( substring( val = input off = sy-index - 1 len = 1 ) ). 

            "Obtém um caractere da string de entrada, converte para maiúscula e armazena na variável c.
            "substring extrai um pedaço da string, off é a posição de início, len o número de caracteres.

            DATA(lv_value) = COND #(

                "Utiliza uma expressão COND para determinar o valor do caractere c.

                WHEN c CA 'AEIOULNRST' THEN 1     "Se c está entre as letras 'AEIOULNRST', vale 1 ponto.
                WHEN c CA 'DG' THEN 2               "Se c está entre as letras 'DG', vale 2 pontos.
                WHEN c CA 'BCMP' THEN 3             "Se c está entre as letras 'BCMP', vale 3 pontos.
                WHEN c CA 'FHVWY' THEN 4             "Se c está entre as letras 'FHVWY', vale 4 pontos.
                WHEN c CA 'K' THEN 5                 "Se c é a letra 'K', vale 5 pontos.
                WHEN c CA 'JX' THEN 8                 "Se c está entre as letras 'JX', vale 8 pontos.
                WHEN c CA 'QZ' THEN 10                "Se c está entre as letras 'QZ', vale 10 pontos.
                ELSE 0                               "Caso contrário, vale 0 pontos.
            ).

            sum = sum + lv_value.  "Adiciona o valor do caractere à soma total.

        ENDDO.  

        result = sum.    "Atribui a soma total (a pontuação calculada) ao resultado.

    ENDMETHOD.  
ENDCLASS.    "Fim da implementação da classe
