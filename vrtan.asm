
;# !!!DEBUG!!!
;#Data w hit.tl.sprite{
    $00
    $00 $00 $3C7F $00
}
;#Data w hit.bl.sprite{
    $00
    $00 $F8 $BC7F $00
}
;#Data w hit.br.sprite{
    $00
    $F8 $F8 $FC7F $01
}
;#Data w hit.tr.sprite{
    $00
    $F8 $00 $7C7F $01
}

;#Name $0800 hit.show

;#Code w {DrawHitbox}
;PHP
;SEP #$20
;STZ Draw_Sprite.obj_p_override
;LDA vrtan.x0
;CLC
;ADC vrtan.hit.x
;STA Draw_Sprite.x
;LDA vrtan.y0
;CLC
;ADC vrtan.hit.y
;STA Draw_Sprite.y
;STZ Draw_Sprite.data_bank
;REP #$20
;LDA #hit.tl.sprite
;STA Draw_Sprite.data_i
;STZ Draw_Sprite.char_i
;JSR Draw_Sprite
;SEP #$20
;LDA vrtan.y0
;CLC
;ADC vrtan.hit.y
;ADC vrtan.hit.height
;STA Draw_Sprite.y
;STZ Draw_Sprite.data_bank
;REP #$20
;LDA #hit.bl.sprite
;STA Draw_Sprite.data_i
;STZ Draw_Sprite.char_i
;JSR Draw_Sprite
;SEP #$20
;LDA vrtan.x0
;CLC
;ADC vrtan.hit.x
;ADC vrtan.hit.width
;STA Draw_Sprite.x
;STZ Draw_Sprite.data_bank
;REP #$20
;LDA #hit.br.sprite
;STA Draw_Sprite.data_i
;STZ Draw_Sprite.char_i
;JSR Draw_Sprite
;SEP #$20
;LDA vrtan.y0
;CLC
;ADC vrtan.hit.y
;STA Draw_Sprite.y
;STZ Draw_Sprite.data_bank
;REP #$20
;LDA #hit.tr.sprite
;STA Draw_Sprite.data_i
;STZ Draw_Sprite.char_i
;JSR Draw_Sprite
;PLP
;RTS

	;#Code w {Vrtan}
	;PHP
	;REP #$30
	;
	;LDX #$0000
	;JSR (vrtan.state,X)
	;
;LDA hit.show
;BEQ {+}
;JSR DrawHitbox
;{+}
	;
	;PLP
	;RTS
	
	;#Code w {Vrtan.Player}
	;RTS
	
	;#Code w {Vrtan.Idle}
	;
	;# Input ===========================
	;LDA joy1
	
	
	;BIT #$0300 // Right or Left
	;BEQ {+}
	;LDA vrtan.x0
	;CLC
	;ADC vrtan.hit.x
	;STA Move.x0
	;LDA vrtan.y0
	;CLC
	;ADC vrtan.hit.y
	;STA Move.y0
	;LDA joy1
	;BIT #$0100 // Right
	;BEQ {+Left}
	;BIT #$4000 // X Button
	;BNE {+Fast}
	;LDA #$0001
	;BRA {+Slow}
;{+Fast}	;LDA #$0002
;{+Slow}	;STA Move.dx
	;BRA {+Right}
;{+Left}	;BIT #$4000 // X Button
	;BNE {+Fast}
	;LDA #$FFFF
	;BRA {+Slow}
;{+Fast}	;LDA #$FFFE
;{+Slow}	;STA Move.dx
;{+Right}	;
	;LDA #$0000
	;STA Move.dy
	;LDA vrtan.hit.width
	;STA Move.width
	;LDA vrtan.hit.height
	;STA Move.height
	;JSR Move.X
	;LDA Move.x1
	;SEC
	;SBC vrtan.hit.x
	;AND #$00FF
	;STA vrtan.x0
	;LDX joy1
	;
	;TXA
;{+}	;BIT #$8000 // Up
	;BEQ {+}
	;LDA vrtan.y0
	;DEC A
	;DEC A
	;DEC A
	;AND #$00FF
	;STA vrtan.y0
	;
;{+}	;LDA joy1.edge
	;BIT #$0020 // L
	;BEQ {+}
	;LDA hit.show
	;EOR #$FFFF
	;STA hit.show
	;
;{+}	;LDA joy1.edge
	;BIT #$0010 // R
	;BEQ {+}
	;LDA vrtan.hit.width
	;CMP #$0008
	;BEQ {+Big}
	;LDA #$0008
	;STA vrtan.hit.width
	;LDA #$0018
	;STA vrtan.hit.height
	;BRA {+}
;{+Big}	;LDA #$0020
	;STA vrtan.hit.width
	;LDA #$0028
	;STA vrtan.hit.height
;{+}	;
	;# Draw Script =====================
	;TXA
	;BIT #$0F00
	;BNE {+Walk}
	;LDA vrtan.body.script
	;CMP #vrtan.body.idle.r.script
	;BEQ {+}
	;LDA #vrtan.body.idle.r.script
	;STA vrtan.body.script
	;STZ vrtan.body.frame
	;STZ vrtan.body.timer
	;LDA #vrtan.legs.idle.r.script
	;STA vrtan.legs.script
	;STZ vrtan.legs.frame
	;STZ vrtan.legs.timer
	;BRA {+}
;{+Walk}	;LDA vrtan.body.script
	;CMP #vrtan.body.walk.r.script
	;BEQ {+}
	;LDA #vrtan.body.walk.r.script
	;STA vrtan.body.script
	;LDA #vrtan.legs.walk.r.script
	;STA vrtan.legs.script
	;STZ vrtan.legs.frame
	;STZ vrtan.legs.timer
;{+}	;
	;# Grounded Test ====================
	;LDA vrtan.x0
	;CLC
	;ADC vrtan.hit.x
	;STA Grounded.x
	;LDA vrtan.y0
	;CLC
	;ADC vrtan.hit.y
	;STA Grounded.y
	;LDA vrtan.hit.width
	;STA Grounded.width
	;LDA vrtan.hit.height
	;STA Grounded.height
	;JSR Grounded
	;
	;BCS {+Pass}
	;LDA vrtan.y0
	;INC A
	;AND #$00FF
	;STA vrtan.y0
;{+Pass}	;
	;
	;RTS
	
	;#Code w {Vrtan.Walk}
	;RTS
	
	;#Code w {Vrtan.Jump}
	;RTS
	
	;#Code w {Vrtan.Punch}
	;RTS
	
	;#Code w {Vrtan.JumpPunch}
	;RTS
	
	;#Code w {Vrtan.Uppercut}
	;RTS
	
	;#Code w {Vrtan.Crush}
	;RTS
	
	;#Code w {Vrtan.Spike}
	;RTS
	
	;#Code w {Vrtan.Respawn}
	;RTS




	;#Code w {Grounded} ================================================
	;PHP
	;PHB
	;REP #$30
	;PEA $7E00
	;PLB
	;PLB
	;
	;LDA Grounded.x // Find initial level tile to test
	;TAY
	;LSR A
	;LSR A
	;LSR A
	;AND #$001F
	;STA Grounded.dx
	;LDA Grounded.y
	;CLC
	;ADC Grounded.height
	;AND #$00F8
	;ASL A
	;ASL A
	;CLC
	;ADC Grounded.dx
	;ASL A
	;TAX
	;
	;TYA // Find number of tiles to test
	;LSR A
	;LSR A
	;LSR A
	;STA Grounded.dx
	;TYA
	;CLC
	;ADC Grounded.width
	;DEC A
	;LSR A
	;LSR A
	;LSR A
	;SEC
	;SBC Grounded.dx
	;INC A
	;TAY
	;
;{-}	;LDA level,X
	;AND #$03FF
	;CMP #$0009 // Stone character
	;BEQ {+Pass}
	;TXA
	;AND #$FFC0
	;STA Grounded.row
	;TXA
	;INC A
	;INC A
	;AND #$003F
	;ORA Grounded.row
	;TAX
	;DEY
	;BNE {-}
	;
	;PLB
	;PLP
	;CLC // Fail
	;RTS
	;
;{+Pass}	;PLB
	;PLP
	;SEC // Pass
	;RTS





	;#Code w {Move.X} ==================================================
	;PHP
	;PHB
	;REP #$30
	;PEA $7E00
	;PLB
	;PLB
	;
	;STA $001337
	;# Calculate number of tiles to test in X
	;LDA Move.dx
	;BMI {+Neg}
	;LDA Move.x0
	;CLC
	;ADC Move.width
	;DEC A
	;BRA {+Pos}
;{+Neg}	;LDA Move.x0
;{+Pos}	;TAY
	;LSR A
	;LSR A
	;LSR A
	;STA Move.dx.tile
	;TYA
	;CLC
	;ADC Move.dx
	;LSR A
	;LSR A
	;LSR A
	;SEC
	;SBC Move.dx.tile
	;BPL {+}
	;EOR #$FFFF
	;INC A
;{+}	;STA Move.dx.tile
	;BNE {+}
	;LDA Move.x0
	;CLC
	;ADC Move.dx
	;AND #$00FF
	;STA Move.x1
	;CLC
	;BRL {+Done}
;{+}	;
	;# Calculate number of tiles to test in Y
	;LDA Move.y0
	;TAY
	;LSR A
	;LSR A
	;LSR A
	;STA Move.dy.tile
	;TYA
	;CLC
	;ADC Move.height
	;DEC A
	;LSR A
	;LSR A
	;LSR A
	;SEC
	;SBC Move.dy.tile
	;BPL {+}
	;EOR #$FFFF
	;INC A
;{+}	;STA Move.dy.tile
	;BNE {+}
	;LDA Move.x0
	;CLC
	;ADC Move.dx
	;AND #$00FF
	;STA Move.x1
	;CLC
	;BRL {+Done}
;{+}	;
	;LDA Move.dx
	;BMI {+Minus}
	;
	;# Positive =========================
	;LDA Move.x0
	;CLC
	;ADC Move.width
	;LSR A
	;LSR A
	;LSR A
	;AND #$001F
	;STA Move.index
	;LDA Move.y0
	;AND #$00F8
	;ASL A
	;ASL A
	;CLC
	;ADC Move.index
	;ASL A
	;STA Move.index
	;TAX
	;
;{-Column}	;LDY Move.dy.tile
;{-Row}	;TAX
	;LDA level,X
	;AND #$03FF
	;CMP #$0009 // Stone character
	;BEQ {+Hit}
	;TXA
	;CLC
	;ADC #$0040
	;AND #$07FF
	;DEY
	;BPL {-Row}
;{+}	;LDA Move.index
	;TAX
	;INC A
	;INC A
	;AND #$003F
	;STA Move.index
	;TXA
	;AND #$07C0
	;ORA Move.index
	;STA Move.index
	;DEC Move.dx.tile
	;BNE {-Column}
	;
	;LDA Move.x0
	;CLC
	;ADC Move.dx
	;AND #$00FF
	;STA Move.x1
	;CLC
	;BRL {+Done}
	;
;{+Hit}	;TXA
	;ASL A
	;ASL A
	;AND #$00F8
	;SEC
	;SBC Move.width
	;AND #$00FF
	;STA Move.x1
	;SEC
	;BRL {+Done}
	;
	;# Negative ================================
;{+Minus}	;LDA Move.x0
	;LSR A
	;LSR A
	;LSR A
	;DEC A
	;AND #$001F
	;STA Move.index
	;LDA Move.y0
	;AND #$00F8
	;ASL A
	;ASL A
	;CLC
	;ADC Move.index
	;ASL A
	;STA Move.index
	;TAX
	;
;{-Column}	;LDY Move.dy.tile
;{-Row}	;TAX
	;LDA level,X
	;AND #$03FF
	;CMP #$0009 // Stone character
	;BEQ {+Hit}
	;TXA
	;CLC
	;ADC #$0040
	;AND #$07FF
	;DEY
	;BPL {-Row}
;{+}	;LDA Move.index
	;TAX
	;DEC A
	;DEC A
	;AND #$003F
	;STA Move.index
	;TXA
	;AND #$07C0
	;ORA Move.index
	;STA Move.index
	;DEC Move.dx.tile
	;BNE {-Column}
	;
	;LDA Move.x0
	;CLC
	;ADC Move.dx
	;AND #$00FF
	;STA Move.x1
	;CLC
	;BRA {+Done}
	;
;{+Hit}	;TXA
	;ASL A
	;ASL A
	;AND #$00F8
	;CLC
	;ADC #$0008
	;AND #$00FF
	;STA Move.x1
	;SEC
	;
;{+Done}	;PLB
	;PLP
	;RTS

