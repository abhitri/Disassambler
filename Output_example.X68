*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
       MOVE.B   #' ',D1 *Setting value in D1 to literal value for a space character.
       MOVE.B   #6,D0   *Picking TRAP task #6. 
       TRAP     #15     *Output individual character.
       MOVE.B   #'#',D1 *Setting value in D1 to literal value for a pound character.
       TRAP     #15     *Output individual character.
       MOVE.B   #'-',D1 *Setting value in D1 to literal value for a minus character.
       TRAP     #15     *Output individual character.
       MOVE.L   #'+',D1 *Setting value in D1 to literal value for a plus character.
       TRAP     #15     *Output individual character.
       MOVE.L   #',',D1 *Setting value in D1 to literal value for a comma character.
       TRAP     #15     *Output individual character.
       MOVE.L   #')',D1 *Setting value in D1 to literal value for a closing parenthesis character.
       TRAP     #15     *Output individual character.
       MOVE.L   #'(',D1 *Setting value in D1 to literal value for an opening parenthesis character.
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
