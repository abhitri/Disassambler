*-----------------------------------------------------------
* Title      : Disassembler 
* Written by : Abhi Trivedi, Sam, Connor
* Date       : 02/26/2017
* Description: I/O part of the code 
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
             LEA MESSAGE1,A1
             MOVE.B  #14, D0
             TRAP    #15
             MOVEA.L #$500,A1          ;This is where the string from the MESSAGE1 is stored
             MOVE.B  #2,D0            ;This picks the trap task for input of a string
             TRAP    #15
             JSR    HEXINPUT

             LEA MESSAGE2,A1
             MOVE.B  #14,D0
             TRAP    #15
             MOVEA.L #$500,A1          ;This is where the string from the MESSAGE1 is stored
             MOVE.B  #2,D0            ;This picks the trap task for input of a string
             TRAP    #15
             JSR    HEXINPUT

CHECKADDRESS 
             MOVE.L    D3,D4
             CMP.L      D3,D4
             BGT        ERRORMESSAGE1
             
OUTPUT_HEXADECIMAL  
            CMP.L   #0,D2
            BEQ     OUTPUT0
            MOVE.L  D2,D3
            MOVE.L  #28,D4
            LSR.L   D4,D3
            MULU    #6,D3
            LEA     OUTPUT_CHAR,A0
            JSR     0(A0,D3)

OUTPUT_LOOP  
            SUB.B   #4,D4   ;Changes the amount we are shifting by, in this case by 4
            CMP.L   #0,D4
            BLT     RETURN_CASE
            MOVE.L  D2,D3
            LSR.L   D4,D3
            AND.B   #$0F,D3 ;We are getting rid of everything that isn't the last 4 bits. 
            JSR     0(A0,D3)

RETURN_CASE RTS
            
            

            
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
        
            
OUTPUT1    
            MOVE.B  #'1',D1    ;Moves the character into D1   
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window


OUTPUT2
            MOVE.B  #'2',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window

OUTPUT3
            MOVE.B  #'3',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window
 
            

OUTPUT4
            MOVE.B  #'4',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window


OUTPUT5
            MOVE.B  #'5',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window


OUTPUT6
            MOVE.B  #'6',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window


OUTPUT7
            MOVE.B  #'7',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window


OUTPUT8
            MOVE.B  #'8',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window


OUTPUT9 
           MOVE.B  #'9',D1    ;Moves the character into D1
           MOVE.B  #6,  D0    ;This trap task prints out character in D1
           TRAP    #15        ;This outputs to the output window


OUTPUTA
           MOVE.B  #'A',D1    ;Moves the character into D1
           MOVE.B  #6,  D0    ;This trap task prints out character in D1
           TRAP    #15        ;This outputs to the output window


OUTPUTB
           MOVE.B  #'B',D1    ;Moves the character into D1
           MOVE.B  #6,  D0    ;This trap task prints out character in D1
           TRAP    #15        ;This outputs to the output window

OUTPUTC
           MOVE.B  #'C',D1    ;Moves the character into D1
           MOVE.B  #6,  D0    ;This trap task prints out character in D1
           TRAP    #15        ;This outputs to the output window
 

OUTPUTD
            MOVE.B  #'D',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window


OUTPUTE
            MOVE.B  #'E',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window


OUTPUTF
            MOVE.B  #'F',D1    ;Moves the character into D1
            MOVE.B  #6,  D0    ;This trap task prints out character in D1
            TRAP    #15        ;This outputs to the output window

            
               
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

            
            


        
        
        
        
MESSAGE1         DC.B 'Please enter a starting address for your program',0
MESSAGE2         DC.B 'Please enter an ending address for your program',0
ERRORMESSAGE1    DC.B 'Your ending address is greater than the starting address',0
ERRORMESSAGE2    DC.B 'Your starting address is less than the ending address',0


* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
