            
            ;# ===============================================================//
            ;#Code l {Multiply_16}                                   16*16=16 //
            ;# ===============================================================//
            ;PHP
            ;REP #$30
            ;LDA #$0000
;{-}        ;LDX Multiply_16.m1
            ;BEQ {+Return}
            ;LSR Multiply_16.m1
            ;BCC {+}
            ;CLC
            ;ADC Multiply_16.m2
;{+}        ;ASL Multiply_16.m2
            ;BRA {-}
;{+Return}  ;STA Multiply_16.p
            ;PLP
            ;RTL
            
            ;# ===============================================================//
            ;#Code l {Divide_16}                                     16/16=16 //
            ;# ===============================================================//
            ;PHP
            ;REP #$30
            ;STZ Divide_16.q
            ;LDA Divide_16.d
            ;LDX Divide_16.n
            ;LDY #$0001
;{-}        ;ASL A
            ;BCS {+}
            ;INY
            ;CPY #$0011
            ;BNE {-}
;{+}        ;ROR A
;{-}        ;PHA
            ;TXA
            ;SEC
            ;SBC $01,S
            ;BCC {+}
            ;TAX
;{+}        ;ROL Divide_16.q
            ;PLA
            ;LSR A
            ;DEY
            ;BNE {-}
            ;LDA Divide_16.q
            ;STX Divide_16.r
            ;PLP
            ;RTL
            
            ;# ===============================================================//
            ;#Code l {Rng}                                                    //
            ;# ===============================================================//
            ;PHP
            ;PHB
            ;PEA $0000
            ;PLB
            ;PLB
            ;REP #$20
            ;LDA Rng.number
            ;SEP #$20
            ;STA M7A
            ;XBA
            ;STA M7A
            ;LDA #$D3
            ;STA M7B
            ;REP #$20
            ;LDA RDMPY24
            ;INC A
            ;XBA
            ;STA Rng.number
            ;PLB
            ;PLP
            ;RTL
            
            ;#Data l sinusoid{
                $0000
                $0032
                $0062
                $008E
                $00B5
                $00D5
                $00ED
                $00FB
                $0100
                $00FB
                $00ED
                $00D5
                $00B5
                $008E
                $0062
                $0032
                $0000
                $FFCE
                $FF9E
                $FF72
                $FF4B
                $FF2B
                $FF13
                $FF05
                $FF00
                $FF05
                $FF13
                $FF2B
                $FF4B
                $FF72
                $FF9E
                $FFCE
                $0000
                $0032
                $0062
                $008E
                $00B5
                $00D5
                $00ED
                $00FB
            }
            
            ;# ===============================================================//
			;#                                                                //
			;#                                                                //
			;#                                                                //
            ;# ===============================================================//

