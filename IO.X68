*-----------------------------------------------------------
* Title      : Disassembler 
* Written by : Abhi Trivedi
* Date       : 02/17/2017
* Description: I/O part of the code 
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
             LEA MESSAGE1,A1
             MOVE.B  #14, D0
             TRAP    #15
                
             MOVEA.L $500,A1          ;This is where the string from the MESSAGE1 is stored
             MOVE.B  #2,D0            ;This picks the trap task for input of a string
             TRAP    #15
             CLR.L   D4
             MOVE.L  #28,D2           ;This is the number of bits that the first number needs to be shifted.
          

CONVERTSTRING MOVE.B    (A1)+,D0
              CMP.B     #$00,D0       ;This is making sure that we have reached the end of the string
              BEQ       STRINGEND
              CMP.B     #0,D2         ;This compare checks if the number of bits we are shifting is less than 0. 
              BLT       STRINGEND     ;if so then we have 8 valid characters
              CMP.W     #$0061,D0     ;This checks if its greater than 61 it is a lower case character or an invalid character
              BGE       LOWERCASE     ;Go to the LOWERCASE
              CMP.W     #$0041,D0     ;This checks if its greater than 41, it is an upper case or an invalid character
              BGE       UPPERCASE     ;Go to the UPPERCASE
              CMP.W     #$0030,D0     ;If D0 is greater than 30 then character is either invalid or a number
              BGE       NUMBER        ;Go to number
              BRA       CONVERTSTRING ;Go to the beginning of the loop
              
LOWERCASE     CMP.W     #$0066,D0     ;If the value is greater than $66, the character is invalid
              BGT       CONVERTSTRING ;Go to the CONVERTSTRING
              SUB       #87,D0        ;Converting from an ASCII value to its hex value
              LSL.L     D2,D0         ;Shifts the value in D0 to the right index
              ADD.L     D0,D3         ;Add D0 to the resulting hex value
              CLR.L     D0            ;Clear D0
              SUB.B     #4,D2         ;Subtract 4 from D2 to adjust number of bits to be shifted. 
              BRA       CONVERTSTRING ;Go back to the beginning of loop. 
              
UPPERCASE     CMP.B     #$0046,D0     ;If the value is greater than $46, the character is invalid. 
              BGT       CONVERTSTRING ;Go to the CONVERTSTRING
              SUB.B     #55,D0        ;Convert D0 from its ASCII to its hex value
              LSL.L     D2,D0
              ADD.L     D0,D3
              CLR.L     D0
              SUB.B     #4,D2
              BRA       CONVERTSTRING
              
             
NUMBER        CMP.B     #$0039,D0
              BGT       CONVERTSTRING
              SUB.B     #48,D0
              LSL.L     D2,D0
              ADD.L     D0,D3
              CLR.L     D0
              SUB.B     #4,D2
              BRA       CONVERTSTRING
              
STRINGEND     MOVE.L    D3,D4


CHECKADDRESS MOVE.B    (A1),D1
             MOVE.B    (A2),D2
             CMP.B      D2,D1
             BGT        ERRORMESSAGE
 
             LEA MESSAGE2,A2
             MOVE.B  #14,D0
             TRAP    #15
            
            


        
        
        
        
MESSAGE1 DC.B 'Please enter a starting address for your program',0
MESSAGE2 DC.B 'Please enter an ending address for your program',0
ERRORMESSAGE    DC.B 'Your ending address is greater than the starting address', 0

* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
