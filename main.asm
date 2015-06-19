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

	;#File vrtan.asm
	
	
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
	;LDA #$7E00
	;STA WMADD.h
	;LDA #level
	;STA WMADD.l
	;JSL Immediate_DMA
	;#Data {$00 $80 level.name $0800} // Level name table
	;LDA #vram.bg1.name
	;STA VMADD
	;JSL Immediate_DMA
	;#Data {$01 $18 level.name $0800} // Level name table
	;LDA #vram.bg2.name
	;STA VMADD
	;JSL Immediate_DMA
	;#Data {$01 $18 sea.name $0800} // Background name table
	;LDA #vram.bg.char
	;STA VMADD
	;JSL Immediate_DMA
	;#Data {$01 $18 bg.char $0800} // Bg character set
	;LDA #vram.obj.char
	;STA VMADD
	;JSL Immediate_DMA
	;#Data {$01 $18 vrtan.char $1000} // Vrtan character set
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
	;# Initiate Registers =========================
	;LDA #$03FF
	;STA bg1vofs
	;STA bg2vofs
	;SEP #$20
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
	;# Initiate Players
	;REP #$30
	;LDA #Vrtan.Idle
	;STA vrtan.state
	;LDA #$0078
	;STA vrtan.x0
	;LDA #$00A8
	;STA vrtan.y0
	;STZ vrtan.vx
	;STZ vrtan.vy
	;STZ vrtan.left // 0=right , 1=left
	;STZ vrtan.flip // 0=normal, 1=flipped
	;LDA #$0003
	;STA vrtan.hit.x
	;LDA #$0006
	;STA vrtan.hit.y
	;LDA #$0008
	;STA vrtan.hit.width
	;LDA #$0018
	;STA vrtan.hit.height
	;LDA #$0040
	;STA vrtan.ghost
	;
	;# Initiate Environment
	;LDA #$0008
	;STA gravity
	;
	;# Next Program
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
	;JSR Vrtan
	;JSR DrawSea
	;JSR DrawVrtan
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
	;LDA vrtan.x0
	;STA Draw_Sprite.x
	;LDA vrtan.y0
	;STA Draw_Sprite.y
	;REP #$30
	;STZ Draw_Sprite.char_i
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

	;#Data l bg.char    {#graviton.chr}
	;#Data l vrtan.char {#vrtan.chr}
	;#Data l palette    {#graviton.pal}
	;#Data l level.name {#level.nmt}
	;#Data l sea.name   {#sea.nmt}


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

