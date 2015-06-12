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
	;#Data {$01 $18 level $0800} // Level name table
	;LDA #$0400
	;STA VMADD
	;JSL Immediate_DMA
	;#Data {$01 $18 sea $0800} // Background name table
	;LDA #$1000
	;STA VMADD
	;JSL Immediate_DMA
	;#Data {$01 $18 character $0800} // Bg character set
	;LDA #$6000
	;STA VMADD
	;JSL Immediate_DMA
	;#Data {$01 $18 vrtan $0A00} // Vrtan character set
	;LDA #$7E03
	;STA WMADD.h
	;LDA #$0320
	;STA WMADD.l
	;JSL Immediate_DMA
	;#Data {$00 $80 palette $0200} // Palette
	;
	;LDA #$000D// Seed RNG
	;STA Rng.number
	;
	;SEP #$20 // Initiate registers
	;LDA #03  // OBJ=8x8,NameSelect=+0x2000,Base=0xC000
	;STA objsel
	;LDA #$01 // BG4=8x8,BG3=8x8,BG2=8x8,BG1=8x8,BG3Priority-0,Mode 1
	;STA bgmode
	;LDA #$00 // VRAM Base=0x0000,SC=1x1
	;STA bg1sc
	;LDA #$04 // VRAM Base=0x0800,SC=1x1
	;STA bg2sc
	;LDA #$08 // VRAM Base=0x1000,SC=1x1
	;STA bg3sc
	;LDA #$11 // BG2 VRAM Base=0x2000, BG1 VRAM Base=0x2000
	;STA bg12nba
	;LDA #$02 // BG4 VRAM Base=0x0000, BG3 VRAM Base=0x2000
	;STA bg34nba
	;LDA #$17 // OBJ=On, BG4=Off, BG3=On, BG2=On, BG1=On
	;STA tm
	;LDA #$04 // Overscan=On
	;STA setini
	;LDA #$81 // NMI=On, Read Joy=On
	;STA nmitimen
	;STA NMITIMEN
	;LDA #$00 // Display=On, Brightness=0
	;STA inidisp
	;STA INIDISP
	;CLI
	;
	;# Initiate Engine
	;REP #$30
	;LDA #vrtan.body.debug.r.script
	;STA vrtan.body.script
	;STZ vrtan.body.frame
	;STZ vrtan.body.timer
	;
	;LDA #vrtan.legs.debug.r.script
	;STA vrtan.legs.script
	;STZ vrtan.legs.frame
	;STZ vrtan.legs.timer
	;
	;INC Main.program // Engine Fade In
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
	;
	;JSR DrawSea
	;JSR DrawVrtan
	;
	;REP #$30 // !!! DEBUG FRAME !!!
	;LDX Nmi.VRAM_Write.table_i
	;LDA #$026F
	;STA Nmi.VRAM_Write.addr,X
	;LDA vrtan.legs.frame
	;LSR A
	;LSR A
	;LSR A
	;LSR A
	;AND #$000F
	;CLC
	;ADC #$2410
	;STA Nmi.VRAM_Write.data,X
	;INX
	;INX
	;INX
	;INX
	;LDA #$0270
	;STA Nmi.VRAM_Write.addr,X
	;LDA vrtan.legs.frame
	;AND #$000F
	;CLC
	;ADC #$2410
	;STA Nmi.VRAM_Write.data,X
	;INX
	;INX
	;INX
	;INX
	;STX Nmi.VRAM_Write.table_i
	;SEP #$20 // !!! END DEBUG !!!
	;
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
	

	;#Code w {DrawSea}
	;PHP
	;REP #$20 // Animate Sea
	;LDA #$0001
	;CLC
	;ADC bg2hofs
	;STA bg2hofs
	;SEP #$20
	;PLP
	;RTS


	;#Code w {DrawVrtan}
	;PHP
	;
	;SEP #$20
	;STZ Draw_Sprite.data_bank
	;STZ Draw_Sprite.obj_p_override
	;LDA #$78
	;STA Draw_Sprite.x
	;LDA #$A8
	;STA Draw_Sprite.y
	;REP #$30
	;LDA #vrtan.body.script
	;STA AnimateSprite.base
	;JSR AnimateSprite
	;
	;LDA #vrtan.legs.script
	;STA AnimateSprite.base
	;JSR AnimateSprite
	;
	;PLP
	;RTS

	
	;#File vrtan.spr

	;#Data l character  {#graviton.chr}
	;#Data l vrtan      {#vrtan.chr}
	;#Data l palette    {#graviton.pal}
	;#Data l level      {#level.nmt}
	;#Data l sea        {#sea.nmt}


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

