	+------------+
	| R:Graviton |
	| June 2015  |
	+------------+
	
	;#LoROM
	
	;# Memory Map ======================================================
	;#File register.asm
	;#File memory.asm
	
	
	;# Vectors =========================================================
	;#Code w {RESET_Vector}
	;SEI
	;CLC
	;XCE
	;JML Reset
	
	;#Code w {NMI_Vector}
	;JML Nmi
	
	;#Code w {IRQ_Vector}
	;JML Reset
	
	;#File vector.asm
	
	
	;# Libraries =======================================================
	;#File dma.asm
	;#File math.asm
	;#File oam.asm
	;#File joy.asm
	
	
	;# Main Program ====================================================
	;#Code l {Main}
	;REP #$30
;{Loop}	;LDA Main.program
	;ASL A
	;TAX
	;JSR (Main.programs,X)
	;INC Main.count
	;BRA {Loop}
	;#Data w Main.programs{
	    Engine.Initiate
	    Engine.Fadein
	    Engine.Run
	}
	
	;#Code w {Engine.Initiate}
	;PHP
	;PHB
	;
	;PHK // Load Graphics
	;PLB
	;SEP #$20
	;LDA #$80
	;STA VMAINC
	;REP #$30
	;LDA #$0000
	;STA VMADD
	;JSL Immediate_DMA
	;#Data {$01 $18 Reset $0800} // Dummy Background
	;LDA #$1000
	;STA VMADD
	;JSL Immediate_DMA
	;#Data {$01 $18 Reset $1000} // Dummy Character
	;LDA #$7E03
	;STA WMADD.h
	;LDA #$0320
	;STA WMADD.l
	;JSL Immediate_DMA
	;#Data {$00 $80 Reset $0200} // Dummy Palette
	;
	;LDA #$000D// Seed RNG
	;STA Rng.number
	;
	;SEP #$20// Initiate registers
	;LDA #$09
	;STA bgmode
	;LDA #$00
	;STA bg1sc
	;LDA #$04
	;STA bg2sc
	;LDA #$08
	;STA bg3sc
	;LDA #$11
	;STA bg12nba
	;LDA #$02
	;STA bg34nba
	;LDA #$17
	;STA tm
	;LDA #$81
	;STA nmitimen
	;STA NMITIMEN
	;LDA #$00
	;STA inidisp
	;STA INIDISP
	;CLI
	;
	;REP #$20 // Engine.Fadein
	;INC Main.program
	;
	;PLB
	;PLP
	;RTS
	
	;#Code w {Engine.Fadein}
	;PHP
	;SEP #$20
	;LDA inidisp
	;INC A
	;AND #$0F
	;STA inidisp
	;CMP #$0F
	;BNE {+}
	;INC Main.program// Engine.Run
;{+}	;JSR Test_Joy
	;LDA #$FF
	;STA Nmi.ready
	;JSL Nmi.Wait
	;REP #$20
	;STZ pause
	;PLP
	;RTS
	
	;#Code w {Engine.Run}
	;PHP
	;SEP #$20
	;
	;JSR Test_Joy
	;LDA pause
	;BEQ {+Go}
	;
	;LDA #$09
	;STA inidisp
	;JSR Pause
	;BRA {Done}
	;
;{+Go}	;LDA #$0F
	;STA inidisp
	;JSL Ready_Oam
	;JSL Rng
	;# GAME LOGIC GOES HERE ~~~(|=======8
	;JSL Hide_Unused_Oam
	;
	;LDA #$FF
	;STA Nmi.ready
;{Done}	;JSL Nmi.Wait
	;
	;PLP
	;RTS
	
	;#Code w {Pause}
	;RTS
	
	
	# ROM Registration =================================================
	;#Data $00:FFB0 rom_header {
	    $52 $3A $47 $52 $41 $56 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00
	    $52 $3A $47 $72 $61 $76 $69 $74 $6F $6E $20 $20 $20 $20 $20 $20
	    $20 $20 $20 $20 $20 $20 $02 $09 $01 $01 $33 $00 $00 $00 $00 $00
	}
	
	
	# Vector Table =====================================================
	;#Data $00:FFE0 vector_table {
	    $0000 $0000 $8000 $8000 $8000 $8007 $0000 $8000
	    $0000 $0000 $8000 $0000 $8000 $8000 $8000 $8000
	}

