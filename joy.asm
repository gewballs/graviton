            
            ;# ===============================================================//O
            ;#Code w {Joy}                                                    //
            ;# ===============================================================//
            ;PHP
            ;REP #$30
            ;
            ;LDX #$0000
;{-}        ;LDA joy,X
            ;BEQ {Trigger}
            ;CMP #$3030// Soft reset
            ;BNE {+}
            ;JMP Vector.Reset
;{+}        ;CLC
            ;EOR joy.last,X
            ;BNE {++}
            ;LDA joy.hold,X
            ;BEQ {+}
            ;DEC joy.hold,X
            ;LDA #$0000
            ;BRA {Trigger}
;{+}        ;SEC
            ;DEC joy.cool,X
            ;BEQ {+}
            ;LDA #$0000
            ;BRA {Trigger}
;{++}       ;LDA #$000F
            ;STA joy.hold,X
;{+}        ;LDA #$000F
            ;STA joy.cool,X
            ;LDA joy,X
            ;BCS {Trigger}
            ;EOR joy.last,X
            ;AND joy,X
;{Trigger}  ;STA joy.edge,X
            ;AND #$1000// Pause
            ;BEQ {+}
            ;LDA #$00FF
            ;EOR pause
            ;STA pause
            ;
;{+}        ;INX
            ;INX
            ;CPX #$0008
            ;BCC {-}
            ;
            ;PLP
            ;RTS
            
            ;# ===============================================================//
            ;#                                                                //
            ;#                                                                //
            ;#                                                                //
            ;# ===============================================================//

