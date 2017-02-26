*-----------------------------------------------------------
* Title      : Disassembler 
* Written by : Abhi Trivedi, Sam, Connor
* Date       : 02/26/2017
* Description: I/O part of the code 
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
             LEA MESSAGE0,A1
             MOVE.B  #14, D0
             TRAP    #15
GO_AGAIN
             CLR.L   D3
             CLR.L   D4
             LEA MESSAGE1,A1
             MOVE.B  #14, D0
             TRAP    #15
             MOVEA.L #$500,A1          ;This is where the string from the MESSAGE1 is stored
             MOVE.B  #2,D0            ;This picks the trap task for input of a string
             TRAP    #15
             JSR    HEXINPUT
             MOVE.L  D3,D4
             CLR.L   D3
             LEA MESSAGE2,A1
             MOVE.B  #14,D0
             TRAP    #15
             MOVEA.L #$500,A1          ;This is where the string from the MESSAGE1 is stored
             MOVE.B  #2,D0            ;This picks the trap task for input of a string
             TRAP    #15
             JSR    HEXINPUT
CHECKADDRESS 
             CMP.L      D4,D3
             BLT        OUTPUT_ERRORMESSAGE1
             MOVEA.L     D4,A2
             MOVEA.L     D3,A3
             MOVE.L      A2,D2
             JSR         OUTPUT_HEXADECIMAL
             MOVE.L      A3,D2
             JSR         OUTPUT_HEXADECIMAL
             
ENDMESSAGE  
            LEA     ENDOFPROGRAM,A1
            MOVE.B  #14,D0
            TRAP    #15
            MOVE.B  #5,D0
            TRAP    #15
            LEA     NEWLINE,A1
            MOVE.B  #14,D0
            TRAP    #15
            CMP.B   #'y',D1
            BEQ     GO_AGAIN
            CMP.B   #'n',D1
            BEQ     QUIT
            BRA     ENDMESSAGE

REMOVE_ZEROS_START                      ;Used by Output Hexadecimal. Assumes value isn't zero, because that subroutine checks if it is.
             MOVE.L     D5,-(SP)        ;Restoring the values stored in the Stack
REMOVE_ZEROS                            ;Removing the leading zeros
             MOVE.L     D3,D5
             LSR.L      D4,D5
             AND.B      #$0F,D5
             CMP.B      #0,D5
             BEQ        REMOVE_ZERO
             MOVE.L     (SP)+,D5
             RTS
             
REMOVE_ZERO
             SUB.B      #4,D4          
             BRA        REMOVE_ZEROS    
OUTPUT_HEXADECIMAL  *Subroutine for outputting a hexadecimal number.
            MOVEM.L D3-D4,-(SP)
            CMP.L   #0,D2
            BEQ     OUTPUT0
            MOVE.L  D2,D3
            MOVE.L  #28,D4
            JSR     REMOVE_ZEROS_START
            LSR.L   D4,D3
            MULU    #6,D3
            LEA     OUTPUT_CHAR,A0
            JSR     0(A0,D3)

OUTPUT_LOOP  
            SUB.B   #4,D4   ;Changes the amount we are shifting by, in this case by 4
            CMP.B   #0,D4
            BLT     RETURN_CASE
            MOVE.L  D2,D3
            LSR.L   D4,D3
            AND.L   #$0F,D3 ;We are getting rid of everything that isn't the last 4 bits.
            MULU    #6,D3
            JSR     0(A0,D3)
            BRA     OUTPUT_LOOP
RETURN_CASE 
            MOVEM.L (SP)+,D3-D4
            RTS            
            
OUTPUT_CHAR JMP     OUTPUT0
            JMP     OUTPUT1
            JMP     OUTPUT2
            JMP     OUTPUT3
            JMP     OUTPUT4
            JMP     OUTPUT5
            JMP     OUTPUT6
            JMP     OUTPUT7
            JMP     OUTPUT8
            JMP     OUTPUT9
            JMP     OUTPUTA
            JMP     OUTPUTB
            JMP     OUTPUTC
            JMP     OUTPUTD
            JMP     OUTPUTE
            JMP     OUTPUTF
                     
            
OUTPUT0     
            MOVE.B  #'0',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window
            RTS
            
OUTPUT1    
            MOVE.B  #'1',D1    ;Moves the character into D1   
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window
            RTS

OUTPUT2
            MOVE.B  #'2',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window
            RTS

OUTPUT3
            MOVE.B  #'3',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window
            RTS          

OUTPUT4
            MOVE.B  #'4',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window
            RTS

OUTPUT5
            MOVE.B  #'5',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window
            RTS

OUTPUT6
            MOVE.B  #'6',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window
            RTS

OUTPUT7
            MOVE.B  #'7',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window
            RTS

OUTPUT8
            MOVE.B  #'8',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window
            RTS

OUTPUT9 
           MOVE.B  #'9',D1    ;Moves the character into D1
           MOVE.B  #6,  D0    ;This trap task prints out character in D1
           TRAP    #15        ;This outputs to the output window
           RTS

OUTPUTA
           MOVE.B  #'A',D1    ;Moves the character into D1
           MOVE.B  #6,  D0    ;This trap task prints out character in D1
           TRAP    #15        ;This outputs to the output window
           RTS

OUTPUTB
           MOVE.B  #'B',D1    ;Moves the character into D1
           MOVE.B  #6,  D0    ;This trap task prints out character in D1
           TRAP    #15        ;This outputs to the output window
           RTS

OUTPUTC
           MOVE.B  #'C',D1    ;Moves the character into D1
           MOVE.B  #6,  D0    ;This trap task prints out character in D1
           TRAP    #15        ;This outputs to the output window
           RTS

OUTPUTD
            MOVE.B  #'D',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window
            RTS

OUTPUTE
            MOVE.B  #'E',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window
            RTS

OUTPUTF
            MOVE.B  #'F',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window
            RTS
            
               
HEXINPUT             
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
              
STRINGEND     RTS 

            
            


OUTPUT_ERRORMESSAGE1
              LEA    ERRORMESSAGE1,A1
              MOVE.B  #14, D0
              TRAP    #15   
              BRA    GO_AGAIN              
CR      EQU     $0D             ASCII code for Carriage Return
LF      EQU     $0A             ASCII code for Line Feed 
MESSAGE0         DC.B 'Welcome to Disassembler.',CR,LF,'Created by: Abhi Trivedi, Conor Van Achte, and Samuel Meyerding.',CR,LF,0       
MESSAGE1         DC.B 'Please enter a starting address for your program: ',0
MESSAGE2         DC.B 'Please enter an ending address for your program: ',0
ERRORMESSAGE1    DC.B 'Your ending address is less than the starting address',CR,LF,0
ENDOFPROGRAM     DC.B 'Do you want to disassemble some more memory? (y/n)',CR,LF,0
NEWLINE          DC.B CR,LF,0
    
QUIT

* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
