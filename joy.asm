            ;#Name $0010 JOY_r
            ;#Name $0020 JOY_l
			;#Name $0040 JOY_x
			;#Name $0080 JOY_a
			;#Name $0100 JOY_right
			;#Name $0200 JOY_left
			;#Name $0400 JOY_down
			;#Name $0800 JOY_up
			;#Name $1000 JOY_start
			;#Name $2000 JOY_select
			;#Name $4000 JOY_y
			;#Name $8000 JOY_b

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

