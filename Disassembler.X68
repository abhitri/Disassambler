*-----------------------------------------------------------
* Title      : Disassembler test.
* Written by : Samuel Meyerding
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

* All have been tested.
       BTST     #0,D1
       MOVE.W   D0,D1
       MOVEA.L  A0,A1
       ADDI.L   #4,D1   *Assembler changes this to ADDQ unless the number being added is greater than #8.
       ADDI.L   #9,D1
       LEA      B_MESS,A4
       CLR.L    D1
       JSR      DUMMY_SUB
       MOVEM.L  (A1),D0-D1
       ADDQ.B   #1,D0
       MOVEQ.L  #1,D1
       DIVU.W   D1,D0
       OR.L     D1,D0
       SUB.L    D0,D1
       CMP.W    D1,D2

* All have been tested.      
       ADD.W    D1,D2
       ADDA.L   A1,A2
       MULS.W   D1,D2
       AND.W    D1,D2
       BTST     D1,#4
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

* All have been tested.
       NOP
       BCC     SKIP        *6400   Condition: %0100
       BCS     SKIP        *6500   Condition: %0101
       BEQ     SKIP        *6700   Condition: %0111
       BGE     SKIP        *6C00   Condition: %1100
       BGT     SKIP        *6E00   Condition: %1110
       BHI     SKIP        *6200   Condition: %0010
       BLE     SKIP        *6F00   Condition: %1111
       BLS     SKIP        *6300   Condition: %0011
       BLT     SKIP        *6D00   Condition: %1101
       BMI     SKIP        *6B00   Condition: %1011
       BNE     SKIP        *6600   Condition: %0110
       BPL     SKIP        *6A00   Condition: %1010
       BVC     SKIP        *6800   Condition: %1000
       BVS     SKIP        *6900   Condition: %1001
       BRA     SKIP        *6000   Condition: %0000
                
SKIP                                  
    MOVE.L  #$1000,A2       *Starting addres for code to be disassembled.
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
    JMP     RELOOP
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
    JMP     RELOOP           
    
BIN_011_FOURTH  *Possibilities are Bcc and MOVEQ.
    BTST    #12,D1
    BNE     MOVEQ_SECT
*Condition Section.**********************************************

B_COND_SECT     *It has been determined to be a Conditional Branch. Now to determine the condition.
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
    JMP     RELOOP
BIN_111_FOURTH  *Possibilities are LSL, LSR, ASR, ASL, ROL, and ROR. These can be register shifts or memory shifts.
BIN_1110_FIFTH
    MOVE.B  D1,D2
    AND.B   #%11000000,D2
    CMP.B   #%11000000,D2
    BEQ     MEM_SHIFTS
REG_SHIFTS      *This has been determined to be a register shift.
    MOVE.B  D1,D2           *Create a copy of D1 in D2 in order to mask some of its bits and keep original.
    AND.B   #%00011000,D2   *Significant bits for determining what kind of shift.
    CMP.B   #%00001000,D2   *Compare with the shift with the middle value in the range.
    BGT     ROL_ROR_SECT    *If greater than, it's a rotation.
    BEQ     LSL_LSR_SECT    *If greater than, it's a Logical Shift. Else, Continue to Arithmetic shifts.
ASR_ASL_SECT    *Arithmeitc shift. Determines direction.
    BTST    #8,D1
    BNE     ASL_SECT
ASR_SECT        *Output the message 'ASR.'.
    LEA     ASR_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
LSL_LSR_SECT    *Logical Shift. Determines direction.
    BTST    #8,D1
    BNE     LSL_SECT
LSR_SECT        *Output the message 'LSR.'.
    LEA     LSR_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP    
ROL_ROR_SECT    *Rotation. Determines direction.
    BTST    #8,D1
    BNE     ROL_SECT
ROR_SECT        *Output the message 'ROR.'.
    LEA     ROR_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
MEM_SHIFTS      *This is a memory shift.
    MOVE.W  D1,D2                  *Create a copy of D1 in D2 in order to mask some of its bits and keep original.
    AND.W   #%0000011000000000,D2   *Significant bits for determining what kind of shift.
    CMP.W   #%0000001000000000,D2   *Compare with the shift with the middle value in the range.
    BGT     ROL_ROR_SECT
    BEQ     LSL_LSR_SECT
    BRA     ASR_ASL_SECT
    
BIN_1101_FOURTH *Possibilities are ADD and ADDA.
    MOVE.W  D1,D2           *Create a copy of D1 in D2 in order to mask some of its bits and keep original.
    AND.W   #%0000000011000000,D2   *These bits are required to tell the difference between ADDA and ADD.
    CMP.W   #%0000000011000000,D2
    BEQ     ADDA_SECT
ADD_SECT
    LEA     ADD_MESS,A1     *Outputs the message 'ADD.'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
ADDA_SECT
    LEA     ADDA_MESS,A1    *Outputs the message 'ADDA.'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
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
    JMP     RELOOP     
SUB_SECT                    *Outputs the message 'SUB.'.
    LEA     SUB_MESS,A1 
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP          
DIVU_SECT                   *Outputs the message 'DIVU.'.
    LEA     DIVU_MESS,A1 
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP 
MOVEA_SECT
    LEA     MOVEA_MESS,A1   *Outputs the message 'MOVEA.'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP    
ADDQ_SECT     
    LEA     ADDQ_MESS,A1    *Outputs the message 'ADDQ.'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP 
MOVEM_SECT       
    LEA     MOVEM_MESS,A1   *Outputs the message 'MOVEM.'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP 
JSR_SECT    
    LEA     JSR_MESS,A1     *Outputs the message 'JSR'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
LEA_SECT
    LEA     LEA_MESS,A1     *Outputs the message 'LEA'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
MOVEQ_SECT
    LEA     MOVEQ_MESS,A1   *Output the message 'MOVEQ.'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
MULS_SECT
    LEA     MULS_MESS,A1    *Output the message 'MULS.'.
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
LSL_SECT                    *Output the message 'LSL.'.
    LEA     LSL_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
ASL_SECT                    *Output the message 'ASL.'.
    LEA     ASL_MESS,A1
    MOVE.B  #14,D0      
    TRAP    #15
    JMP     RELOOP
ROL_SECT                    *Output the message 'ROL.'.
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
    MOVE.B  #%10110111,D7       *Valid modes for this OPCode.
    JSR     EFF_ADDR_MODE_REG   *Check value in mode for validity.
    JMP     RELOOP              *Reiterate to beginning of disassembler.
BTST_DYNAMIC_SECT
    LEA     BTST_MESS,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #%10111111,D7       *Valid modes for this OPCode.
    JSR     EFF_ADDR_MODE_REG   *Check value in mode for validity.
    JMP     RELOOP              *Reiterate to beginning of disassembler.
DUMMY_SUB
    RTS
    

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
EFF_ADDR_MODE_REG       *Modifies D2 and D3.
    *MOVE.W  $1234,D1   
    BTST    #5,D1
    BNE     MODE_1
MODE_0      *Possibilities are Dn, An, (An), (AN)+
    BTST    #4,D1
    BNE     MODE_01
MODE_00     *Possibilities are Dn, An
    BTST    #3,D1
    BNE     MODE_ADDR_DIRECT
MODE_DAT_DIRECT
    BTST    #0,D7                   *Test if this mode is valid for the current OPCode.
    BNE     VALID_MODE              *If bit was set, goto case for valid mode.
    BRA     INVALID_MODE            *Else, goto case for invalid mode.
MODE_01     *Possibilities are (An), (An)+
    BTST    #3,D1
    BNE     MODE_ADDR_INDIR_INCR
MODE_ADDR_INDIR
    BTST    #2,D7                   *Test if this mode is valid for the current OPCode.
    BNE     VALID_MODE              *If bit was set, goto case for valid mode.
    BRA     INVALID_MODE            *Else, goto case for invalid mode.
MODE_1
    BTST    #4,D1
    BNE     MODE_10
MODE_10
    BTST    #3,D1
    BNE     INVALID_MODE
MODE_ADDR_INDIR_DECR
    BTST    #5,D7                   *Test if this mode is valid for the current OPCode.
    BNE     VALID_MODE              *If bit was set, goto case for valid mode.
    BRA     INVALID_MODE            *Else, goto case for invalid mode.     
MODE_11     *Possibilities are (xxx).W, (xxx).L, and #<data>
    BTST    #3,D1
    BEQ     INVALID_MODE
MODE_111    *Possibilities are (xxx).W, (xxx).L, and #<data>
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
