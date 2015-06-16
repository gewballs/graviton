

	;#Code w {Vrtan}
	;PHP
	;REP #$30
	;
	;LDX #$0000
	;JSR (vrtan.state,X)
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
	;INC A
	;AND #$00FF
	;STA vrtan.x0
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
;{+}	;BIT #$0400 // Down
	;BEQ {+}
	;LDA vrtan.y0
	;INC A
	;AND #$00FF
	;STA vrtan.y0
	;
	;TXA
;{+}	;BIT #$0800 // Up
	;BEQ {+}
	;LDA vrtan.y0
	;DEC A
	;AND #$00FF
	;STA vrtan.y0
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
	;STA Grounded.x
	;LDA vrtan.y0
	;STA Grounded.y
	;LDA vrtan.width
	;STA Grounded.width
	LDA vrtan.height
	STA Grounded.height
	;JSR Grounded
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



	;#Code w {Grounded}
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
	;STA Grounded.dx
	;LDA Grounded.y
	;CLC
;ADC #$0020
	ADC Grounded.height
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
;ADC #$000E
	ADC Grounded.width
	;LSR A
	;LSR A
	;LSR A
	;SEC
	;SBC Grounded.dx
	;INC A
	;TAY
;{-}	;
	;LDA level,X
	;AND #$01FF
	;CMP #$0009 // Block
	;BNE {+Air}
;# !!!DEBUG!!!
;TXA
;PHX
;LDX Nmi.VRAM_Write.table_i
;LSR A
;STA Nmi.VRAM_Write.addr,X
;LDA #$0411
;STA Nmi.VRAM_Write.data,X
;INX
;INX
;INX
;INX
;STX Nmi.VRAM_Write.table_i
;PLX
	;LDA #$FFFF // Hit
;BRA {+}
	BRA {+Done}
;{+Air}
;# !!!DEBUG!!!
;TXA
;PHX
;LDX Nmi.VRAM_Write.table_i
;LSR A
;STA Nmi.VRAM_Write.addr,X
;LDA #$0410
;STA Nmi.VRAM_Write.data,X
;INX
;INX
;INX
;INX
;STX Nmi.VRAM_Write.table_i
;PLX
;{+}
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
	;LDA #$0000 // Miss
	;
;{+Done}	;PLB
	;PLP
	;RTS

	;#Code w {Move}

	;RTS





