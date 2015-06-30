            ;#Code w {Gravity}
			;PHP
			;REP #$30
			;
            ;# Gauge ===============
;{+Clamp}			;LDX $1337
            ;LDA joy              // !!! DEBUG !!!
			;BIT #$0400           // Down
			;BEQ {+Up}
			;LDA gravity0
			;DEC A
			;BRA {+Clamp}
;{+Up}      ;BIT #$0800
            ;BEQ {+Neutral}
			;LDA gravity0
            ;INC A
			;BRA {+Clamp}
;{+Neutral} ;LDA gravity0
			;
;{+Clamp}   ;BMI {+Minus}
			;CMP #$0020
			;BCC {+Write}
			;LDA #$001F
			;BRA {+Write}
;{+Minus}   ;CMP #$FFE1
			;BCS {+Write}
			;LDA #$FFE1
;{+Write}   ;STA gravity1
			;
			;PLP
			;RTS

            ;# ===============================================================//
            ;#                                                                //
            ;# ===============================================================//

