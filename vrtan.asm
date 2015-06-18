
;# !!!DEBUG!!!
;#Data w hit.tl.sprite{
    $00
    $00 $00 $3C7F $00
}
;#Data w hit.bl.sprite{
    $00
    $00 $F9 $BC7F $00
}
;#Data w hit.br.sprite{
    $00
    $F9 $F9 $FC7F $01
}
;#Data w hit.tr.sprite{
    $00
    $F9 $00 $7C7F $01
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
	;TAX
	;BIT #$0100 // Right
	;BEQ {+}
	;LDA vrtan.x0
	;STA Move.x0
	;LDA vrtan.y0
	;STA Move.y0
	;LDA #$0001
	;STA Move.dx
	;LDA #$0000
	;STA Move.dy
	;LDA vrtan.hit.width
	;STA Move.width
	;LDA vrtan.hit.height
	;STA Move.height
	;JSR Move.X
	;LDA Move.x1
	;STA vrtan.x0
	;LDA Move.x1
	;STA vrtan.y0
	;LDX joy1
	;
	;TXA
;{+}	;BIT #$0200 // Left
	;BEQ {+}
	;LDA vrtan.x0
	;DEC A
	;AND #$00FF
	;STA vrtan.x0
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
	;BCS {+}
	;LDA vrtan.y0
	;INC A
	;AND #$00FF
	;STA vrtan.y0
;{+}	;
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
	;INC A
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
	;# Calculate number of tiles to test in X
	;LDA Move.x0
	;TAY
	;LSR A
	;LSR A
	;LSR A
	;STA Move.x0.tile
	;TYA
	;CLC
	;ADC Move.dx
	;AND #$00FF
	;STA Move.x1
	;LSR A
	;LSR A
	;LSR A
	;SEC
	;SBC Move.x1.tile
	;BPL {+}
	;EOR #$FFFF
	;INC A
;{+}	;STA Move.dx.tile
	;BNE {+}
	;BRA {+Done}
;{+}	;
	;# Calculate number of tiles to test in Y
	;LDA Move.y0
	;TAY
	;LSR A
	;LSR A
	;LSR A
	;STA Move.y0.tile
	;TYA
	;CLC
	;ADC Move.height
	;LSR A
	;LSR A
	;LSR A
	;SEC
	;SBC Move.y1.tile
	;BPL {+}
	;EOR #$FFFF
	;INC A
;{+}	;STA Move.dy.tile
	;BNE {+}
	;BRA {+Done}
;{+}	;
	;LDA Move.dx
	;BPL {+Minus}
	;
	;# Positive
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
	;
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
	;BNE {-Row}
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
	;DEY Move.dx.tile
	;BNE {-Column}
	;
	;CLC
	;BRA {+Done}
	;
;{+Hit}	;TXA
	;ASL A
	;ASL A
	;AND #$00F8
	;SEC
	;SBC Move.width
	;STA Move.x1
	;SEC
	;
	;BRA {+Done}
	;# Negative
;{+Minus}	;
	;
	;
	;
	;
	;
;{+Done}	;PLB
	;PLP
	;RTS

