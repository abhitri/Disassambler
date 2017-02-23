*-----------------------------------------------------------
* Title      : Disassembler test.
* Written by : Samuel Meyerding, Conor Van Achte, Abhi Trivedi
* Date       : January 22nd, 2017
* Description: Disassembler prototype.
*              
*              
*-----------------------------------------------------------

NOP_CODE    EQU     %0100111001110001     
RTS_CODE    EQU     %0100111001110101
TRAP_CODE   EQU     %0100111001000000   *The left 12 bits do not vary.
   
    ORG     $1000
START:                  ; first instruction of program

*Testing Code
        
       *ADDA.L   #$11111111,A2
       *ADDA.L   #$1111,A2
       *ADDA.W   #223,A2
       *ADDA.L   A1,A2
       *ADDA.L   D1,A2
       *ADDA.L   #2,A2
       *ADDA.L   #223,A2
       *ADDA.W   A5,A7
       *ADDA.W   A2,A5
       
       *BTST     #0,D1
       *BTST     #6,(A6)
       *BTST     #12,(A5)+
       *BTST     #3,-(A4)
       *BTST     #2,$1234
       *BTST     #7,$12341234
      *BTST     D2,D7
      *BTST     D3,#4
       
       *ADD.L    D1,D2
       *ADD.B    D5,D7
       *ADD.W    D3,D4
       *ADD.L    #34,D6
       *ADDA.L   A1,A2
       *MULS.W   D1,D2
       
       *ADDI.L   #2,D1
       *ADDI.W   #4,D6
       *ADDI.B   #4,D7
       *ADDI.W   #8,D3
       *ADDI.W   #1,D2
       *ADDI.B   #8,D5
       *ADDI.B   #3,D1
       *ADDI.B   #127,D1
* All have been tested.      
       *ADD.L    D1,D2
       *ADD.B    D5,D7
       *ADD.W    D3,D4
       *ADD.L    #34,D6
       *ADDA.L   A1,A2
       *MULS.W   D1,D2

* All have been tested.
       *NOP
       BRA     SKIP        *6000   Condition: %0000
       *BCC     SKIP        *6400   Condition: %0100
       *BCC     INPUT        *6400   Condition: %0100
       *BCS     SKIP        *6500   Condition: %0101
       *BEQ     SKIP        *6700   Condition: %0111
       *BGE     SKIP        *6C00   Condition: %1100
       *BGT     SKIP        *6E00   Condition: %1110
       *BHI     SKIP        *6200   Condition: %0010
       *BLE     SKIP        *6F00   Condition: %1111
       *BLS     SKIP        *6300   Condition: %0011
       *BLT     SKIP        *6D00   Condition: %1101
       *BMI     SKIP        *6B00   Condition: %1011
       *BNE     SKIP        *6600   Condition: %0110
       *BPL     SKIP        *6A00   Condition: %1010
       *BVC     SKIP        *6800   Condition: %1000
       *BVS     SKIP        *6900   Condition: %1001
       


* All have been tested.
       *AND.W    D1,D2
       *BTST     D1,#4
       LSL.W    D1,D2
       LSR.W    D1,D2
       ASL.W    D1,D2
       ASR.W    D1,D2
       ROL.W    D1,D2
       ROR.W    D1,D2
       LSL.W    $0
       LSR.W    $0
       ASL.W    $0
       ASR.W    $0
       ROL.W    $0
       ROR.W    $0

       OR.L     D1,D0
       SUB.L    D0,D1
       CMP.W    D1,D2
       BTST     #0,D1
       BTST     #0,(A6)
       BRA      SKIP
       BTST     #0,(A5)+
       MOVE.W   D0,D1
       MOVEA.L  A0,A1
       ADDI.L   #4,D1   *Assembler changes this to ADDQ unless the number being added is greater than #8.
       ADDI.L   #9,D1
       ADDI.W   #4,D1
       ADDI.B   #4,D1
       ADDI.W   #8,D1
       ADDI.W   #9,D1
       ADDI.B   #8,D1
       ADDI.B   #9,D1
       ADDI.B   #127,D1
       LEA      B_MESS,A4
       CLR.L    D1
       JSR      DUMMY_SUB
       MOVEM.L  (A1),D0-D1
       ADDQ.B   #1,D0
       MOVEQ.L  #1,D1
       DIVU.W   D1,D0
      
INPUT        LEA MESSAGE1,A1
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


             LEA MESSAGE2,A1
             MOVE.B  #14,D0
             TRAP    #15
             MOVEA   D3,A2
             BRA     RELOOP
                
SKIP                                  
    MOVE.L  #$1000,A2       *Starting address for code to be disassembled.
    MOVE.L  #$2000,A3
RELOOP
    CMP.L   A2,A3
    BEQ     DIS_END
    LEA     NEXT_LINE,A1 
    MOVE.B  #14,D0      
    TRAP    #15        
    MOVE.W  (A2)+,D1        *Moves the value at address A2 into D1.
    CMP.W   #NOP_CODE,D1    *NOP has a static value, so a direct comparison will find if the OPCode is NOP
    BEQ     NOP_SECT        *Output 'NOP' if the OPCode == #NOP_CODE
    CMP.W   #RTS_CODE,D1    *RTS has a static value, so a direct comparison will find if the OPCode is RTS
    BEQ     RTS_SECT        *Output 'RTS' if the OPCode == #RTS_CODE
FIRST_BIT
    BTST    #15,D1          *Test the first bit of the OPCODE to eliminate possibilites that start with a different value in the first bit.
    BNE     BIN_1_SECOND    *Any OPCode that starts with 1 will Branch to this.
BIN_0_SECOND    *Possibilites are MOVE, MOVEA, ADDI, MOVEQ, MOVEM, ADDQ, LEA, CLR, Bcc, and JSR
    BTST    #14,D1          *The first bit at this point is not set. Testing the second will allow elimination of possibilities.
    BNE     BIN_01_THIRD    *If this branch is taken, only pssibilities beginning with 01 are valid. Else, continue to 00.    
BIN_00_THIRD    *Possibilites are MOVE, MOVEA, and ADDI.
    MOVE.W  D1,D2                   *Create a copy of D1 in D2 in order to mask some of its bits and keep original.
    AND.W   #%0011000000000000,D2   *These bits are required to immediately tell if this OPCode is ADDI. 
    CMP.W   #%0000000000000000,D2   *Compare with value that would be true if Code is ADDI or BTST.
    BEQ     BIN_0000_FOURTH               *Go to output ADDI_MESS.
    MOVE.W  D1,D2                   *Create a copy of D1 in D2 in order to mask some of its bits and keep original.
    AND.B   #%00111000,D2           *These bits are required to differentiate between MOVE and MOVEA. 
    CMP.B   #%00001000,D2           *Compare with value that would be true if Code is MOVEA.
    BEQ     MOVEA_SECT              *Go to output MOVEA_MESS. Else, continue to MOVE_SECT.
MOVE_SECT                           *Outputs the message 'MOVE.'.
    LEA     MOVE_MESS,A1 
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.B  #%11111111,D7           *Valid modes for this OPCode (SourceEA).
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity.
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.B  #%11110101,D7           *Valid modes for this OPCode (SourceEA).
    JSR     DEST_EFF_ADDR_MODE_REG   *Check value in mode for validity.
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.B  #%11101101,D3           *Shift count of 13 for VALIDATE_SIZE and any size accepted.
    JSR     VALIDATE_SIZE_MOVELIKE  *Subroutine for validating size portion of OPCode.
    BTST    #0,D3                   *Checking result of subroutine's check for valid SIZE bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JMP     RELOOP
BIN_0000_FOURTH  *Possibilities are ADDI and BTST.
    BTST    #11,D1
    BNE     BTST_STATIC_SECT
    BTST    #8,D1
    BNE     BTST_DYNAMIC_SECT
ADDI_SECT                   *Outputs the message 'ADDI.'.
    LEA     ADDI_MESS,A1 
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.W  D1,D3                   *Copy OPCode into D3 in order to allow for isolation of bits.
    AND.W   #%1111111100000000,D3
    CMP.W   #%0000011000000000,D3
    BNE     PRINT_INVALID_OPCODE
    MOVE.B  #%11110101,D7           *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity.
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.B  #%11100111,D3           *Shift count of 7 for VALIDATE_SIZE, and any size accepted.
    JSR     VALIDATE_SIZE_CLRLIKE   *Subroutine for validating size portion of OPCode.
    BTST    #0,D3                   *Checking result of subroutine's check for valid SIZE bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    
    JSR     ADD_SIZE  
    MOVE.B  #' ',D1 *Setting value in D1 to literal value for a space character.
    MOVE.B  #6,D0   *Picking TRAP task #6. 
    TRAP    #15     *Output individual character.
    MOVE.B  #'#',D1 *Setting value in D1 to literal value for a space character.
    TRAP    #15   
    

    MOVE.L  D6,D1
    CLR.L   D2
    MOVE.B  #10,D2
    MOVE.B  #15,D0
    TRAP    #15

    MOVE.B  #',',D1 *Setting value in D1 to literal value for a space character.
    MOVE.B  #6,D0   *Picking TRAP task #6. 
    TRAP    #15     *Output individual character.
    MOVE.B  D4,D1
    BTST    #5,D1
    BNE     VALID_MODE_1_JSR
    JSR     VALID_MODE_0
    
    JMP     RELOOP
VALID_MODE_1_JSR
    JSR     VALID_MODE_1
    JMP     RELOOP    
ADD_SIZE
    BTST    #7,D1
    BNE     ADD_SIZE_LONG
    BTST    #6,D1
    BNE     ADD_SIZE_WORD
    
    MOVE.L  D1,D4
    MOVE.B  #'B',D1 *Setting value in D1 to literal value for a B character.
    MOVE.B  #6,D0   *Picking TRAP task #6. 
    TRAP    #15     *Output individual character.
    MOVE.W  (A2)+,D6
    
    
    RTS
    
    
ADD_SIZE_WORD
    MOVE.L  D1,D4
    MOVE.B  #'W',D1 *Setting value in D1 to literal value for a W character.
    MOVE.B  #6,D0   *Picking TRAP task #6. 
    TRAP    #15     *Output individual character.
    MOVE.W  (A2)+,D6


    RTS    
    
ADD_SIZE_LONG
    CLR.L   D4
    MOVE.L  D1,D4
    MOVE.B  #'L',D1 *Setting value in D1 to literal value for a L character.
    MOVE.B  #6,D0   *Picking TRAP task #6. 
    TRAP    #15     *Output individual character.
    MOVE.L  (A2)+,D6

    RTS
    
BIN_01_THIRD    *Possibilities are MOVEQ, MOVEM, ADDQ, LEA, CLR, Bcc, and JSR.
    MOVE.W  D1,D2
    AND.W   #%1111111111110000,D2
    CMP.W   #TRAP_CODE,D2
    BEQ     TRAP_SECT
    BTST    #13,D1                  *If this bit is set, then the OPCode is either Bcc or MOVEQ.
    BNE     BIN_011_FOURTH          *Eliminates Bcc and MOVEQ as possibilities if code reaches past this.
BIN_010_FOURTH  *Possibilities are MOVEM, ADDQ, LEA, CLR, JSR.
    BTST    #12,D1
    BNE     ADDQ_SECT
BIN_0100_FIFTH  *Possibilities are MOVEM, LEA, CLR, JSR.
    MOVE.W  D1,D2                   *Create a copy of D1 in D2 in order to mask some of its bits and keep original.
    AND.W   #%0000101100000000,D2   *These bits will tell me if this is MOVEM.
    CMP.W   #%0000100000000000,D2   *Compare with the values that would be set for MOVEM
    BEQ     MOVEM_SECT              *Possibilities are now LEA, CLR, and JSR.
    BTST    #8,D1                   *If this bit is set, then the instruction can only be LEA.
    BNE     LEA_SECT                *Possibilities are now CLR and JSR.
    BTST    #11,D1                  *If this bit is set, then the instruction can only be JSR.
    BNE     JSR_SECT                *Only possibility is now CLR.
CLR_SECT
    LEA     CLR_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.B  #%11110101,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity.
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.B  #%11100111,D3           *Shift count of 7 for VALIDATE_SIZE, and any size accepted.
    JSR     VALIDATE_SIZE_CLRLIKE   *Subroutine for validating size portion of OPCode.
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111111100000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%0100001000000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    JMP     RELOOP           
    
BIN_011_FOURTH  *Possibilities are Bcc and MOVEQ.
    BTST    #12,D1
    BNE     MOVEQ_SECT
*Condition Section.**********************************************

B_COND_SECT     *It has been determined to be a Conditional Branch. Now to determine the condition.
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000000000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%0110000000000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    BTST    #11,D1          
    BNE     Bcc_1_SECT
Bcc_0_SECT      *First bit of condition is 0.
    BTST    #10,D1
    BNE     Bcc_01_SECT
Bcc_00_SECT     *First bits of condition are 00.
    BTST    #9,D1
    BNE     Bcc_001_SECT
BRA_SECT        *First bits of condition are 0000. This means BRA.
    LEA     BRA_MESS,A1     *Outputs the message 'BRA'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
Bcc_001_SECT    *First bits of condition are 001.
    BTST    #8,D1
    BNE     BLS_SECT
BHI_SECT        *First bits of condition are 0010. This means BHI.
    LEA     BHI_MESS,A1     *Outputs the message 'BHI'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
Bcc_01_SECT     *First bits of condition are 01.
    BTST    #9,D1
    BNE     Bcc_011_SECT
Bcc_010_SECT    *First bits of condition are 010.
    BTST    #8,D1
    BNE     BCS_SECT
BCC_SECT        *First bits of condition are 0100. This means BCC.
    LEA     BCC_MESS,A1     *Outputs the message 'BCC'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
Bcc_011_SECT    *First bits of condition are 011.
    BTST    #8,D1
    BNE     BEQ_SECT
BNE_SECT        *First bits of condition are 0110. This means BNE.
    LEA     BNE_MESS,A1     *Outputs the message 'BNE'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
Bcc_1_SECT      *First bit of condition is 1.
    BTST    #10,D1
    BNE     Bcc_11_SECT
Bcc_10_SECT     *First bits of condition are 10.
    BTST    #9,D1
    BNE     Bcc_101_SECT
Bcc_100_SECT    *First bits of condition are 100.
    BTST    #8,D1
    BNE     BVS_SECT
BVC_SECT        *First bits of condition are 1000. This means BVC.
    LEA     BVC_MESS,A1     *Outputs the message 'BVC'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
Bcc_101_SECT    *First bits of condition are 101.
    BTST    #8,D1
    BNE     BMI_SECT
BPL_SECT        *First bits of condition are 1010. This means BPL.
    LEA     BPL_MESS,A1     *Outputs the message 'BPL'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
Bcc_11_SECT     *First bits of condition are 11.
    BTST    #9,D1
    BNE     Bcc_111_SECT
Bcc_110_SECT    *First bits of condition are 110.
    BTST    #8,D1
    BNE     BLT_SECT
BGE_SECT        *First bits of condition are 1100. This means BGE.
    LEA     BGE_MESS,A1     *Outputs the message 'BGE'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
Bcc_111_SECT    *First bits of condition are 111.
    BTST    #8,D1
    BNE     BLE_SECT
BGT_SECT
    LEA     BGT_MESS,A1     *Outputs the message 'BGT'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
BLS_SECT
    LEA     BLS_MESS,A1     *Outputs the message 'BLS'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
BCS_SECT
    LEA     BCS_MESS,A1     *Outputs the message 'BCS'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
BVS_SECT
    LEA     BVS_MESS,A1     *Outputs the message 'BVS'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
BEQ_SECT
    LEA     BEQ_MESS,A1     *Outputs the message 'BEQ'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
BLT_SECT
    LEA     BLT_MESS,A1     *Outputs the message 'BLT'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
BLE_SECT
    LEA     BLE_MESS,A1     *Outputs the message 'BLE'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP    
BMI_SECT
    LEA     BMI_MESS,A1     *Outputs the message 'BMI'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP

*End of Condition Section **********************************************

BIN_1_SECOND    *Possibilities are SUB, DIVU, OR, CMP ADD, ADDA, MULS, AND, LSL, LSR, ASR, ASL, ROL, and ROR.
    BTST    #14,D1
    BNE     BIN_11_THIRD 
BIN_10_THIRD    *Possibilities are SUB, DIVU, OR, and CMP.
    BTST    #13,D1          *If this bit is set, then the OPCode is CMP.
    BNE     CMP_SECT        *Go to output CMP_MESS. Else, continue to BIN_100_FOURTH    
BIN_100_FOURTH  *Possibilities are SUB, DIVU, and OR.
    BTST    #12,D1          *If this bit is set, then the OPCode is SUB
    BNE     SUB_SECT        *Go to output SUB.
    MOVE.B  D1,D2           *Create a copy of D1 in D2 in order to mask some of its bits and keep original.
    AND.W   #%0000000111000000,D2    *These bits are required to tell the difference between OR and DIVU.
    CMP.W   #%0000000011000000,D2    *Compare with value that would be true if Code is DIVU.
    BEQ     DIVU_SECT       *Go to output DIVU_MESS. Else, continue to OR_SECT.
OR_SECT         *Output the message 'OR.'.
    LEA     OR_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000000000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%1000000000000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    JSR     VALIDATE_OPMODE_FIELD   *Subroutine validates OPMode field of subroutine.
    BTST    #0,D3                   *Checking result of subroutine's check for valid OPMode.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    BTST    #8,D1
    BNE     OR_DN_EA
OR_EA_DN                        *This is OR with the OPMode bieng <ea> -> Dn
    MOVE.B  #%11111111,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JMP     RELOOP 
OR_DN_EA                        *This is OR with the OPMode bieng Dn -> <ea>
    MOVE.B  #%11110100,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JMP     RELOOP
    
BIN_11_THIRD    *Possibilities are ADD, ADDA, MULS, AND, LSL, LSR, ASR, ASL, ROL, and ROR.
    BTST    #13,D1
    BNE     BIN_111_FOURTH
BIN_110_FOURTH  *Possibilities are ADD, ADDA, MULS, and AND.
    BTST    #12,D1
    BNE     BIN_1101_FOURTH
BIN_1100_FOURTH *Possibilities are MULS and AND.
    MOVE.B  D1,D2           *Create a copy of D1 in D2 in order to mask some of its bits and keep original.
    AND.B   #%11000000,D2   *These bits are required to tell the difference between MULS and AND.
    CMP.B   #%11000000,D2   *Compare to values for MULS.
    BEQ     MULS_SECT       *If equal to values for MULS, go to MULS_SECT. Else, Continue to AND_SECT.
AND_SECT        *Output the message 'AND.'.
    LEA     AND_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000000000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%1100000000000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    JSR     VALIDATE_OPMODE_FIELD   *Subroutine validates OPMode field of subroutine.
    BTST    #0,D3                   *Checking result of subroutine's check for valid OPMode.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    BTST    #8,D1
    BNE     AND_DN_EA
AND_EA_DN                   *This is ADD with the OPMode bieng <ea> -> Dn
    MOVE.B  #%11111101,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JMP     RELOOP
AND_DN_EA                   *This is ADD with the OPMode bieng Dn -> <ea>
    MOVE.B  #%11110100,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JMP     RELOOP
BIN_111_FOURTH  *Possibilities are LSL, LSR, ASR, ASL, ROL, and ROR. These can be register shifts or memory shifts.
BIN_1110_FIFTH
    MOVE.B  D1,D2
    AND.B   #%11000000,D2
    CMP.B   #%11000000,D2
    BEQ     MEM_SHIFTS
REG_SHIFTS      *This has been determined to be a register shift.
    MOVE.B  #%11100111,D3           *Shift count of 13 for VALIDATE_SIZE and any size accepted.
    JSR     VALIDATE_SIZE_CLRLIKE   *Subroutine for validating size portion of OPCode.
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.B  D1,D2           *Create a copy of D1 in D2 in order to mask some of its bits and keep original.
    AND.B   #%00011000,D2   *Significant bits for determining what kind of shift.
    CMP.B   #%00001000,D2   *Compare with the shift with the middle value in the range.
    BGT     ROL_ROR_REG_SECT    *If greater than, it's a rotation.
    BEQ     LSL_LSR_REG_SECT    *If greater than, it's a Logical Shift. Else, Continue to Arithmetic shifts.
ASR_ASL_REG_SECT    *Arithmeitc shift. Determines direction.
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000000011000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%1110000000000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    BTST    #8,D1
    BNE     ASL_REG_SECT
ASR_REG_SECT        *Output the message 'ASR.'.
    LEA     ASR_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
LSL_LSR_REG_SECT    *Logical Shift. Determines direction.
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000000011000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%1110000000001000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    BTST    #8,D1
    BNE     LSL_REG_SECT
LSR_REG_SECT        *Output the message 'LSR.'.
    LEA     LSR_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP    
ROL_ROR_REG_SECT    *Rotation. Determines direction.
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000000011000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%1110000000011000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    BTST    #8,D1
    BNE     ROL_REG_SECT
ROR_REG_SECT        *Output the message 'ROR.'.
    LEA     ROR_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
ASR_ASL_MEM_SECT    *Arithmeitc shift. Determines direction.
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111111011000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%1110000011000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    BTST    #8,D1
    BNE     ASL_MEM_SECT
ASR_MEM_SECT        *Output the message 'ASR.'.
    LEA     ASR_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
LSL_LSR_MEM_SECT    *Logical Shift. Determines direction.
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111111011000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%1110001011000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    BTST    #8,D1
    BNE     LSL_MEM_SECT
LSR_MEM_SECT        *Output the message 'LSR.'.
    LEA     LSR_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP    
ROL_ROR_MEM_SECT    *Rotation. Determines direction.
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111111011000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%1110011011000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    BTST    #8,D1
    BNE     ROL_MEM_SECT
ROR_MEM_SECT        *Output the message 'ROR.'.
    LEA     ROR_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
MEM_SHIFTS      *This is a memory shift.
    MOVE.B  #%11110100,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.W  D1,D2                  *Create a copy of D1 in D2 in order to mask some of its bits and keep original.
    AND.W   #%0000011000000000,D2   *Significant bits for determining what kind of shift.
    CMP.W   #%0000001000000000,D2   *Compare with the shift with the middle value in the range.
    BGT     ROL_ROR_MEM_SECT
    BEQ     LSL_LSR_MEM_SECT
    BRA     ASR_ASL_MEM_SECT
    
BIN_1101_FOURTH *Possibilities are ADD and ADDA.
    MOVE.W  D1,D2           *Create a copy of D1 in D2 in order to mask some of its bits and keep original.
    AND.W   #%0000000011000000,D2   *These bits are required to tell the difference between ADDA and ADD.
    CMP.W   #%0000000011000000,D2
    BEQ     ADDA_SECT
ADD_SECT
    LEA     ADD_MESS,A1     *Outputs the message 'ADD.'.
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000000000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%1101000000000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    JSR     VALIDATE_OPMODE_FIELD   *Subroutine validates OPMode field of subroutine.
    BTST    #0,D3                   *Checking result of subroutine's check for valid OPMode.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    BTST    #8,D1
    BNE     ADD_DN_EA
ADD_EA_DN                   *This is ADD with the OPMode bieng <ea> -> Dn
    MOVE.B  #%11111111,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JSR     PRINT_OPMODE_ADD_EA_DN
    
    JMP     RELOOP
ADD_DN_EA                   *This is ADD with the OPMode bieng Dn -> <ea>
    MOVE.B  #%11110100,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JMP     RELOOP

ADDA_SECT
    LEA     ADDA_MESS,A1    *Outputs the message 'ADDA.'.
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000000000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%1101000000000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    MOVE.B  #%11111111,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                  *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.W  D1,D2
    AND.W   #%0000000111000000,D2
    CMP.W   #%0000000111000000,D2
    BEQ     ADDA_VALID_SECT
    CMP.W   #%0000000011000000,D2
    BNE     PRINT_INVALID_OPCODE
ADDA_VALID_SECT
    JSR     ADDA_PRINT_OPMODE               *Print the opmode
    
    
    JSR     ADDA_IMMEDIATE_ADDR_TEST        *Test to see if its immediate addressing, signaled with a #, if it is we need a different case
    

    
    JMP     RELOOP
    
    
ADDA_IMMEDIATE_ADDR_TEST
    BTST    #5,D1                           *Test if the first digit is 1
    BEQ     ADDA_RETURN
    BTST    #4,D1                           *Test if the second digit is 1
    BEQ     ADDA_RETURN
    BTST    #3,D1                           *Test if the third digit is 1 
    BEQ     ADDA_RETURN                     
    
    *If test cases pass, then the mode = 111 and we need to pop a word or long based on the opcode
    
    MOVE.L  D1,D4
    MOVE.B  #'#',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #'$',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    
    BTST    #8,D1                           *Test the 8th bit to see if it is word addressed or long addressed
    BEQ     ADDA_IMMEDIATE_WORD
    
    MOVE.L  (A2)+,D6                        *This gets the remaining word from the function
    
    CLR.L   D2
    MOVE.L  D1,D4                           *Copy the bits to D4, because we are going to print and need to use D1
    MOVE.L  D6,D1
    CLR.L   D2
    MOVE.B  #16,D2                          *Print immediate addressing number
    MOVE.B  #15,D0
    TRAP    #15
    
    JMP     ADDA_PRINT_An   
    
    
ADDA_IMMEDIATE_WORD
    MOVE.W  (A2)+,D6               *This gets the remaining word from the function
    CLR.L   D2
    MOVE.L  D1,D4                           *Copy the bits to D4, because we are going to print and need to use D1
    MOVE.L  D6,D1
    CLR.L   D2
    MOVE.B  #16,D2                          *Print immediate addressing number
    MOVE.B  #15,D0
    TRAP    #15


ADDA_PRINT_An

    MOVE.B  #',',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #'A',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1                           *Move orginial opcode back into D1
    
    CLR.L   D6
    MOVE.B  #20,D6
    LSL.L   D6,D1
    CLR.L   D6
    MOVE.B  #29,D6
    LSR.L   D6,D1
    
    CLR.L   D2
    MOVE.B  #10,D2                   *Move 10 into D2 for base 10 decimal system used to print
    MOVE.B  #15,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    
    RTS                                     *Return from sub-routine
 
ADDA_RETURN
    BTST    #5,D1    
    BEQ     ADDA_VALID_MODE_0_JSR
    JSR     VALID_MODE_1
    
    RTS     
ADDA_VALID_MODE_0_JSR
    JSR     VALID_MODE_0
    JMP     ADDA_PRINT_An
    RTS
BTST    
    BTST    #5,D1
    BEQ     VALID_MODE_0_JSR
    
    JSR     VALID_MODE_1 
    JMP     RELOOP
    
ADDA_PRINT_OPMODE
    BTST    #8,D1
    BNE     ADDA_PRINT_LONG
    MOVE.L  D1,D4
    MOVE.B  #'W',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #' ',D1
    TRAP    #15
    
    
    MOVE.L  D4,D1
    RTS
ADDA_PRINT_LONG
    MOVE.L  D1,D4
    MOVE.B  #'L',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #' ',D1
    TRAP    #15
    MOVE.L  D4,D1

    
    RTS
NOP_SECT                    *Outputs the message 'NOP'.
    LEA     NOP_MESS,A1 
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
RTS_SECT                    *Outputs the message 'RTS'.
    LEA     RTS_MESS,A1 
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP         
CMP_SECT                    *Outputs the message 'CMP.'.
    LEA     CMP_MESS,A1 
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000000000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%1011000000000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    MOVE.B  #%11111111,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.W  D1,D2
    AND.W   #%0000000111000000,D2
    CMP.W   #%0000000010000000,D2
    BGT     PRINT_INVALID_OPCODE
    JMP     RELOOP     
SUB_SECT                    *Outputs the message 'SUB.'.
    LEA     SUB_MESS,A1 
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000000000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%1001000000000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    JSR     VALIDATE_OPMODE_FIELD   *Subroutine validates OPMode field of subroutine.
    BTST    #0,D3                   *Checking result of subroutine's check for valid OPMode.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    BTST    #8,D1
    BNE     SUB_DN_EA
SUB_EA_DN                   *This is ADD with the OPMode bieng <ea> -> Dn
    MOVE.B  #%11111111,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JMP     RELOOP  
SUB_DN_EA                   *This is ADD with the OPMode bieng Dn -> <ea>
    MOVE.B  #%11110100,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JMP     RELOOP
        
DIVU_SECT                   *Outputs the message 'DIVU.'.
    LEA     DIVU_MESS,A1 
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000111000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%1000000011000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    MOVE.B  #%11111101,D7           *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JMP     RELOOP 
MOVEA_SECT
    LEA     MOVEA_MESS,A1   *Outputs the message 'MOVEA.'.
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.B  #%11111111,D7       *Valid modes for this OPCode(SourceEA).
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity.
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.B  #%11001101,D3           *Shift count of 13 for VALIDATE_SIZE, and any size but BYTE accepted.
    JSR     VALIDATE_SIZE_MOVELIKE  *Subroutine for validating size portion of OPCode.
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JMP     RELOOP    
ADDQ_SECT     
    LEA     ADDQ_MESS,A1    *Outputs the message 'ADDQ.'.
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.B  #%11110111,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity.
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000100000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%0101000000000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    MOVE.B  #%11100111,D3           *Shift count of 7 for VALIDATE_SIZE and any size accepted.
    JSR     VALIDATE_SIZE_CLRLIKE   *Subroutine for validating size portion of OPCode.
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.W  D1,D4
    JSR     ADDQ_PRINT_ADDR_MODE
    
    MOVE.W  D1,D4
    MOVE.B  #' ',D1
    MOVE.B  #6,D0
    TRAP    #15    
    
    MOVE.B  #'#',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    
    JSR     ADDQ_PRINT_DATA
    
    MOVE.B  #',',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    
    BTST    #5,D1
    BEQ     VALID_MODE_0_JSR
    
    JSR     VALID_MODE_1 
    JMP     RELOOP

ADDQ_PRINT_DATA
    MOVE.L  #20,D7
    LSL.L   D7,D1
    MOVE.L  #29,D7
    LSR.L   D7,D1
    MOVE.L  #3,D0
    CMP.W   #0,D1
    BEQ     ADDQ_PRINT_8
    
    TRAP    #15
    
    

    RTS
ADDQ_PRINT_8
    MOVE.B  #8,D1
    TRAP    #15
    RTS 
ADDQ_PRINT_ADDR_MODE
    BTST    #7,D1
    BNE     ADDQ_PRINT_ADDR_MODE_LONG
    BTST    #6,D1
    BNE     ADDQ_PRINT_ADDR_MODE_WORD
    

    MOVE.B  #'B',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1                    *Move original unaltered bits back to D1
    RTS
    
    JMP     RELOOP
ADDQ_PRINT_ADDR_MODE_WORD
    MOVE.B  #'W',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1                    *Move original unaltered bits back to D1
    RTS

ADDQ_PRINT_ADDR_MODE_LONG
    MOVE.B  #'L',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1                    *Move original unaltered bits back to D1
    RTS
MOVEM_SECT       
    BTST    #10,D1
    BNE     MOVEM_MEM_REG
MOVEM_REG_MEM               *Direction of transfer is register to memory.
    LEA     MOVEM_MESS,A1   *Outputs the message 'MOVEM.'.
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.B  #%11100100,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111101110000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%0100100010000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    JMP     RELOOP 
MOVEM_MEM_REG               *Direction of transfer is memory to register.
    LEA     MOVEM_MESS,A1   *Outputs the message 'MOVEM.'.
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.B  #%11010100,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JMP     RELOOP 
JSR_SECT    
    LEA     JSR_MESS,A1     *Outputs the message 'JSR'.
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.B  #%11000100,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity.
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111111111000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%0100111010000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    JMP     RELOOP
LEA_SECT
    LEA     LEA_MESS,A1     *Outputs the message 'LEA'.
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.B  #%11000100,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity.
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000111000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%0100000111000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    JMP     RELOOP
MOVEQ_SECT
    LEA     MOVEQ_MESS,A1   *Output the message 'MOVEQ.'.
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000100000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%0111000000000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    JMP     RELOOP
MULS_SECT
    LEA     MULS_MESS,A1    *Output the message 'MULS.'.
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000111000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%1100000111000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    MOVE.B  #%11111101,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JMP     RELOOP
LSL_REG_SECT                    *Output the message 'LSL.'.
    LEA     LSL_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
ASL_REG_SECT                    *Output the message 'ASL.'.
    LEA     ASL_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
ROL_REG_SECT                    *Output the message 'ROL.'.
    LEA     ROL_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
LSL_MEM_SECT                    *Output the message 'LSL.'.
    LEA     LSL_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
ASL_MEM_SECT                    *Output the message 'ASL.'.
    LEA     ASL_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
ROL_MEM_SECT                    *Output the message 'ROL.'.
    LEA     ROL_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
TRAP_SECT
    LEA     TRAP_MESS,A1    *Output the message 'TRAP'.
    MOVE.B  #14,D0
    TRAP    #15
    JMP     RELOOP
BTST_STATIC_SECT
    LEA     BTST_MESS,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111111111000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%0000100000000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    MOVE.W  (A2),D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111111100000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%0000000000000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    MOVE.B  #%11110101,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity.
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    BTST    #0,D3
    BNE     PRINT_VALID_BTST_STATIC
    JSR     PRINT_INVALID_OPCODE
    JMP     RELOOP              *Reiterate to beginning of disassembler.
BTST_DYNAMIC_SECT
    LEA     BTST_MESS,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #%11111101,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity.
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000111000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%0000000100000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
    BRA     BTST_DYNAMIC_VALID
    
    JMP     RELOOP              *Reiterate to beginning of disassembler.
DUMMY_SUB
    RTS
    
BTST_DYNAMIC_VALID
    MOVE.B  #20,D2
    MOVE.B  D1,D4
    LSL.L   D2,D1
    MOVE.B  #29,D2
    LSR.L   D2,D1
    MOVE.W  D1,D5
    
    MOVE.B   #' ',D1 *Setting value in D1 to literal value for a space character.
    MOVE.B   #6,D0   *Picking TRAP task #6. 
    TRAP     #15     *Output individual character.
    MOVE.B   #'D',D1 *Setting value in D1 to literal value for a space character.
    TRAP     #15     *Output individual character.
    
    MOVE.B   D5,D1
    MOVE.B   #3,D0
    TRAP     #15
    
    MOVE.B   #',',D1 *Setting value in D1 to literal value for a space character.
    MOVE.B   #6,D0   *Picking TRAP task #6. 
    TRAP     #15     *Output individual character.
    
    
    CLR.L   D5
    JMP     PRINT_VALID_BTST_DYNAMIC
    JMP     RELOOP

PRINT_OPMODE_ADD_EA_DN
    BTST    #7,D1
    BNE     OPMODE_ADD_EA_DN_TEST_LONG
    BTST    #6,D1
    BNE     OPMODE_ADD_EA_DN_TEST_WORD
    JMP     OPMODE_ADD_EA_DN_TEST_BYTE

OPMODE_ADD_EA_DN_TEST_WORD
    MOVE.W  D1,D4                               *Copy to D4 because D1 will be manipulated
    MOVE.B  #'W',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.B  #' ',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1


    BTST    #5,D1
    
    BEQ     VALID_MODE_0_ADD_EA_DN
    JSR     VALID_MODE_1
    
    MOVE.B  #',',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1
    JMP     RELOOP



OPMODE_ADD_EA_DN_TEST_BYTE
    MOVE.W  D1,D4                               *Copy to D4 because D1 will be manipulated
    MOVE.B  #'B',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.B  #' ',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1


    BTST    #5,D1
    
    BEQ     VALID_MODE_0_ADD_EA_DN
    JSR     VALID_MODE_1
    
    MOVE.B  #',',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1
    JMP     RELOOP


    
OPMODE_ADD_EA_DN_TEST_LONG
    MOVE.W  D1,D4                               *Copy to D4 because D1 will be manipulated
    MOVE.B  #'L',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.B  #' ',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1


    BTST    #5,D1
    
    BEQ     VALID_MODE_0_ADD_EA_DN
    JSR     VALID_MODE_1
    
    MOVE.B  #',',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1
    JMP     RELOOP

VALID_MODE_0_ADD_EA_DN
    JSR     VALID_MODE_0
    MOVE.B  #',',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.B  #'D',D1
    TRAP    #15
    MOVE.W  D4,D1
    JSR     DN_REGISTER
    JMP     RELOOP
    
DN_REGISTER
    BTST    #11,D1
    BNE     DN_REGISTER_1
    BTST    #10,D1
    BNE     DN_REGISTER_01
    BTST    #9,D1
    BNE     DN_REGISTER_001
       
    *If it passes all tests, it is D0
    MOVE.B  #'0',D1
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.W  D4,D1
    RTS


DN_REGISTER_1
    BTST    #10,D1
    BEQ     DN_REGISTER_10
    BTST    #9,D1
    BEQ     DN_REGISTER_110
       
    *If it passes all tests, it is D7
    MOVE.B  #'7',D1
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.W  D4,D1
    RTS
DN_REGISTER_10
       
       
    BTST   #9,D1
    BNE    DN_REGISTER_101
    
    *Register is D4
    MOVE.B  #'4',D1
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.W  D4,D1
    RTS
    
DN_REGISTER_110
    *Register is D6

    MOVE.B  #'6',D1
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.W  D4,D1
    RTS


 
DN_REGISTER_101
    *Register is D5
    MOVE.B  #'5',D1
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.W  D4,D1
    RTS
   
DN_REGISTER_01 
    BTST   #9,D1
    BNE    DN_REGISTER_011
    
    *Register is D2
    MOVE.B  #'2',D1
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.W  D4,D1
    RTS
    
DN_REGISTER_011                                  *Data register is D3      
    MOVE.B  #'3',D1
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.W  D4,D1
    RTS
    
    
    
DN_REGISTER_001
    *If it passes all tests, it is D1
    MOVE.B  #'1',D1
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.W  D4,D1
    RTS

VALIDATE_OPMODE_FIELD
    MOVE.W  D1,D2
    AND.W   #%0000000111000000,D2
    CMP.W   #%0000000010000000,D2
    BLE     VALID_MODE
    CMP.W   #%0000000100000000,D2
    BLT     INVALID_MODE
    CMP.W   #%0000000111000000,D2
    BEQ     INVALID_MODE
    BRA     VALID_MODE
*Bits stored in D7 represent the valid modes in the current opcode being disassembled.
                                                    *Bit set means valid for that mode.
                                                    
*Data Register Direct                               %00000001
*Address Register Direct                            %00000010
*Address Register Indirect                          %00000100
*Immediate Data                                     %00001000
*Address Register Indirect with Post incrementing   %00010000
*Address Register Indirect with Pre decrementing    %00100000
*Absolute Long Address                              %01000000
*Absolute Word Address                              %10000000
DEST_EFF_ADDR_MODE_REG      *Modifies D2 and D3. 
    BTST    #8,D1
    BNE     SRC_MODE_1
DEST_MODE_0  *Possibilities are Dn, An, (An), (AN)+
    BTST    #7,D1
    BNE     SRC_MODE_01
DEST_MODE_00     *Possibilities are Dn, An
    BTST    #6,D1
    BNE     MODE_ADDR_DIRECT
    BRA     MODE_DAT_DIRECT
DEST_MODE_01     *Possibilities are (An), (An)+
    BTST    #6,D1
    BNE     MODE_ADDR_INDIR_INCR
    BRA     MODE_ADDR_INDIR
DEST_MODE_1
    BTST    #7,D1
    BNE     DEST_MODE_11
DEST_MODE_10
    BTST    #6,D1
    BNE     INVALID_MODE
    BRA     MODE_ADDR_INDIR_DECR
DEST_MODE_11     *Possibilities are (xxx).W, (xxx).L, and #<data>
    BTST    #6,D1
    BEQ     INVALID_MODE  
DEST_MODE_111    *Possibilities are (xxx).W, (xxx).L, and #<data>
    MOVE.W  D1,D2                   *Creating a copy of D1 in order to isolate bits for mode differentiation.
    AND.W   #%0000111000000000,D2   *Relevant bits for diferrentiating the current possible modes.
    CMP.W   #%0000000000000000,D2   *If this comparison is true, then the mode is a word address.
    BEQ     MODE_WORD_ADDRESS       *Go to case for Word Address.
    CMP.W   #%0000001000000000,D2   *If this comparison is true, then the mode is a Long address.
    BEQ     MODE_LONG_ADDRESS       *Go to case for Long Address.
    CMP.W   #%0000100000000000,D2   *If this comparison is true, then the mode is immediate data.
    BEQ     MODE_IMMEDIATE_DATA     *Go to case for immediate data.
    BRA     INVALID_MODE            *Else, code must be invalid.    
    
SRC_EFF_ADDR_MODE_REG       *Modifies D2 and D3.   
    BTST    #5,D1
    BNE     SRC_MODE_1
SRC_MODE_0  *Possibilities are Dn, An, (An), (AN)+
    BTST    #4,D1
    BNE     SRC_MODE_01
SRC_MODE_00     *Possibilities are Dn, An
    BTST    #3,D1
    BNE     MODE_ADDR_DIRECT
MODE_DAT_DIRECT
    BTST    #0,D7                   *Test if this mode is valid for the current OPCode.
    BNE     VALID_MODE              *If bit was set, goto case for valid mode.
    BRA     INVALID_MODE            *Else, goto case for invalid mode.
SRC_MODE_01     *Possibilities are (An), (An)+
    BTST    #3,D1
    BNE     MODE_ADDR_INDIR_INCR
MODE_ADDR_INDIR
    BTST    #2,D7                   *Test if this mode is valid for the current OPCode.
    BNE     VALID_MODE              *If bit was set, goto case for valid mode.
    BRA     INVALID_MODE            *Else, goto case for invalid mode.
SRC_MODE_1
    BTST    #4,D1
    BNE     SRC_MODE_11
SRC_MODE_10
    BTST    #3,D1
    BNE     INVALID_MODE
MODE_ADDR_INDIR_DECR
    BTST    #5,D7                   *Test if this mode is valid for the current OPCode.
    BNE     VALID_MODE              *If bit was set, goto case for valid mode.
    BRA     INVALID_MODE            *Else, goto case for invalid mode.     
SRC_MODE_11     *Possibilities are (xxx).W, (xxx).L, and #<data>
    BTST    #3,D1
    BEQ     INVALID_MODE
SRC_MODE_111    *Possibilities are (xxx).W, (xxx).L, and #<data>
    MOVE.B  D1,D2                   *Creating a copy of D1 in order to isolate bits for mode differentiation.
    AND.B   #%00000111,D2           *Relevant bits for diferrentiating the current possible modes.
    CMP.B   #%00000000,D2           *If this comparison is true, then the mode is a word address.
    BEQ     MODE_WORD_ADDRESS       *Go to case for Word Address.
    CMP.B   #%00000001,D2           *If this comparison is true, then the mode is a Long address.
    BEQ     MODE_LONG_ADDRESS       *Go to case for Long Address.
    CMP.B   #%00000100,D2           *If this comparison is true, then the mode is immediate data.
    BEQ     MODE_IMMEDIATE_DATA     *Go to case for immediate data.
    BRA     INVALID_MODE            *Else, code must be invalid.
MODE_ADDR_DIRECT        
    BTST    #1,D7                   *Test if this mode is valid for the current OPCode.
    BNE     VALID_MODE              *If bit was set, goto case for valid mode.
    BRA     INVALID_MODE            *Else, goto case for invalid mode.          
MODE_IMMEDIATE_DATA     
    BTST    #3,D7                   *Test if this mode is valid for the current OPCode.
    BNE     VALID_MODE              *If bit was set, goto case for valid mode.
    BRA     INVALID_MODE            *Else, goto case for invalid mode.           
MODE_ADDR_INDIR_INCR
    BTST    #4,D7                   *Test if this mode is valid for the current OPCode.
    BNE     VALID_MODE              *If bit was set, goto case for valid mode.
    BRA     INVALID_MODE            *Else, goto case for invalid mode.           
MODE_LONG_ADDRESS
    BTST    #6,D7                   *Test if this mode is valid for the current OPCode.
    BNE     VALID_MODE              *If bit was set, goto case for valid mode.
    BRA     INVALID_MODE            *Else, goto case for invalid mode.            
MODE_WORD_ADDRESS
    BTST    #7,D7                   *Test if this mode is valid for the current OPCode.
    BNE     VALID_MODE              *If bit was set, goto case for valid mode.
    BRA     INVALID_MODE            *Else, goto case for invalid mode.            
INVALID_MODE
    MOVE.B  #0,D3
    RTS
VALID_MODE
    MOVE.B  #1,D3
    RTS
    
*D3 needs to contain the shift over that has to be done in order to get to size.
*D3.B should contain %***(5-bit  shift count). The first three bits determine which 
*sizes are valid. The 5-bit shift count should always be more than 0.
*Result will be stored in D3.B as #1 for valid size and #0 for invalid.
*%100***** is LONG
*%010***** is WORD
*%001***** is BYTE
VALIDATE_SIZE_MOVELIKE
    MOVE.L  D4,-(SP)                *Save current value of D4 into the stack.
    CLR.L   D4
    MOVE.B  D3,D4                   *Copy D3 into D4 in order to isolate shift count.
    AND.B   #%00011111,D4           *Isolate shift count in D4.         
    BTST    D4,D1                   *Test the left bit of size to determine size.
    BNE     MOVE_SIZE_1                  *Branch to case for if the bit was a 1.
MOVE_SIZE_0
    SUB     #1,D4                   *Adjust shift count to be the bit to the right of the previously tested bit.
    BTST    D4,D1                   *Test the second bit for the size.
    BNE     SIZE_BYTE_OPERATION     *If it's a 1, then it is a BYTE operation.
INVALID_SIZE
    MOVE.B  #0,D3                   *Sets the value in D3 to zero before returning.
    MOVE.L  (SP)+,D4                *Restore original value of D4.
    RTS                             
SIZE_BYTE_OPERATION *(01)
    BTST    #5,D3                   *If this bit is one, then a BYTE operation is defined for this OPCODE.
    BNE     VALID_SIZE              *Branch to valid case if it was a 1.
    BRA     INVALID_SIZE            *Else, branch to invalid case.
MOVE_SIZE_1
    SUB     #1,D4                   *Adjust shift count to be the bit to the right of the previously tested bit.
    BTST    D4,D1                   *Test the second bit for the size.
    BNE     SIZE_WORD_OPERATION     *If it's a 1, then it is a WORD operation.
SIZE_LONG_OPERATION *(10)
    BTST    #7,D3                   *If this bit is one, then a LONG operation is defined for this OPCODE.
    BNE     VALID_SIZE              *Branch to valid case if it was a 1.
    BRA     INVALID_SIZE            *Else, branch to invalid case.
SIZE_WORD_OPERATION *(11) 
    BTST    #6,D3                   *If this bit is one, then a WORD operation is defined for this OPCODE.
    BNE     VALID_SIZE              *Branch to valid case if it was a 1.
    BRA     INVALID_SIZE            *Else, branch to invalid case.
VALID_SIZE
    MOVE.B  #1,D3                   *A 1 in D3 signifies a valid SIZE was found for this OPCode.
    MOVE.L  (SP)+,D4                *Restore original value of D4.
    RTS  

*D3 needs to contain the shift over that has to be done in order to get to size.
*D3.B should contain %***(5-bit  shift count). The first three bits determine which 
*sizes are valid. The 5-bit shift count should always be more than 0.
*Result will be stored in D3.B as #1 for valid size and #0 for invalid.
*%100***** is LONG
*%010***** is WORD
*%001***** is BYTE
VALIDATE_SIZE_CLRLIKE
    MOVE.L  D4,-(SP)                *Save current value of D4 into the stack.
    CLR.L   D4
    MOVE.B  D3,D4                   *Copy D3 into D4 in order to isolate shift count.
    AND.B   #%00011111,D4           *Isolate shift count in D4.         
    BTST    D4,D1                   *Test the left bit of size to determine size.
    BNE     CLR_SIZE_1                  *Branch to case for if the bit was a 1.
CLR_SIZE_0
    SUB     #1,D4                   *Adjust shift count to be the bit to the right of the previously tested bit.
    BTST    D4,D1                   *Test the second bit for the size.
    BNE     SIZE_WORD_OPERATION     *If it's a 1, then it is a BYTE operation.
    BRA     SIZE_BYTE_OPERATION                    
CLR_SIZE_1
    SUB     #1,D4                   *Adjust shift count to be the bit to the right of the previously tested bit.
    BTST    D4,D1                   *Test the second bit for the size.
    BNE     INVALID_SIZE            *If it's a 1, then it is an invalid operation.
    BRA     SIZE_LONG_OPERATION

PRINT_VALID_BTST_DYNAMIC
    MOVE.W  D4,D1
    BTST    #5,D1
    BEQ     VALID_MODE_0_JSR
    
    JSR     VALID_MODE_1 
    JMP     RELOOP





*This label needs to be reavaluated, we want to be able to jump back to where we were previously
VALID_MODE_0_JSR
    JSR     VALID_MODE_0
    JMP     RELOOP
PRINT_VALID_BTST_STATIC
    LEA     SPACE,A1                *Print a space to separate BTST with the addressing mode
    MOVE.B  #14,D0
    TRAP    #15
    LEA     POUND,A1                *Load and print a #, this is specific to this particular mode
    TRAP    #15
    
    MOVE.W  (A2)+,D6               *This gets the remaining word from the function
    
    
    MOVE.W  D1,D4                  *Copy the bits to D4, because we are going to print and need to use D1
    MOVE.W  D6,D1
    CLR.L   D2
    MOVE.B  #10,D2
    MOVE.B  #15,D0
    TRAP    #15
    MOVE.W  D4,D1
    
    MOVE.B  #14,D0
    LEA     COMMA,A1
    TRAP    #15
    BTST    #5,D1
    BEQ     VALID_MODE_0_JSR
    
    JSR     VALID_MODE_1 
    JMP     RELOOP

VALID_MODE_1     *Options here are                 
    BTST    #4,D1
    BNE     VALID_MODE_11
    
    *Bit mode here is 10, which means the full code is 100 or -(An)
    MOVE.B  #'-',D1                 *Setting value in D1 to literal value for a space character.
    MOVE.B  #6,D0                   *Picking TRAP task #6. 
    TRAP    #15                     *Output individual character.
   
    MOVE.B  #'(',D1                 *Begin printing of the (An) part
    TRAP    #15
    MOVE.B  #'A',D1
    TRAP    #15
    
    MOVE.W  D4,D1                    *Copy original values back into D1
              
    MOVE.B  #29,D6                   *Set the bit shift to 29 so we can isolate the register number 
    LSL.L   D6,D1                    
    LSR.L   D6,D1
    CLR.L   D2
    MOVE.B  #10,D2                   *Move 10 into D2 for base 10 decimal system used to print
    MOVE.B  #15,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    
    MOVE.B  #')',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1                    *Move original unaltered bits back to D1
    
    
    RTS
VALID_MODE_11    
    BTST    #2,D1
    BNE     VALID_MODE_111_POUND
    MOVE.B  #'$',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.W  D4,D1
    BTST    #0,D1
    BNE     VALID_MODE_111_LONG
    MOVE.W  (A2)+,D6               *This gets the remaining word from the function

    MOVE.W  D6,D1
    MOVE.B  #15,D0        *Sets the trap task to print out in hexadecimal
    MOVE.B  #16,D2        *Set the base to 16
    TRAP    #15           *Print out the Addr1 value in hexadecimal format
    
    MOVE.W  D4,D1                    *Copy original values back into D1
    RTS
    
VALID_MODE_111_POUND
    MOVE.B  #'#',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.W  D4,D1
    MOVE.W  (A2)+,D6               *This gets the remaining word from the function

    MOVE.W  D6,D1
    MOVE.B  #15,D0        *Sets the trap task to print out in hexadecimal
    MOVE.B  #16,D2        *Set the base to 16
    TRAP    #15           *Print out the Addr1 value in hexadecimal format
    
    MOVE.W  D4,D1                    *Copy original values back into D1
    RTS
VALID_MODE_111_LONG
    MOVE.L  (A2)+,D6
    MOVE.L  D6,D1
    MOVE.B  #15,D0        *Sets the trap task to print out in hexadecimal
    MOVE.B  #16,D2        *Set the base to 16
    TRAP    #15
    CLR.L   D1
    
    RTS
VALID_MODE_0                         *Options are Dn, (An), or (An)+
    BTST    #4,D1
    BNE     VALID_MODE_01  
    JMP     VALID_MODE_00

VALID_MODE_00
    BTST    #3,D1
    BNE     VALID_MODE_001
    
    MOVE.B  #'D',D1
    MOVE.B  #6,D0
    TRAP    #15                   
    
    MOVE.W  D4,D1  
    MOVE.B  #29,D6                   *Set the bit shift to 29 so we can isolate the register number 
    LSL.L   D6,D1                    
    LSR.L   D6,D1
    CLR.L   D2
    MOVE.B  #10,D2                   *Move 10 into D2 for base 10 decimal system used to print
    MOVE.B  #15,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    MOVE.W  D4,D1                    *Move original unaltered bits back to D1
    
    RTS
VALID_MODE_01    
    LEA     INDIRECT_ADDR_MESS,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    
    MOVE.B  #29,D6                   *Set the bit shift to 29 so we can isolate the register number 
    LSL.L   D6,D1                    *Shift bits to isolate register number
    LSR.L   D6,D1                    *Shift bits back to position so we can get the number
    CLR.L   D2                       *Make sure D2 is clear
    MOVE.B  #10,D2                   *Move 10 into D2 for base 10 decimal system used to print
    MOVE.B  #15,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    
    
    
    MOVE.B   #')',D1                 *Setting value in D1 to literal value for a space character.
    MOVE.B   #6,D0                   *Picking TRAP task #6. 
    TRAP     #15                     *Output individual character.
    MOVE.W  D4,D1                    *Copy original values back into D1
    BTST    #3,D1
    BNE     VALID_MODE_011 
    RTS

VALID_MODE_001
    MOVE.B  #'A',D1
    MOVE.B  #6,D0
    TRAP    #15                   
    
    MOVE.W  D4,D1  
    MOVE.B  #29,D6                   *Set the bit shift to 29 so we can isolate the register number 
    LSL.L   D6,D1                    
    LSR.L   D6,D1
    CLR.L   D2
    MOVE.B  #10,D2                   *Move 10 into D2 for base 10 decimal system used to print
    MOVE.B  #15,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    MOVE.W  D4,D1                    *Move original unaltered bits back to D1
    
    RTS

VALID_MODE_011
    LEA     PLUS,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS
PRINT_INVALID_OPCODE
    LEA     INVALID_MESS,A1 
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
    
DIS_END
            SIMHALT             ; halt simulator
CR      EQU     $0D             ASCII code for Carriage Return
LF      EQU     $0A             ASCII code for Line Feed
MOVE_MESS       DC.B    'MOVE.',0
NOP_MESS        DC.B    'NOP',0
MOVEA_MESS      DC.B    'MOVEA.',0
ADDI_MESS       DC.B    'ADDI.',0
MOVEQ_MESS      DC.B    'MOVEQ.',0
MOVEM_MESS      DC.B    'MOVEM.',0
ADDQ_MESS       DC.B    'ADDQ.',0
LEA_MESS        DC.B    'LEA',0
CLR_MESS        DC.B    'CLR.',0
JSR_MESS        DC.B    'JSR',0
RTS_MESS        DC.B    'RTS',0
SUB_MESS        DC.B    'SUB.',0
DIVU_MESS       DC.B    'DIVU.',0
OR_MESS         DC.B    'OR.',0
CMP_MESS        DC.B    'CMP.',0
ADD_MESS        DC.B    'ADD.',0
ADDA_MESS       DC.B    'ADDA.',0
MULS_MESS       DC.B    'MULS.',0
AND_MESS        DC.B    'AND.',0
ASR_MESS        DC.B    'ASR.',0
ASL_MESS        DC.B    'ASL.',0
LSL_MESS        DC.B    'LSL.',0
LSR_MESS        DC.B    'LSR.',0
ROR_MESS        DC.B    'ROR.',0
ROL_MESS        DC.B    'ROL.',0
BTST_MESS       DC.B    'BTST',0
BRA_MESS        DC.B    'BRA',0
BCC_MESS        DC.B    'BCC',0
BCS_MESS        DC.B    'BCS',0
BEQ_MESS        DC.B    'BEQ',0
BGE_MESS        DC.B    'BGE',0
BGT_MESS        DC.B    'BGT',0
BHI_MESS        DC.B    'BHI',0  
BLE_MESS        DC.B    'BLE',0  
BLS_MESS        DC.B    'BLS',0
BLT_MESS        DC.B    'BLT',0
BMI_MESS        DC.B    'BMI',0
BNE_MESS        DC.B    'BNE',0
BPL_MESS        DC.B    'BPL',0
BVC_MESS        DC.B    'BVC',0  
BVS_MESS        DC.B    'BVS',0
TRAP_MESS       DC.B    'TRAP',0
B_MESS          DC.B    'B',0
W_MESS          DC.B    'W',0
L_MESS          DC.B    'L',0
NEXT_LINE       DC.B    CR,LF,0    
INVALID_MESS    DC.B    'INVALID OPCODE',0
COMMA           DC.B    ',',0
POUND           DC.B    '#',0
SPACE           DC.B    ' ',0
MINUS           DC.B    '-',0
PLUS            DC.B    '+',0
CLOSE_PAREN     DC.B    ')',0


*Address Register and Data register printout
A_REGISTER_MESS DC.B    'A',0
D_REGISTER_MESS DC.B    'D',0
INDIRECT_ADDR_MESS DC.B '(A',0
MESSAGE1 DC.B 'Please enter a starting address for your program',0
MESSAGE2 DC.B 'Please enter an ending address for your program',0



* Put variables and constants here

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
