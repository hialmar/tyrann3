;
; **** ZP ABSOLUTE ADRESSES **** 
;
a02 = $02
a03 = $03
a04 = $04
a05 = $05
a09 = $09
a0A = $0A
a0F = $0F
a10 = $10
a11 = $11
a70 = $70
a71 = $71
a72 = $72
a73 = $73
a74 = $74
a75 = $75
a76 = $76
a77 = $77
a78 = $78
a79 = $79
a7A = $7A
a7B = $7B
a7C = $7C
a7D = $7D
a7E = $7E
a7F = $7F
;
; **** ZP POINTERS **** 
;
p09 = $09
p0C = $0C
p10 = $10
p70 = $70
p72 = $72
p74 = $74
p76 = $76
p7A = $7A
p7C = $7C
;
; **** ABSOLUTE ADRESSES **** 
;
a02E3 = $02E3
a7FFD = $7FFD
a7FFE = $7FFE
a7FFF = $7FFF
;
; **** POINTERS **** 
;
p8C00 = $8C00
pA141 = $A141
pA155 = $A155
pA3C3 = $A3C3
pA3D7 = $A3D7
pAF79 = $AF79
pAF8D = $AF8D
pBDD9 = $BDD9
pBDED = $BDED
pBE00 = $BE00
;
; **** EXTERNAL JUMPS **** 
;
eF089 = $F089
eF17E = $F17E

        * = $8E00

        JSR s8E20
        JSR s8EB0
        JSR s8FA0
        JSR s8F20
        JSR s9050
        RTS 

        JSR s8E20
        JSR s8EB0
        JSR s8F80
        RTS 

        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
s8E20   LDA a7FFD
        STA a78
        ORA #$10
        STA a79
        LDA a7FFF
        BEQ b8E63
        LDA #<pA3C3
        STA a02
        LDA #>pA3C3
        STA a03
        LDA #<pA141
        STA a70
        LDA #>pA141
        STA a71
        STA a73
        LDA #$54
        STA a72
        LDA #<pBDD9
        STA a74
        LDA #>pBDD9
        STA a75
        STA a77
        LDA #$EC
        STA a76
        LDA #<pAF79
        STA a7A
        LDA #>pAF79
        STA a7B
        STA a7D
        LDA #$A1
        STA a7C
        JMP j8E95

b8E63   LDA #<pA3D7
        STA a02
        LDA #>pA3D7
        STA a03
        LDA #<pA155
        STA a70
        LDA #>pA155
        STA a71
        STA a73
        LDA #$68
        STA a72
        LDA #<pBDED
        STA a74
        LDA #>pBDED
        STA a75
        LDA #>pBE00
        STA a77
        LDA #<pBE00
        STA a76
        LDA #<pAF8D
        STA a7A
        LDA #>pAF8D
        STA a7B
        STA a7D
        LDA #$B5
j8E95   STA a7C
        LDA a02
        STA a04
        LDA a03
        STA a05
        LDA #<p8C00
        STA a09
        LDA #>p8C00
        STA a0A
        LDA a7FFE
        STA a7E
        RTS 

        NOP 
        NOP 
        NOP 
s8EB0   LDX #$5C
b8EB2   JSR s8EC0
        JSR s8EF0
        JSR s8F70
        DEX 
        BNE b8EB2
        RTS 

        NOP 
s8EC0   LDY #$00
        LDA #$10
        STA (p72),Y
        LDA a78
        INY 
        STA (p72),Y
        LDA a79
        STA (p70),Y
        DEY 
        LDA a78
        STA (p70),Y
        CLC 
        LDA a70
        ADC #$28
        STA a70
        BCC b8EDF
        INC a71
b8EDF   CLC 
        LDA a72
        ADC #$28
        STA a72
        BCC b8EEA
        INC a73
b8EEA   RTS 

        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
s8EF0   LDY #$00
        LDA #$10
        STA (p76),Y
        LDA a78
        INY 
        STA (p76),Y
        LDA a79
        STA (p74),Y
        DEY 
        LDA a78
        STA (p74),Y
        SEC 
        LDA a74
        SBC #$28
        STA a74
        BCS b8F0F
        DEC a75
b8F0F   SEC 
        LDA a76
        SBC #$28
        STA a76
        BCS b8F1A
        DEC a77
b8F1A   RTS 

        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
s8F20   LDX #$54
b8F22   JSR s8F30
        JSR s8F50
        JSR s8F70
        DEX 
        BNE b8F22
        RTS 

        NOP 
s8F30   LDY #$00
        LDA a7E
        STA (p7A),Y
        INY 
        LDA #$10
        STA (p7A),Y
        SEC 
        LDA a7A
        SBC #$28
        STA a7A
        BCS b8F46
        DEC a7B
b8F46   RTS 

        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
s8F50   LDY #$00
        LDA a7E
        STA (p7C),Y
        INY 
        LDA #$10
        STA (p7C),Y
        CLC 
        LDA a7C
        ADC #$28
        STA a7C
        BCC b8F66
        INC a7D
b8F66   RTS 

        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
s8F70   LDA #$FE
        STA a7F
b8F74   DEC a7F
        NOP 
        NOP 
        BNE b8F74
        RTS 

        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
s8F80   LDX #$5C
        LDA #$00
        STA a7E
b8F86   JSR s8F30
        JSR s8F50
        JSR s8F70
        DEX 
        BNE b8F86
        RTS 

        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
s8FA0   LDX #$13
b8FA2   JSR s8FD0
        JSR s8FB0
        DEX 
        BNE b8FA2
        RTS 

        NOP 
        NOP 
        NOP 
        NOP 
s8FB0   TXA 
        PHA 
        LDX #$08
b8FB4   CLC 
        LDA a02
        ADC #$28
        STA a02
        BCC b8FBF
        INC a03
b8FBF   DEX 
        BNE b8FB4
        LDA a02
        STA a04
        LDA a03
        STA a05
        PLA 
        TAX 
        RTS 

        NOP 
        NOP 
        NOP 
s8FD0   TXA 
        PHA 
        LDX #$00
        STX a02E3
j8FD7   LDA a04
        STA a10
        LDA a05
        STA a11
        JSR s9000
        TAX 
        BEQ b8FF1
        JSR s9010
        INC a04
        BNE b8FEE
        INC a05
b8FEE   JMP j8FD7

b8FF1   PLA 
        TAX 
        RTS 

        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
s9000   LDY #$00
        LDA (p09),Y
        INC a09
        BNE b900A
        INC a0A
b900A   RTS 

        NOP 
        NOP 
        NOP 
        NOP 
        NOP 
s9010   JSR eF17E
        LDY #$00
b9015   STY a0F
        LDA (p0C),Y
        ORA #$40
        LDY #$00
        STA (p10),Y
        JSR eF089
        LDY a0F
        INY 
        CPY #$08
        BNE b9015
        RTS 

        BRK #$00
        BRK #$00
        BRK #$00
        JSR s8E20
        LDX #$5C
        LDY #$01
b9037   LDA a78
        STA (p72),Y
        JSR b8EDF
        DEX 
        BNE b9037
        RTS 

        BRK #$00
        BRK #$00
        BRK #$00
        BRK #$00
        BRK #$00
        BRK #$00
        BRK #$00
s9050   LDX #$08
b9052   JSR s9060
        JSR s9080
        JSR s8F70
        DEX 
        BNE b9052
        RTS 

        NOP 
s9060   LDY #$01
        CLC 
        LDA a7C
        ADC #$28
        STA a7C
        BCC b906D
        INC a7D
b906D   LDA #$10
        STA (p7C),Y
        CLC 
        LDA a7C
        ADC #$28
        STA a7C
        BCC b907C
        INC a7D
b907C   RTS 

        NOP 
        NOP 
        NOP 
s9080   LDY #$01
        SEC 
        LDA a7A
        SBC #$28
        STA a7A
        BCS b908D
        DEC a7B
b908D   LDA #$10
        STA (p7A),Y
        SEC 
        LDA a7A
        SBC #$28
        STA a7A
        BCS b909C
        DEC a7B
b909C   RTS 

