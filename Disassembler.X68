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
*       LSL      $8 *Word is only valid case.
*       LSR      $0
*       ASL      $0
*       ASR      $0
*       ROL      $0
*       ROR      $0
*       LSL.L    #8,D3
*    BRA     DO_NOTHING
*    CMP     #0,D3
*    BEQ     DO_NOTHING
    
*DO_NOTHING
*    ADD.B   -(A3),D5
*    SUB.B   -(A3),D5
*    add.l D4,(A3)
*    CMP.B   #3,D3
*    CMP.L   (A3),D5
*    CMP.W   #$1234,D6
*    MOVE.L  #$12348999,D3
*    MOVE.W  #$5678,D4
    
    *MOVE.B  #1,D1
    *LSR.L   D1,D2
*    LSL.W   D1,D2
*    ASR.B   D1,D2
*    ASL.W   D1,D2
*    ROL.W    D1,D2
*    ROR.W    D1,D2
    
*    LSR.L   #1,D2
    MOVEM.W  (A7),D0-D7
    MOVEM.L  D1-D7,-(A7)
    MOVEM.L  A1-A7,-(A7)
     
    MOVEM.L  D0-D7,(A7)
    MOVEM.L  (A7)+,D0-D7
    *MOVEM.L  D0-D7,(A7)+
    MOVEM.L  (A7),D0-D6
    MOVEM.L  D0-D6,(A7)
    MOVEM.L  (A7)+,D0-D7
    *MOVEM.L  D0-D7,(A7)+
    LSL.W   #1,D2
    ASR.B   #1,D2
    ASL.W   #1,D2
    ROL.W    #1,D2
    ROR.W    #1,D2

*    MOVE.L #$1234,D4
*    MOVE.L  #1,D3
*    DIVU   D3,D4
*    DIVU.W   D3,D4
*    DIVU  D4,D5
*    
*    MOVE.L #$1234,D4 
*    DIVU  #$1234,D4
*    
*    DIVU.W  #2,D4
*    DIVU.W  D3,D4
*
*    MULS   D3,D4
*    MULS  D4,D5
*    
*    MOVE.L #$1234,D4 
*    MULS  #$1234,D4
*    
*    MULS.W  #2,D4
*    MULS.W  D3,D4
*    ADD.B   #4,D1
*    SUB.B   #68,D1
*    SUB.B   D3,D4
**    SUB.B   (A3),D6
**    SUB.B   -(A3),D5
**    SUB.B   D7,-(A3)
**    CLR.L   D1
**    CLR.B   D2
**    CLR.W   D5
**    CLR.L   (A4)
**    CLR.W   (A4)+
**    CLR.W   -(A4)
*  
*    LEA     $12329923,A1     *Outputs the message 'JSR'
*    LEA     JSR_MESS,A6     *Outputs the message 'JSR'
*       MOVEA.L   #$11111111,A2
*       MOVEA.L   #$1111,A2
*       MOVEA.W   #223,A2
*       MOVEA.L   A1,A2
*       MOVEA.L   D1,A2
*       MOVEA.L   #2,A2
        
       *MOVEA.L   #$345D,A4
       *MOVEA.W   (A4)+,A3
       *MOVEA.L   -(A2),A5
       *ADDA.L   #$11111111,A2
       *ADDA.L   #$1111,A2
       *ADDA.W   #223,A2
       *ADDA.L   A1,A2
       *ADDA.L   D1,A2
       *ADDA.L   #2,A2
       *ADDA.L   #223,A2

       *ADDA.W   A5,A7
       *ADDA.W   A2,A5
       
       *MOVEA.W   A5,A7
       *MOVEA.W   #16,A5
       *MOVEA.L   A2,A5
       *MOVEA.L   -(A2),A5
       
       *MOVEQ     #7,D2
       *MOVEQ     #2,D5
       *MOVEQ     #5,D3
       
       *MOVE.L    #$123,D5
       *MOVE.L    #$1237,D7
       
       *MOVE.W    #$1231,D7
       *MOVE.L    #$12311111,D7
       *MOVE.L    #$567123,D5

       *MOVE.B    D2,D3
       *MOVE.W    D1,D4
       *MOVE.L    D7,D3
              
       *MOVE.L    #$123,D7

*       
*      
*       MOVE.B    #12,D3
*       MOVE.W    #123,D4
*       MOVE.L    #167,D3
*       
*       MOVE.B    #$12,D3
*       MOVE.W    #$123,D4
*       MOVE.L    #$167,D3
*    
*       MOVEM     (A5),D0-D1
       *MOVEQ     #1,D1
       *MOVEQ     #5,D3
       *MOVEQ     #0,D6
       *MOVEQ     #3,D1
*       
*       
       *ADDA.L   #$11111111,A2
       *ADDA.L   #$1111,A2
       *ADDA.W   #223,A2
       *ADDA.L   A1,A2
       *ADDA.L   D1,A2
       *ADDA.L   #2,A2
       *ADDA.L   #223,A2
       *ADDA.W   A5,A7
       *ADDA.W   A2,A5
*       ADDA.W   (A4)+,A3
       *ADDA.L   -(A2),A5
       
*       MOVEA.W   D2,A2
*       MOVEA.W   (A4)+,A3
*       MOVEA.L   -(A2),A5
       
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
*       
*       ADDI.L   #2,D1
*       ADDI.W   #4,D6
*       ADDI.B   #4,D7
*       ADDI.W   #8,D3
*       ADDI.W   #1,D2
*       ADDI.B   #8,D5
*       ADDI.B   #3,D1
*       ADDI.B   #127,D1
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
       MOVEA    $9000,A1
       LSL.W    D1,D2
       LSR.W    D1,D2
       ASL.W    D1,D2
       ASR.W    D1,D2
       ROL.W    D1,D2
       ROR.W    D1,D2
       
       LSL      $0 *Word is only valid case.
       LSR      $0
       ASL      $0
       ASR      $0
       ROL      $0
       ROR      $0
       
       LSL      $10000 *Word is only valid case.
       LSR      $10000
       ASL      $10000
       ASR      $10000
       ROL      $10000
       ROR      $10000
       
       LSL      (A1) *Word is only valid case.
       LSR      (A1)
       ASL      (A1)
       ASR      (A1)
       ROL      (A1)
       ROR      (A1)
       
       LSL      (A1)+ *Word is only valid case.
       LSR      (A1)+
       ASL      (A1)+
       ASR      (A1)+
       ROL      (A1)+
       ROR      (A1)+
       
       LSL      -(A1) *Word is only valid case.
       LSR      -(A1)
       ASL      -(A1)
       ASR      -(A1)
       ROL      -(A1)
       ROR      -(A1)

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
      
INPUT        
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
             CMP.L       D4,D3
             BLT         OUTPUT_ERRORMESSAGE1
             MOVEA.L     D4,A2
             MOVEA.L     D3,A3
             BRA    RELOOP
             
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
                
SKIP                                  
    MOVE.L  #$1000,A2       *Starting address for code to be disassembled.
    MOVE.L  #$3000,A3
RELOOP
    CMP.L   A2,A3
    BEQ     ENDMESSAGE
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
    AND.W   #%0000111000000,D2           *These bits are required to differentiate between MOVE and MOVEA. 
    CMP.W   #%0000001000000,D2           *Compare with value that would be true if Code is MOVEA.
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
    
    JSR     PRINT_ADDR_MODE_SIZE_BIT_13

    BTST    #5,D1
    BNE     MOVE_VALID_MODE_1_JSR
    JSR     VALID_MODE_0
    
    JMP     MOVE_PRINT_DESTINATION
VALID_MODE_SOURCE_DEST_1_JSR
    JSR     VALID_MODE_SOURCE_DEST_1
    JMP     RELOOP
    
MOVE_VALID_MODE_1_JSR
    JSR     VALID_MODE_1
    BTST    #5,D1
    BNE     MOVE_PRINT_IMMED_ADDR_11
    JMP     MOVE_PRINT_DESTINATION

MOVE_PRINT_DESTINATION
    CLR.L   D1
    MOVE.B  #',',D1 *Setting value in D1 to literal value for a space character.
    MOVE.B  #6,D0   *Picking TRAP task #6. 
    TRAP    #15     *Output individual character.
    MOVE.B  D4,D1

    BTST    #8,D1                           *Test the destination mode
    BNE     VALID_MODE_SOURCE_DEST_1_JSR    
    JSR     VALID_MODE_SOURCE_DEST_0
    JMP     RELOOP

MOVE_PRINT_IMMED_ADDR_11
    BTST    #4,D1
    BNE     MOVE_PRINT_IMMED_ADDR_MODE_111
    JMP     RELOOP

MOVE_PRINT_IMMED_ADDR_MODE_111
    JSR     MOVE_PRINT_IMMED_ADDR
    JMP     MOVE_PRINT_DESTINATION
MOVE_PRINT_IMMED_ADDR
    BTST    #5,D1                           *Test to make sure the mode is 111, if it is then we need to pop from the address.
    BEQ     RTS
    BTST    #4,D1
    BEQ     RTS
    BTST    #3,D1
    BEQ     RTS
    BTST    #2,D1
    BEQ     RTS
    BTST    #12,D1                          *Test if it is a long, if so pop one more word
    BEQ   MOVE_PRINT_IMMED_ADDR_LONG
    
    RTS
MOVE_PRINT_IMMED_ADDR_LONG
    BTST    #5,D1
    BEQ     RTS
    BTST    #4,D1
    BEQ     RTS
    BTST    #3,D1
    BEQ     RTS
    BTST    #2,D1
    BEQ     RTS

    MOVE.W  (A2)+,D6         *Get the remaining word
    CMP.W   #0,D6            *Compare to 0, if it is 0, print 0000
    BEQ     PRINT_0000_RTS
    
    *MOVE.L  D6,D1
    *MOVE.B  #15,D0        *Sets the trap task to print out in hexadecimal
    *MOVE.B  #16,D2        *Set the base to 16
    *TRAP    #15
    MOVE.L  D6,D2
    JSR OUTPUT_HEXADECIMAL

    RTS

PRINT_ADDR_MODE_SIZE_BIT_13    
    MOVE.L  D1,D4
    BTST    #13,D1
    BEQ     PRINT_BYTE_OPERATION
        
    BTST    #12,D1
    BEQ     PRINT_LONG_OPERATION
    
    *If we get here, the addressing mode is the word operation (.W).
    
    MOVE.B  #'W',D1 *Setting value in D1 to literal value for a space character.
    MOVE.B  #6,D0   *Picking TRAP task #6. 
    TRAP    #15     *Output individual character.
    JMP     PRINT_SPACE_RTS

PRINT_BYTE_OPERATION
    MOVE.B  #'B',D1 *Setting value in D1 to literal value for a space character.
    MOVE.B  #6,D0   *Picking TRAP task #6. 
    TRAP    #15     *Output individual character.
    JMP     PRINT_SPACE_RTS
    
PRINT_LONG_OPERATION
    MOVE.B  #'L',D1 *Setting value in D1 to literal value for a space character.
    MOVE.B  #6,D0   *Picking TRAP task #6. 
    TRAP    #15     *Output individual character.
    JMP     PRINT_SPACE_RTS  

PRINT_SPACE_RTS
    MOVE.B  #6,D0   *Picking TRAP task #6. 
    MOVE.B  #' ',D1 *Setting value in D1 to literal value for a space character.
    TRAP    #15
    MOVE.L  D4,D1
    RTS
    
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
    MOVE.B  #3,D0
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
    
    JMP     CLR_PRINT
               
    
CLR_PRINT
    JSR     CLR_PRINT_ADDR_MODE
    
    BTST    #5,D1
    BEQ     VALID_MODE_0_JSR
    JSR     VALID_MODE_1   

    JMP     RELOOP

CLR_PRINT_ADDR_MODE
   
    BTST    #7,D1
    BNE     CLR_PRINT_LONG
    
    BTST    #6,D1
    BNE     CLR_PRINT_WORD
    
    *We pass both cases, it is a .B
    CLR.L   D4
    MOVE.L  D1,D4
    MOVE.B  #'B',D1 *Setting value in D1 to literal value for a L character.
    MOVE.B  #6,D0   *Picking TRAP task #6. 
    TRAP    #15     *Output individual character.
    MOVE.B  #' ',D1 *Setting value in D1 to literal value for a L character.
    TRAP    #15     *Output individual character.
    MOVE.L  D4,D1
    RTS

CLR_PRINT_LONG    
    CLR.L   D4
    MOVE.L  D1,D4
    MOVE.B  #'L',D1 *Setting value in D1 to literal value for a L character.
    MOVE.B  #6,D0   *Picking TRAP task #6. 
    TRAP    #15     *Output individual character.
    MOVE.B  #' ',D1 *Setting value in D1 to literal value for a L character.
    TRAP    #15     *Output individual character.
    MOVE.L  D4,D1
    RTS
    
CLR_PRINT_WORD    
    CLR.L   D4
    MOVE.L  D1,D4
    MOVE.B  #'W',D1 *Setting value in D1 to literal value for a L character.
    MOVE.B  #6,D0   *Picking TRAP task #6. 
    TRAP    #15     *Output individual character.
    MOVE.B  #' ',D1 *Setting value in D1 to literal value for a L character.
    TRAP    #15     *Output individual character.
    MOVE.L  D4,D1
    MOVE.L  D4,D1
    RTS
    
BIN_011_FOURTH  *Possibilities are Bcc and MOVEQ.
    BTST    #12,D1
    BNE     MOVEQ_SECT
*Condition Section.****************************************

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
    JMP     Bcc_PRINT_DISPLACEMENT
Bcc_001_SECT    *First bits of condition are 001.
    BTST    #8,D1
    BNE     BLS_SECT
BHI_SECT        *First bits of condition are 0010. This means BHI.
    LEA     BHI_MESS,A1     *Outputs the message 'BHI'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     Bcc_PRINT_DISPLACEMENT
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
    JMP     Bcc_PRINT_DISPLACEMENT
Bcc_011_SECT    *First bits of condition are 011.
    BTST    #8,D1
    BNE     BEQ_SECT
BNE_SECT        *First bits of condition are 0110. This means BNE.
    LEA     BNE_MESS,A1     *Outputs the message 'BNE'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     Bcc_PRINT_DISPLACEMENT
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
    JMP     Bcc_PRINT_DISPLACEMENT
Bcc_101_SECT    *First bits of condition are 101.
    BTST    #8,D1
    BNE     BMI_SECT
BPL_SECT        *First bits of condition are 1010. This means BPL.
    LEA     BPL_MESS,A1     *Outputs the message 'BPL'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     Bcc_PRINT_DISPLACEMENT
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
    JMP     Bcc_PRINT_DISPLACEMENT
Bcc_111_SECT    *First bits of condition are 111.
    BTST    #8,D1
    BNE     BLE_SECT
BGT_SECT
    LEA     BGT_MESS,A1     *Outputs the message 'BGT'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     Bcc_PRINT_DISPLACEMENT
BLS_SECT
    LEA     BLS_MESS,A1     *Outputs the message 'BLS'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     Bcc_PRINT_DISPLACEMENT
BCS_SECT
    LEA     BCS_MESS,A1     *Outputs the message 'BCS'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     Bcc_PRINT_DISPLACEMENT
BVS_SECT
    LEA     BVS_MESS,A1     *Outputs the message 'BVS'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     Bcc_PRINT_DISPLACEMENT
BEQ_SECT
    LEA     BEQ_MESS,A1     *Outputs the message 'BEQ'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     Bcc_PRINT_DISPLACEMENT
BLT_SECT
    LEA     BLT_MESS,A1     *Outputs the message 'BLT'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     Bcc_PRINT_DISPLACEMENT
BLE_SECT
    LEA     BLE_MESS,A1     *Outputs the message 'BLE'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     Bcc_PRINT_DISPLACEMENT
BMI_SECT
    LEA     BMI_MESS,A1     *Outputs the message 'BMI'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     Bcc_PRINT_DISPLACEMENT

Bcc_PRINT_DISPLACEMENT
    
    MOVE.L  D1,D4
    MOVE.B  #' ',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #'$',D1                         *Print the number in hexadecimal form, addressing is in base 16
    TRAP    #15
    MOVE.L  D4,D1
    
    MOVE.L  #24,D6
    LSL.L   D6,D1
    MOVE.L  #24,D6
    LSR.L   D6,D1
    MOVE.B  #$00,D7
    CMP     D7,D1
    BEQ     Bcc_PRINT_DISPLACEMENT_WORD
    MOVE.B  #$FF,D7
    CMP     D7,D1
    BEQ     Bcc_PRINT_DISPLACEMENT_LONG
    
    MOVE.L  D1,D2                    
    JSR     OUTPUT_HEXADECIMAL
    JMP     RELOOP
    
Bcc_PRINT_DISPLACEMENT_WORD
    MOVE.L  D4,D1
    MOVE.W  (A2)+,D6               *This gets the remaining word from the function
    CLR.L   D2
    MOVE.L  D1,D4                           *Copy the bits to D4, because we are going to print and need to use D1
    MOVE.L  D6,D1
    CLR.L   D2
    MOVE.L  D1,D2                    
    JSR     OUTPUT_HEXADECIMAL
    JMP     RELOOP
    
Bcc_PRINT_DISPLACEMENT_LONG
    MOVE.L  D4,D1
    MOVE.L  (A2)+,D6               *This gets the remaining word from the function
    CLR.L   D2
    MOVE.L  D1,D4                           *Copy the bits to D4, because we are going to print and need to use D1
    MOVE.L  D6,D1
    CLR.L   D2
    MOVE.L  D1,D2                    
    JSR     OUTPUT_HEXADECIMAL
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
    JSR     PRINT_OPMODE_ADD_EA_DN
    JMP     RELOOP 
OR_DN_EA                        *This is OR with the OPMode bieng Dn -> <ea>
    MOVE.B  #%11110100,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JSR     PRINT_OPMODE_ADD_DN_EA
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
    JSR     PRINT_OPMODE_ADD_EA_DN
    JMP     RELOOP
AND_DN_EA                   *This is ADD with the OPMode bieng Dn -> <ea>
    MOVE.B  #%11110100,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JSR     PRINT_OPMODE_ADD_DN_EA
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
    JSR     LSL_LSR_PRINT
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
    JSR     LSL_LSR_PRINT
    JMP     RELOOP


LSL_LSR_PRINT
    BTST    #5,D1                       *If it is 01, iLSL_LSR_PRINT_LONGt is
    BEQ     LSL_LSR_PRINT_IMMED
    BTST    #7,D1                       *Check the size, if it is a 1, it is a long
    BNE     LSL_LSR_PRINT_LONG
    BTST    #6,D1                       *If it is 01, it is a word address
    BNE     LSL_LSR_PRINT_WORD
                                        *If it gets through both tests it is byte addressing
    MOVE.L  D1,D4
    MOVE.B  #'B',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    JMP     LSL_LSR_PRINT_Dx
    
LSL_LSR_PRINT_WORD
    MOVE.L  D1,D4
    MOVE.B  #'W',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    JMP     LSL_LSR_PRINT_Dx
    
LSL_LSR_PRINT_LONG
    MOVE.L  D1,D4
    MOVE.B  #'L',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    JMP     LSL_LSR_PRINT_Dx
    
LSL_LSR_PRINT_Dx
    MOVE.B  #' ',D1                        
    MOVE.B  #6,D0
    TRAP    #15
    

    MOVE.B  #'D',D1
    MOVE.B  #6,D0
    TRAP    #15
     
    MOVE.L  D4,D1
    CLR.L   D6
    MOVE.B  #20,D6
    LSL.L   D6,D1
    CLR.L   D6
    MOVE.B  #29,D6
    LSR.L   D6,D1
    
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15

    MOVE.B  #',',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.B  #'D',D1 
                             
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.L  D4,D1
    CLR.L   D6
    MOVE.B  #29,D6
    LSL.L   D6,D1
    LSR.L   D6,D1
    
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    
    RTS
LSL_LSR_PRINT_IMMED_LONG
    MOVE.B  #'L',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #' ',D1
    TRAP    #15
    MOVE.B  #'#',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.L  D4,D1
    
    JSR     LSL_LSR_PRINT_Dy
    JMP     RELOOP
LSL_LSR_PRINT_IMMED_WORD
    MOVE.B  #'W',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #' ',D1
    TRAP    #15
    MOVE.B  #'#',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.L  D4,D1
     CLR.L   D6
    MOVE.B  #20,D6
    LSL.L   D6,D1
    CLR.L   D6
    MOVE.B  #29,D6
    LSR.L   D6,D1
    
    CMP     #0,D1
    BEQ     LSL_LSR_PRINT_IMMED_8
    
    JSR     LSL_LSR_PRINT_Dy
    JMP     RELOOP
LSL_LSR_PRINT_IMMED
    MOVE.L  D1,D4
    BTST    #7,D1
    BNE     LSL_LSR_PRINT_IMMED_LONG
    BTST    #6,D1
    BNE     LSL_LSR_PRINT_IMMED_WORD
    MOVE.B  #'B',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #' ',D1
    TRAP    #15
    MOVE.B  #'#',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.L  D4,D1
    
    CLR.L   D6
    MOVE.B  #20,D6
    LSL.L   D6,D1
    CLR.L   D6
    MOVE.B  #29,D6
    LSR.L   D6,D1
    
    CMP     #0,D1
    BEQ     LSL_LSR_PRINT_IMMED_8
    
    JSR     LSL_LSR_PRINT_Dy
    JMP     RELOOP
    
    
LSL_LSR_PRINT_IMMED_8
    MOVE.B  #'8',D1
    MOVE.B  #6,D0
    TRAP    #15
    JMP     RELOOP
    
LSL_LSR_PRINT_Dy
    MOVE.L  D4,D1
    
    CLR.L   D6
    MOVE.B  #20,D6
    LSL.L   D6,D1
    CLR.L   D6
    MOVE.B  #29,D6
    LSR.L   D6,D1
    
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    

    MOVE.B  #',',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.B  #'D',D1 
                             
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.L  D4,D1
    CLR.L   D6
    MOVE.B  #29,D6
    LSL.L   D6,D1
    LSR.L   D6,D1
    
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    MOVE.L  D4,D1


    RTS
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
    JSR     LSL_LSR_PRINT
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
    
    MOVE.L  D1,D4
    MOVE.B  #'W',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #' ',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    BEQ     VALID_MODE_0_JSR
    
    JSR     VALID_MODE_1
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
        MOVE.L  D1,D4
    MOVE.B  #'W',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #' ',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    BTST    #5,D1
    BEQ     LSL_LSR_PRINT_Dx

    BEQ     VALID_MODE_0_JSR
    
    JSR     VALID_MODE_1
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
    BTST    #5,D1
    
    MOVE.L  D1,D4
    MOVE.B  #'W',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #' ',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    BEQ     VALID_MODE_0_JSR
    
    JSR     VALID_MODE_1 
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
    JSR     PRINT_OPMODE_ADD_DN_EA
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
    MOVE.L  D1,D2                    
    JSR     OUTPUT_HEXADECIMAL
    
    JMP     ADDA_PRINT_An   
    
    
ADDA_IMMEDIATE_WORD
    MOVE.W  (A2)+,D6               *This gets the remaining word from the function
    CLR.L   D2
    MOVE.L  D1,D4                           *Copy the bits to D4, because we are going to print and need to use D1
    MOVE.L  D6,D1
    CLR.L   D2
    MOVE.L  D1,D2                    
    JSR     OUTPUT_HEXADECIMAL

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
    
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
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
    MOVE.B  #%11111111,D7           *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    MOVE.W  D1,D2
    AND.W   #%0000000111000000,D2
    CMP.W   #%0000000010000000,D2
    BGT     PRINT_INVALID_OPCODE
    JSR     PRINT_OPMODE_ADD_EA_DN
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
    JSR     PRINT_OPMODE_ADD_EA_DN
    JMP     RELOOP  
SUB_DN_EA                   *This is ADD with the OPMode bieng Dn -> <ea>
    MOVE.B  #%11110100,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    JSR     PRINT_OPMODE_ADD_DN_EA
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
    JSR     PRINT_OPMODE_MULS_EA_DN
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
    *JMP     RELOOP 
MOVEA_VALID_SECT
    JSR     MOVEA_PRINT_OPMODE               *Print the opmode
    JSR     MOVEA_IMMEDIATE_ADDR_TEST        *Test to see if its immediate addressing, signaled with a #, if it is we need a different case 
    JMP     RELOOP
    
MOVEA_IMMEDIATE_ADDR_TEST
    BTST    #5,D1                           *Test if the first digit is 1
    BEQ     MOVEA_RETURN
    BTST    #4,D1                           *Test if the second digit is 1
    BEQ     MOVEA_RETURN
    BTST    #3,D1                           *Test if the third digit is 1 
    BEQ     MOVEA_RETURN                     
    
    *If test cases pass, then the mode = 111 and we need to pop a word or long based on the opcode
    
    MOVE.L  D1,D4
    MOVE.B  #'#',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #'$',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    
    BTST    #12,D1                           *Test the 8th bit to see if it is word addressed or long addressed
    BNE     MOVEA_IMMEDIATE_WORD
    
    MOVE.L  (A2)+,D6                        *This gets the remaining word from the function
    
    CLR.L   D2
    MOVE.L  D1,D4                           *Copy the bits to D4, because we are going to print and need to use D1
    MOVE.L  D6,D1
    
    MOVE.L  D1,D2                    
    JSR     OUTPUT_HEXADECIMAL
    
    JMP     MOVEA_PRINT_An   
    
    
MOVEA_IMMEDIATE_WORD
    MOVE.W  (A2)+,D6               *This gets the remaining word from the function
    CLR.L   D2
    MOVE.L  D1,D4                           *Copy the bits to D4, because we are going to print and need to use D1
    MOVE.L  D6,D1
    MOVE.L  D1,D2                    
    JSR     OUTPUT_HEXADECIMAL


MOVEA_PRINT_An

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
    
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    
    RTS                                     *Return from sub-routine
 
MOVEA_RETURN
    BTST    #5,D1    
    BEQ     MOVEA_VALID_MODE_0_JSR
    JSR     VALID_MODE_1
    JMP     MOVEA_PRINT_An    
MOVEA_VALID_MODE_0_JSR
    JSR     VALID_MODE_0
    JMP     MOVEA_PRINT_An
    RTS
MOVEA_PRINT_OPMODE
    BTST    #8,D1
    BNE     MOVEA_PRINT_LONG
    MOVE.L  D1,D4
    MOVE.B  #'W',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #' ',D1
    TRAP    #15
    
    
    MOVE.L  D4,D1
    RTS
MOVEA_PRINT_LONG
    MOVE.L  D1,D4
    MOVE.B  #'L',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #' ',D1
    TRAP    #15
    MOVE.L  D4,D1

    
    RTS
 
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
    
    JSR     TEST_LONG_WORD
    JSR     CHECK_ADDR_MODE
    
    BTST    #0,D7
    BNE     MOVEM_PRINT_LIST_REVERSE
    JSR     MOVEM_PRINT_LIST
    JSR     JSR_COMMA
    BTST    #5,D1
    BEQ     VALID_MODE_0_MOVEM_REG_MEM_JSR 
    
    JSR     VALID_MODE_1

    

    
    JMP     RELOOP

MOVEM_PRINT_LIST_REVERSE
    CLR.L   D6
    CLR.L   D5
    CLR.L   D7
    MOVE.L  #15,D5
    MOVE.L  #0,D7
    MOVE.W  (A2)+,D6         *Get the remaining word
    
    
    JSR     MOVEM_PRINT_LIST_REVERSE_LOOP
    JSR     JSR_COMMA
        
    BTST    #5,D1
    BEQ     VALID_MODE_0_JSR 
    
    JSR     VALID_MODE_1
    JMP     RELOOP
    
MOVEM_PRINT_LIST_REVERSE_LOOP
    
    BTST    D5,D6
    BNE     MOVEM_PRINT_REVERSE_END
    SUB.B   #1,D5
    JMP     MOVEM_PRINT_LIST_REVERSE_LOOP


    RTS

MOVEM_PRINT_LIST
    CLR.L   D7
    CLR.L   D6
    CLR.L   D5
    MOVE.W  (A2)+,D6         *Get the remaining word
    MOVE.L  #15,D6
    JSR     MOVEM_PRINT_LOOP
    
    
    RTS
    
MOVEM_PRINT_LOOP
    CLR.L   D6
    CLR.L   D5
    CLR.L   D7
    MOVE.L  #15,D5
    MOVE.L  #0,D7
    MOVE.W  (A2)+,D6         *Get the remaining word
    
    
    JSR     MOVEM_PRINT_LIST_REVERSE_LOOP
    JSR     JSR_COMMA
        
    BTST    #5,D1
    BEQ     VALID_MODE_0_JSR 
    
    JSR     VALID_MODE_1
    JMP     RELOOP

    RTS
    
MOVEM_PRINT_REVERSE_END
    BTST    D7,D6
    BNE     MOVEM_PRINT_REVERSE_FINAL
    ADD.B   #1,D7
    JMP     MOVEM_PRINT_REVERSE_END
    
MOVEM_PRINT_REVERSE_FINAL
    CLR.L   D0
    MOVE.L  D7,D0
    CMP     #7,D7
    BGT     MOVEM_PRINT_REVERSE_Dn
    JMP     MOVEM_PRINT_REVERSE_An

*********

MOVEM_PRINT_An
    MOVE.L  D1,D4
    CLR.L   D7
    MOVE.L  D0,D7
    CLR.L   D0
    MOVE.B  #'A',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.L  #8,D1
    SUB.L   D5,D1

    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    MOVE.B  #'-',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.B  #'A',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  #3,D0                   *Move trap task  #15 to convert to decimal and print
    CLR.L   D1
    MOVE.L  #8,D1
    SUB.L   D7,D1
    TRAP    #15
    MOVE.L  D4,D1
    RTS
MOVEM_PRINT_Dn
    MOVE.L  D1,D4
    CLR.L   D7
    MOVE.L  D0,D7
    CLR.L   D0
    MOVE.B  #'D',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15



    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    MOVE.B  #'-',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.B  #'D',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  #3,D0                   *Move trap task  #15 to convert to decimal and print
    CLR.L   D1
    TRAP    #15
    MOVE.L  D4,D1
    RTS



********
MOVEM_PRINT_REVERSE_An
    MOVE.L  D1,D4
    CLR.L   D7
    MOVE.L  D0,D7
    CLR.L   D0
    MOVE.B  #'A',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.L  #7,D1
    SUB.L   D5,D1

    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    MOVE.B  #'-',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.B  #'A',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  #3,D0                   *Move trap task  #15 to convert to decimal and print
    CLR.L   D1
    MOVE.L  #7,D1
    SUB.L   D7,D1
    TRAP    #15
    MOVE.L  D4,D1
    RTS
MOVEM_PRINT_REVERSE_Dn
    MOVE.L  D1,D4
    CLR.L   D7
    MOVE.L  D0,D7
    CLR.L   D0
    MOVE.B  #'D',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.L  #15,D1
    SUB.L   D5,D1

    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    MOVE.B  #'-',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.B  #'D',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  #3,D0                   *Move trap task  #15 to convert to decimal and print
    CLR.L   D1
    MOVE.L  #15,D1
    SUB.L   D7,D1
    TRAP    #15
    MOVE.L  D4,D1
    RTS

TEST_LONG_WORD
    MOVE.L  D1,D4
    BTST    #6,D1
    BNE     MOVEM_PRINT_LONG_JSR
    
    
    RTS
MOVEM_PRINT_LONG_JSR
    JSR     MOVEM_PRINT_LONG
    RTS
    
MOVEM_PRINT_LONG_JSR_RELOOP
    JSR     MOVEM_PRINT_LONG
    

    BTST    #5,D1
    BEQ     VALID_MODE_0_MOVEM_REG_MEM_JSR 
    
    JSR     VALID_MODE_1
    
    JSR     JSR_COMMA
    JSR     MOVEM_PRINT_LIST
    
    JMP     RELOOP
    
MOVEM_MEM_REG               *Direction of transfer is memory to register.
    LEA     MOVEM_MESS,A1   *Outputs the message 'MOVEM.'.
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.B  #%11010100,D7       *Valid modes for this OPCode.
    JSR     SRC_EFF_ADDR_MODE_REG   *Check value in mode for validity
    BTST    #0,D3                   *Checking result of subroutine's check for valid final 6 bits.
    BEQ     PRINT_INVALID_OPCODE    *If invalid, then print error message for invalid OPCode.
    
    
    
    BTST    #6,D1
    BNE     MOVEM_PRINT_LONG_JSR_RELOOP
    
    MOVE.L  D1,D4
    MOVE.B  #'W',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #' ',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    
    
    BTST    #5,D1
    BEQ     VALID_MODE_0_MOVEM_JSR
    
    JSR     VALID_MODE_1
    
    JSR     JSR_COMMA
    
    CLR.L   D6
    JSR     MOVEM_PRINT_LIST
    
    JMP     RELOOP
  
CHECK_ADDR_MODE
    BTST    #5,D1
    BNE     CHECK_ADDR_MODE_1
    
    RTS
    
CHECK_ADDR_MODE_1
    BTST    #3,D1
    BEQ     CHECK_ADDR_MODE_100

    RTS
    
CHECK_ADDR_MODE_100
    CLR.L   D7
    MOVE.L  #1,D7
    RTS

JSR_COMMA  

    MOVE.L  D1,D4
    MOVE.B  #',',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    RTS
VALID_MODE_0_MOVEM_JSR 
    JSR     VALID_MODE_0
    CLR.L   D6
    JSR     MOVEM_PRINT_LIST
    JMP     RELOOP
    
VALID_MODE_0_MOVEM_REG_MEM_JSR 
    JSR     VALID_MODE_0
    
    JSR     JSR_COMMA
    JMP     RELOOP
MOVEM_PRINT_LONG
    
    MOVE.L  D1,D4
    MOVE.B  #'L',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #' ',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    
    RTS
   

    
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
        
    MOVE.L  D1,D4
    
    MOVE.B  #' ',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.L  D4,D1    
    BTST    #5,D1
    BEQ     VALID_MODE_0_JSR
    JSR     VALID_MODE_1   
    MOVE.L  D4,D1

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
    
    JMP     LEA_PRINT
    JMP     RELOOP

LEA_PRINT_IMMED_ADDR_LONG
    MOVE.W  (A2)+,D6         *Get the remaining word
    CMP.W   #0,D6            *Compare to 0, if it is 0, print 0000
    BEQ     PRINT_0000_RTS
    
    MOVE.L  D6,D1
    MOVE.L  D1,D2                    
    JSR     OUTPUT_HEXADECIMAL

    RTS 
LEA_PRINT
    MOVE.L  D1,D4
    
    MOVE.B  #' ',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.L  D4,D1
    BTST    #5,D1
    BEQ     VALID_MODE_0_LEA_JSR
    
    JSR     VALID_MODE_1     
    JMP     LEA_PRINT_An
VALID_MODE_0_LEA_JSR
    JSR     VALID_MODE_0
LEA_PRINT_An
   * JSR     LEA_PRINT_IMMED_ADDR_LONG
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
    
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    JMP     RELOOP
    
MOVEQ_SECT
    LEA     MOVEQ_MESS,A1   *Output the message 'MOVEQ '.
    MOVE.B  #14,D0      
    TRAP    #15
    MOVE.W  D1,D2                   *Copying OPCode Word for isolation of static bits.
    AND.W   #%1111000100000000,D2   *Isolating bits for detrmining validity of OPCode.
    CMP.W   #%0111000000000000,D2   *Comparing with valid value.
    BNE     PRINT_INVALID_OPCODE    *If it's not the valid value, then print error message.
   
    JMP     MOVEQ_PRINT
    
    
MOVEQ_PRINT
    MOVE.L  D1,D4
    MOVE.B  #'#',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    
    MOVE.L  D4,D1
    CLR.L   D6
    MOVE.B  #24,D6
    LSL.L   D6,D1
    CLR.L   D6
    MOVE.B  #24,D6
    LSR.L   D6,D1
    
  
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    
    MOVE.B  #',',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #'D',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1                           *Move orginial opcode back into D1
    
    CLR.L   D6
    MOVE.B  #20,D6
    LSL.L   D6,D1
    CLR.L   D6
    MOVE.B  #29,D6
    LSR.L   D6,D1
    
    
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    
    JMP     RELOOP


OPMODE_MULS_EA_DN_TEST_WORD
    MOVE.W  D1,D4                               *Copy to D4 because D1 will be manipulated
    MOVE.B  #'W',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.B  #' ',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1

    BTST    #5,D1
    
    BEQ     VALID_MODE_0_MULS_EA_DN
    JSR     VALID_MODE_1
    
    MOVE.B  #',',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1
    
    MOVE.B  #20,D2
    MOVE.B  D1,D4
    LSL.L   D2,D1
    MOVE.B  #29,D2
    LSR.L   D2,D1
    MOVE.W  D1,D5
    

    MOVE.B   #6,D0   *Picking TRAP task #6. 
    MOVE.B   #'D',D1 *Setting value in D1 to literal value for a space character.
    TRAP     #15     *Output individual character.
    
    MOVE.B   D5,D1
    MOVE.B   #3,D0
    TRAP     #15
    MOVE.W  D4,D1
    JMP     RELOOP
    
OPMODE_MULS_EA_DN_TEST_LONG
    MOVE.W  D1,D4                               *Copy to D4 because D1 will be manipulated
    MOVE.B  #'L',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.B  #' ',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1


    MOVE.B  #20,D2                      
    MOVE.B  D1,D4
    LSL.L   D2,D1
    MOVE.B  #29,D2
    LSR.L   D2,D1
    MOVE.W  D1,D5
    

    MOVE.B   #6,D0   *Picking TRAP task #6. 
    MOVE.B   #'D',D1 *Setting value in D1 to literal value for a space character.
    TRAP     #15     *Output individual character.
    
    MOVE.B   D5,D1
    MOVE.B   #3,D0
    TRAP     #15

    MOVE.B  #',',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1

    BTST    #5,D1
    
    BEQ     VALID_MODE_0_MULS_EA_DN
    JSR     VALID_MODE_1
    
    MOVE.W  D4,D1
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
    JSR     PRINT_OPMODE_MULS_EA_DN
    JMP     RELOOP
    
PRINT_OPMODE_MULS_EA_DN
    BTST    #7,D1
    BNE     OPMODE_MULS_EA_DN_TEST_WORD
    JMP     OPMODE_MULS_EA_DN_TEST_LONG


VALID_MODE_0_MULS_EA_DN
    JSR     VALID_MODE_0
    MOVE.B  #',',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.B  #'D',D1
    TRAP    #15
    MOVE.W  D4,D1
    JSR     DN_REGISTER
    JMP     RELOOP

LSL_REG_SECT                    *Output the message 'LSL.'.
    LEA     LSL_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JSR     LSL_LSR_PRINT
    
*    MOVE.L  D1,D4
*    MOVE.B  #'W',D1
*    MOVE.B  #6,D0
*    TRAP    #15
*    MOVE.B  #' ',D1                         *Print the number in hexadecimal form, addressing is in base 16
*    MOVE.B  #6,D0
*    TRAP    #15
*    MOVE.L  D4,D1
*    BEQ     VALID_MODE_0_JSR
*    
*    JSR     VALID_MODE_1
    JMP     RELOOP
ASL_REG_SECT                    *Output the message 'ASL.'.
    LEA     ASL_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JSR     LSL_LSR_PRINT
    JMP     RELOOP
ROL_REG_SECT                    *Output the message 'ROL.'.
    LEA     ROL_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JSR     LSL_LSR_PRINT
    JMP     RELOOP
LSL_MEM_SECT                    *Output the message 'LSL.'.
    LEA     LSL_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    
    MOVE.L  D1,D4
    MOVE.B  #'W',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #' ',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    
    
    BEQ     VALID_MODE_0_JSR
    
    JSR     VALID_MODE_1
    JMP     RELOOP
ASL_MEM_SECT                    *Output the message 'ASL.'.
    LEA     ASL_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    
    MOVE.L  D1,D4
    MOVE.B  #'W',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #' ',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    BEQ     VALID_MODE_0_JSR
    
    JSR     VALID_MODE_1
    JMP     RELOOP
ROL_MEM_SECT                    *Output the message 'ROL.'.
    LEA     ROL_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
     MOVE.L  D1,D4
    MOVE.B  #'W',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #' ',D1                         *Print the number in hexadecimal form, addressing is in base 16
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.L  D4,D1
    BEQ     VALID_MODE_0_JSR
    
    JSR     VALID_MODE_1
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
    
    MOVE.B  #20,D2
    MOVE.B  D1,D4
    LSL.L   D2,D1
    MOVE.B  #29,D2
    LSR.L   D2,D1
    MOVE.W  D1,D5
    

    MOVE.B   #6,D0   *Picking TRAP task #6. 
    MOVE.B   #'D',D1 *Setting value in D1 to literal value for a space character.
    TRAP     #15     *Output individual character.
    
    MOVE.B   D5,D1
    MOVE.B   #3,D0
    TRAP     #15
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
    
    MOVE.B  #20,D2
    MOVE.B  D1,D4
    LSL.L   D2,D1
    MOVE.B  #29,D2
    LSR.L   D2,D1
    MOVE.W  D1,D5

    MOVE.B   #6,D0   *Picking TRAP task #6. 

    MOVE.B   #'D',D1 *Setting value in D1 to literal value for a space character.
    TRAP     #15     *Output individual character.
    
    MOVE.B   D5,D1
    MOVE.B   #3,D0
    TRAP     #15
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
    
    MOVE.B  #20,D2
    MOVE.B  D1,D4
    LSL.L   D2,D1
    MOVE.B  #29,D2
    LSR.L   D2,D1
    MOVE.W  D1,D5
    

    MOVE.B   #6,D0   *Picking TRAP task #6. 
    MOVE.B   #'D',D1 *Setting value in D1 to literal value for a space character.
    TRAP     #15     *Output individual character.
    
    MOVE.B   D5,D1
    MOVE.B   #3,D0
    TRAP     #15
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

PRINT_OPMODE_ADD_DN_EA
    BTST    #7,D1
    BNE     OPMODE_ADD_DN_EA_TEST_LONG
    BTST    #6,D1
    BNE     OPMODE_ADD_DN_EA_TEST_WORD
    JMP     OPMODE_ADD_DN_EA_TEST_BYTE
OPMODE_ADD_DN_EA_TEST_WORD
    MOVE.W  D1,D4                               *Copy to D4 because D1 will be manipulated
    MOVE.B  #'W',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.B  #' ',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1

    
    MOVE.B  #20,D2
    MOVE.B  D1,D4
    LSL.L   D2,D1
    MOVE.B  #29,D2
    LSR.L   D2,D1
    MOVE.W  D1,D5
    

    MOVE.B   #6,D0   *Picking TRAP task #6. 
    MOVE.B   #'D',D1 *Setting value in D1 to literal value for a space character.
    TRAP     #15     *Output individual character.
    
    MOVE.B   D5,D1
    MOVE.B   #3,D0
    TRAP     #15

    MOVE.B  #',',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1

    BTST    #5,D1
    
    BEQ     VALID_MODE_0_ADD_DN_EA
    JSR     VALID_MODE_1
    
    MOVE.W  D4,D1
    JMP     RELOOP



OPMODE_ADD_DN_EA_TEST_BYTE
    MOVE.W  D1,D4                               *Copy to D4 because D1 will be manipulated
    MOVE.B  #'B',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.B  #' ',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1

    MOVE.B  #20,D2
    MOVE.B  D1,D4
    LSL.L   D2,D1
    MOVE.B  #29,D2
    LSR.L   D2,D1
    MOVE.W  D1,D5
    

    MOVE.B   #6,D0   *Picking TRAP task #6. 
    MOVE.B   #'D',D1 *Setting value in D1 to literal value for a space character.
    TRAP     #15     *Output individual character.
    
    MOVE.B   D5,D1
    MOVE.B   #3,D0
    TRAP     #15

    MOVE.B  #',',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1

    BTST    #5,D1
    
    BEQ     VALID_MODE_0_ADD_DN_EA
    JSR     VALID_MODE_1
    
    MOVE.W  D4,D1
    JMP     RELOOP


    
OPMODE_ADD_DN_EA_TEST_LONG
    MOVE.W  D1,D4                               *Copy to D4 because D1 will be manipulated
    MOVE.B  #'L',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.B  #' ',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1


    MOVE.B  #20,D2
    MOVE.B  D1,D4
    LSL.L   D2,D1
    MOVE.B  #29,D2
    LSR.L   D2,D1
    MOVE.W  D1,D5
    

    MOVE.B   #6,D0   *Picking TRAP task #6. 
    MOVE.B   #'D',D1 *Setting value in D1 to literal value for a space character.
    TRAP     #15     *Output individual character.
    
    MOVE.B   D5,D1
    MOVE.B   #3,D0
    TRAP     #15

    MOVE.B  #',',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1

    BTST    #5,D1
    
    BEQ     VALID_MODE_0_ADD_DN_EA
    JSR     VALID_MODE_1
    
    MOVE.W  D4,D1
    JMP     RELOOP

VALID_MODE_0_ADD_DN_EA
    JSR     VALID_MODE_0
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
    MOVE.B  #3,D0
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
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
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
    MOVE.L  D1,D2                    
    JSR     OUTPUT_HEXADECIMAL
    
    MOVE.W  D4,D1                    *Copy original values back into D1
    RTS
    
VALID_MODE_111_POUND
    MOVE.B  #'#',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.B  #'$',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1
    MOVE.W  (A2)+,D6               *This gets the remaining word from the function
    
    CMP.W   #0,D6
    BEQ     RTS
    
    
    MOVE.L  D6,D1
    
    
    
    MOVE.L  D1,D2                    
    JSR     OUTPUT_HEXADECIMAL
    
    MOVE.W  D4,D1                    *Copy original values back into D1
    RTS
    
RTS
    RTS
VALID_MODE_111_LONG
    MOVE.L  (A2)+,D6
    
    MOVE.L  D6,D1
    MOVE.L  D1,D2                    
    JSR     OUTPUT_HEXADECIMAL
    CLR.L   D1
    
    RTS
    
PRINT_0000_RTS
    MOVE.B  #'0',D1
    MOVE.B  #6,D0
    TRAP    #15
    TRAP    #15
    TRAP    #15
    TRAP    #15
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
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
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
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
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
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    MOVE.W  D4,D1                    *Move original unaltered bits back to D1
    
    RTS

VALID_MODE_011
    LEA     PLUS,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS

VALID_MODE_SOURCE_DEST_1     *Options here are                 
    BTST    #7,D1
    BNE     VALID_MODE_SOURCE_DEST_11
    
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
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    
    MOVE.B  #')',D1
    MOVE.B  #6,D0
    TRAP    #15
    MOVE.W  D4,D1                    *Move original unaltered bits back to D1
    
    
    RTS
VALID_MODE_SOURCE_DEST_11    
    BTST    #11,D1
    BNE     VALID_MODE_SOURCE_DEST_111_POUND
    MOVE.B  #'$',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.W  D4,D1
    BTST    #9,D1
    BNE     VALID_MODE_SOURCE_DEST_111_LONG
    MOVE.W  (A2)+,D6               *This gets the remaining word from the function

    MOVE.W  D6,D1
    MOVE.L  D1,D2                    
    JSR     OUTPUT_HEXADECIMAL
    
    MOVE.W  D4,D1                    *Copy original values back into D1
    RTS
    
VALID_MODE_SOURCE_DEST_111_POUND
    MOVE.B  #'#',D1
    MOVE.B  #6,D0
    TRAP    #15
    
    MOVE.W  D4,D1
    MOVE.W  (A2)+,D6               *This gets the remaining word from the function

    MOVE.W  D6,D1
    MOVE.L  D1,D2                    
    JSR     OUTPUT_HEXADECIMAL
    
    MOVE.W  D4,D1                    *Copy original values back into D1
    RTS
VALID_MODE_SOURCE_DEST_111_LONG
    MOVE.L  (A2)+,D6
    MOVE.L  D6,D1
    MOVE.L  D1,D2                    
    JSR     OUTPUT_HEXADECIMAL
    CLR.L   D1
    
    RTS
VALID_MODE_SOURCE_DEST_0                         *Options are Dn, (An), or (An)+
    BTST    #7,D1
    BNE     VALID_MODE_SOURCE_DEST_01  
    JMP     VALID_MODE_SOURCE_DEST_00

VALID_MODE_SOURCE_DEST_00
    BTST    #6,D1
    BNE     VALID_MODE_SOURCE_DEST_001
    MOVE.B  #'D',D1
    MOVE.B  #6,D0
    TRAP    #15                   
    
    MOVE.W  D4,D1  
    MOVE.B  #20,D6                   *Set the bit shift to 20 so we can isolate the register number 
    LSL.L   D6,D1                    
    
    MOVE.B  #29,D6                   *Set the bit shift to 25 now to shift register number all the way to the right
    LSR.L   D6,D1
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    MOVE.W  D4,D1                    *Move original unaltered bits back to D1
    
    RTS
VALID_MODE_SOURCE_DEST_01    
    LEA     INDIRECT_ADDR_MESS,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    
    MOVE.W  D4,D1  
    MOVE.B  #20,D6                   *Set the bit shift to 20 so we can isolate the register number 
    LSL.L   D6,D1                    
    
    MOVE.B  #29,D6                   *Set the bit shift to 25 now to shift register number all the way to the right
    LSR.L   D6,D1
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    
    
    
    MOVE.B   #')',D1                 *Setting value in D1 to literal value for a space character.
    MOVE.B   #6,D0                   *Picking TRAP task #6. 
    TRAP     #15                     *Output individual character.
    MOVE.W  D4,D1                    *Copy original values back into D1
    BTST    #6,D1
    BNE     VALID_MODE_SOURCE_DEST_011 
    RTS

VALID_MODE_SOURCE_DEST_001
    MOVE.B  #'A',D1
    MOVE.B  #6,D0
    TRAP    #15                   
    
    MOVE.W  D4,D1  
    MOVE.B  #29,D6                   *Set the bit shift to 29 so we can isolate the register number 
    LSL.L   D6,D1                    
    LSR.L   D6,D1
    MOVE.B  #3,D0                   *Move trap task  #15 to convert to decimal and print  
    TRAP    #15
    MOVE.W  D4,D1                    *Move original unaltered bits back to D1
    
    RTS

VALID_MODE_SOURCE_DEST_011
    LEA     PLUS,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS

PRINT_INVALID_OPCODE
    LEA     INVALID_MESS,A1 
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
    
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
            BEQ     VALUE_ZERO
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
VALUE_ZERO
            JSR     OUTPUT0
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

OUTPUT_ERRORMESSAGE1
              LEA    ERRORMESSAGE1,A1
              MOVE.B  #14, D0
              TRAP    #15   
              BRA    GO_AGAIN
            SIMHALT             ; halt simulator
CR      EQU     $0D             ASCII code for Carriage Return
LF      EQU     $0A             ASCII code for Line Feed
MOVE_MESS       DC.B    'MOVE.',0
NOP_MESS        DC.B    'NOP',0
MOVEA_MESS      DC.B    'MOVEA.',0
ADDI_MESS       DC.B    'ADDI.',0
MOVEQ_MESS      DC.B    'MOVEQ ',0
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
MESSAGE0         DC.B 'Welcome to Disassembler.',CR,LF,'Created by: Abhi Trivedi, Conor Van Achte, and Samuel Meyerding.',CR,LF,0       
MESSAGE1         DC.B 'Please enter a starting address for your program: ',0
MESSAGE2         DC.B 'Please enter an ending address for your program: ',0
ERRORMESSAGE1    DC.B 'Your ending address is less than the starting address',CR,LF,0
ENDOFPROGRAM     DC.B 'Do you want to disassemble some more memory? (y/n)',CR,LF,0
NEWLINE          DC.B CR,LF,0

QUIT

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
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
