*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
*Testing Code
       LSL      $8 *Word is only valid case.
       LSR      $0
       ASL      $0
       ASR      $0
       ROL      $0
       ROR      $0
       LSL.L    #8,D3
    BRA     DO_NOTHING
    CMP     #0,D3
    BEQ     DO_NOTHING
    
DO_NOTHING
    ADD.B   -(A3),D5
    SUB.B   -(A3),D5
    add.l D4,(A3)
    CMP.B   #3,D3
    CMP.L   (A3),D5
    CMP.W   #$1234,D6
    MOVE.L  #$12348999,D3
    MOVE.W  #$5678,D4
    
    MOVE.B  #1,D1
    LSR.L   D1,D2
    LSL.W   D1,D2
    ASR.B   D1,D2
    ASL.W   D1,D2
    ROL.W    D1,D2
    ROR.W    D1,D2
    
    LSR.L   #1,D2
    MOVE.L #$1234,D4
    MOVE.L  #1,D3
    DIVU   D3,D4
    DIVU.W   D3,D4
    DIVU  D4,D5
    
    MOVE.L #$1234,D4 
    DIVU  #$1234,D4
    
    DIVU.W  #2,D4
    DIVU.W  D3,D4

    MULS   D3,D4
    MULS  D4,D5
    
    MOVE.L #$1234,D4 
    MULS  #$1234,D4
    
    MULS.W  #2,D4
    MULS.W  D3,D4
    ADD.B   #4,D1
    SUB.B   #68,D1
    SUB.B   D3,D4
    SUB.B   (A3),D6
    SUB.B   -(A3),D5
    SUB.B   D7,-(A3)
    CLR.L   D1
    CLR.B   D2
    CLR.W   D5
    CLR.L   (A4)
    CLR.W   (A4)+
    CLR.W   -(A4)
    
       MOVEA.L   #$11111111,A2
       MOVEA.L   #$1111,A2
       MOVEA.W   #223,A2
       MOVEA.L   A1,A2
       MOVEA.L   D1,A2
       MOVEA.L   #2,A2
       
       MOVEA.L   #$345D,A4
       MOVEA.W   (A4)+,A3
       MOVEA.L   -(A2),A5
       ADDA.L   #$11111111,A2
       ADDA.L   #$1111,A2
       ADDA.W   #223,A2
       ADDA.L   A1,A2
       ADDA.L   D1,A2
       ADDA.L   #2,A2
       ADDA.L   #223,A2

       ADDA.W   A5,A7
       ADDA.W   A2,A5
       
       MOVEA.W   A5,A7
       MOVEA.W   #16,A5
       MOVEA.L   A2,A5
       MOVEA.L   -(A2),A5
       
       MOVEQ     #7,D2
       MOVEQ     #2,D5
       MOVEQ     #5,D3
       
       MOVE.L    #$123,D5
       MOVE.L    #$1237,D7
       
       MOVE.W    #$1231,D7
       MOVE.L    #$12311111,D7
       MOVE.L    #$567123,D5

       MOVE.B    D2,D3
       MOVE.W    D1,D4
       MOVE.L    D7,D3
              
       MOVE.L    #$123,D7

       
      
       MOVE.B    #12,D3
       MOVE.W    #123,D4
       MOVE.L    #167,D3
       
       MOVE.B    #$12,D3
       MOVE.W    #$123,D4
       MOVE.L    #$167,D3
    
       MOVEM     (A5),D0-D1
       MOVEQ     #1,D1
       MOVEQ     #5,D3
       MOVEQ     #0,D6
       MOVEQ     #3,D1
       
       
       ADDA.L   #$11111111,A2
       ADDA.L   #$1111,A2
       ADDA.W   #223,A2
       ADDA.L   A1,A2
       ADDA.L   D1,A2
       ADDA.L   #2,A2
       ADDA.L   #223,A2
       ADDA.W   A5,A7
       ADDA.W   A2,A5
       ADDA.W   (A4)+,A3
       ADDA.L   -(A2),A5
       
       MOVEA.W   D2,A2
       MOVEA.W   (A4)+,A3
       MOVEA.L   -(A2),A5
       
       BTST     #0,D1
       BTST     #6,(A6)
       BTST     #12,(A5)+
       BTST     #3,-(A4)
       BTST     #2,$1234
       BTST     #7,$12341234
       BTST     D2,D7
       BTST     D3,#4
       
       ADD.L    D1,D2
       ADD.B    D5,D7
       ADD.W    D3,D4
       ADD.L    #34,D6
       ADDA.L   A1,A2
       MULS.W   D1,D2
       
       ADDI.L   #2,D1
       ADDI.W   #4,D6
       ADDI.B   #4,D7
       ADDI.W   #8,D3
       ADDI.W   #1,D2
       ADDI.B   #8,D5
       ADDI.B   #3,D1
       ADDI.B   #127,D1
* All have been tested.      
       ADD.L    D1,D2
       ADD.B    D5,D7
       ADD.W    D3,D4
       ADD.L    #34,D6
       ADDA.L   A1,A2
       MULS.W   D1,D2

* All have been tested.
       NOP
       
       BCC     SKIP        *6400   Condition: %0100
       BCC     INPUT        *6400   Condition: %0100
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
SKIP
INPUT

* All have been tested.
       AND.W    D1,D2
       BTST     D1,#4


    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
