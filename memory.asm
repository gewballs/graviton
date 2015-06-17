	;# Graviton Memory Map =============================================
	
	;# Dir Address  Name                 Size      Notes
	
	;# WRAM $7E:0000-$7E:2000
	
	;# Direct Page
	
	;#Name $00      scratch_pad          b[0x10]
	;#Name $10      inidisp              b
	;#Name $11      objsel               b
	;#Name $12      oamadd               w
	;#Name $14      bgmode               b
	;#Name $15      mosaic               b
	;#Name $16      bg1sc                b
	;#Name $17      bg2sc                b
	;#Name $18      bg3sc                b
	;#Name $19      bg4sc                b
	;#Name $1A      bg12nba              b
	;#Name $1B      bg34nba              b
	;#Name $1C      bg1hofs              w
	;#Name $1E      bg1vofs              w
	;#Name $20      bg2hofs              w
	;#Name $22      bg2vofs              w
	;#Name $24      bg3hofs              w
	;#Name $26      bg3vofs              w
	;#Name $28      bg4hofs              w
	;#Name $2A      bg4vofs              w
	;#Name $2C      vmainc               b
	;#Name $2D      vmadd                w
	;#Name $2F      m7sel                b
	;#Name $30      m7a                  w
	;#Name $32      m7b                  w
	;#Name $34      m7c                  w
	;#Name $36      m7d                  w
	;#Name $38      m7x                  w
	;#Name $3A      m7y                  w
	;#Name $3C      cgadd                b
	;#Name $3D      w12sel               b
	;#Name $3E      w34sel               b
	;#Name $3F      wobjsel              b
	;#Name $40      wh0                  b
	;#Name $41      wh1                  b
	;#Name $42      wh2                  b
	;#Name $43      wh3                  b
	;#Name $44      wbglog               b
	;#Name $45      wobjlog              b
	;#Name $46      tm                   b
	;#Name $47      ts                   b
	;#Name $48      tmw                  b
	;#Name $49      tsw                  b
	;#Name $4A      cgswsel              b
	;#Name $4B      cgadsub              b
	;#Name $4C      coldata_blue         b
	;#Name $4D      coldata_green        b
	;#Name $4E      coldata_red          b
	;#Name $4F      setini               b
	;#Name $50      ophct                w
	;#Name $52      opvct                w
	;#Name $54      stat77               b
	;#Name $55      stat78               b
	;#Name $56      apuio0               b
	;#Name $57      apuio1               b
	;#Name $58      apuio2               b
	;#Name $59      apuio3               b
	;#Name $5A      wmadd                l
	;#Name $5D      nmitimen             b
	;#Name $5E      wrio                 b
	;#Name $5F      htime                w
	;#Name $61      vtime                w
	;#Name $63      mdmaen               b
	;#Name $64      hdmaen               b
	;#Name $65      memsel               b
	;#Name $66      rdnmi                b
	;#Name $67      timeup               b
	;#Name $68      hvbjoy               b
	;#Name $69      rdio                 b
	;#Name $006A    joy                  w[0x04]
	;#Name $6A      joy1                 w
	;#Name $6C      joy2                 w
	;#Name $6E      joy3                 w
	;#Name $70      joy4                 w
	
	;#Name $0072    joy.last             w[0x04]
	;#Name $72      joy1.last            w
	;#Name $74      joy2.last            w
	;#Name $76      joy3.last            w
	;#Name $78      joy4.last            w
	;#Name $007A    joy.edge             w[0x04]
	;#Name $7A      joy1.edge            w
	;#Name $7C      joy2.edge            w
	;#Name $7E      joy3.edge            w
	;#Name $80      joy4.edge            w
	;#Name $0082    joy.hold             b[0x04]
	;#Name $82      joy1.hold            b
	;#Name $83      joy2.hold            b
	;#Name $84      joy3.hold            b
	;#Name $85      joy4.hold            b
	;#Name $0086    joy.cool             b[0x04]
	;#Name $86      joy1.cool            b
	;#Name $87      joy2.cool            b
	;#Name $88      joy3.cool            b
	;#Name $89      joy4.cool            b
	
	;#Name $8A      Nmi.ready            b
	;#Name $8B      Nmi.count            w
	;#Name $8D      Nmi.HDMA.data        l
	;#Name $90      Nmi.VRAM_DMA.data    l
	;#Name $93      Nmi.VRAM_DMA.data_i  w
	;#Name $95      Nmi.VRAM_Write.table_i w
	
	;#Name $97      irq_program          l
	
	;#Name $9A      Main.count           w
	;#Name $9C      Main.program         w
	;#Name $9E      Sub.program          w
	
	;#Name $A0      oam_i                w
	;#Name $A2      oam2_byte_i          b
	;#Name $A3      oam2_bit_i           b
	
	;#Name $A6      Rng.number           w
	;#Name $A8      pause                b
	
	
	;# Scratch Pad
	
	;#Name $00      Multiply_16.m1       w
	;#Name $02      Multiply_16.m2       w
	;#Name $04      Multiply_16.p        w
	
	;#Name $00      Divide_16.n          w
	;#Name $02      Divide_16.d          w
	;#Name $04      Divide_16.q          w
	;#Name $08      Divide_16.r          w
	
	;#Name $00      Draw_Sprite.data_i   l
	;#Name $02      Draw_Sprite.data_bank b
	;#Name $03      Draw_Sprite.obj_count b
	;#Name $04      Draw_Sprite.x        b
	;#Name $05      Draw_Sprite.y        b
	;#Name $06      Draw_Sprite.char_i   w
	;#Name $08      Draw_Sprite.obj_p_override b

	;#Name $0A      AnimateSprite.base   w
	;#Name $0C      AnimateSprite.script w
	;#Name $0E      AnimateSprite.timer  w



	;#Name $00      Grounded.x
	;#Name $02      Grounded.y
	;#Name $04      Grounded.width
	;#Name $06      Grounded.height
	;#Name $08      Grounded.dx
	;#Name $0A      Grounded.row

	;#Name $00      Move.x0
	;#Name $02      Move.y0
	;#Name $04      Move.x1
	;#Name $06      Move.y1
	;#Name $08      Move.width
	;#Name $0A      Move.height
	;#Name $0C      Move.dx
	;#Name $0E      Move.dy
	;#Name $0C      Move.xChar
	;#Name $0E      Move.yChar




	;# Graphic Buffer ==================================================

	;#Name $0100    oam                  b[0x0200]
	;#Name $0100    oam.x                b
	;#Name $0101    oam.y                b
	;#Name $0102    oam.c                b
	;#Name $0103    oam.p                b
	;#Name $0300    oam2                 b[0x20]
	
	;#Name $0320    cgram                b[0x0200]
	
	;#Name $0520    Nmi.VRAM_Write.tablei b[0xE0]
	;#Name $0520    Nmi.VRAM_Write.addr  w
	;#Name $0522    Nmi.VRAM_Write.data  w

	;# Player Structure ================================================
	;#Name $0600    vrtan.state

	;#Name $0602    vrtan.x0
	;#Name $0606    vrtan.y0
	
	;#Name $0604    vrtan.x1
	;#Name $0608    vrtan.y1

	;#Name $060A    vrtan.vx
	;#Name $060C    vrtan.vy

	;#Name $060E    vrtan.left
	;#Name $0610    vrtan.flip
	
	;#Name $0612    vrtan.ghost
	;#Name $0614    vrtan.jump
	;#Name $0618    vrtan.hit.x
	;#Name $061A    vrtan.hit.y
	;#Name $061C    vrtan.hit.width
	;#Name $061E    vrtan.hit.height

	;#Name $0620    vrtan.body.script
	;#Name $0622    vrtan.body.frame
	;#Name $0624    vrtan.body.timer
	
	;#Name $0626    vrtan.legs.script
	;#Name $0628    vrtan.legs.frame
	;#Name $062A    vrtan.legs.timer

	;# Environment =====================================================
	;#Name $0700  gravity

	;# WRAM $7E:2000-$7E:FFFF
	;#Name $2000  level // w[0x0400]
	
	
	;# WRAM $7F:0000-$7F:FFFF
	
	;# VRAM
	;#Name $0000  vram.bg1.name
	;#Name $0400  vram.bg2.name
	;#Name $1000  vram.bg.char
	;#Name $6000  vram.obj.char
	
	
	;# ROM =============================================================
	
	;#Code w RESET_Vector
	;#Code w NMI_Vector
	;#Code w IRQ_Vector
	;#Code l Reset
	;#Code w Reset.Registers
	;#Code w Reset.VRAM
	;#Code w Reset.OAM
	;#Code w Reset.CGRAM
	;#Code w Reset.APU
	
	;#Code l Nmi.Wait
	;#Code l Nmi
	;#Code w Nmi.Registers
	;#Code w Nmi.HDMA
	;#Code w Nmi.VRAM_DMA
	;#Code w Nmi.VRAM_Write
	
	;#Code l Irq
	
	;#Code l Main
	;#Data w Main.programs
	;#Code w Engine.Initiate
	;#Code w Engine.Fadein
	;#Code w Engine.Run
	;#Code w Test_Joy
	;#Code w Pause






	;#Code w DrawSea
	;#Code w DrawVrtan 
	;#Code w AnimateSprite

	
	
	;#Code w Vrtan
	;#Code w Vrtan.Player
	;#Code w Vrtan.Idle
	;#Code w Vrtan.Walk
	;#Code w Vrtan.Jump
	;#Code w Vrtan.Fall
	;#Code w Vrtan.Punch
	;#Code w Vrtan.JumpPunch
	;#Code w Vrtan.FallPunch
	;#Code w Vrtan.Uppercut
	;#Code w Vrtan.Crush
	;#Code w Vrtan.JumpSpike
	;#Code w Vrtan.FallSpike
	;#Code w Vrtan.Respawn

	;#Code w Grounded






	;#Code l Immediate_DMA
	
	;#Code l Ready_Oam
	;#Code l Hide_Unused_Oam
	;#Code l Draw_Sprite
	
	;#Code l Multiply_16
	;#Code l Divide
	;#Code l Rng
	;#Data l sinusoid




	;# Backgrounds
	;#Data l bg.char
	;#Data l palette
	;#Data l level.name
	;#Data l sea.name
	;#Data l vrtan.char

	;# Sprite Scripts
	;#Data w vrtan.body.debug.r.script
	;#Data w vrtan.legs.debug.r.script
	
	;#Data w vrtan.body.idle.r.script
	;#Data w vrtan.body.idle.l.script
	;#Data w vrtan.body.walk.l.script
	;#Data w vrtan.body.walk.r.script
	;#Data w vrtan.body.jump.r.script
	;#Data w vrtan.body.punch.r.script
	;#Data w vrtan.body.uppercut.r.script

	;#Data w vrtan.legs.idle.r.script
	;#Data w vrtan.legs.idle.l.script
	;#Data w vrtan.legs.walk.r.script
	;#Data w vrtan.legs.walk.l.script
	;#Data w vrtan.legs.jump.r.script
	;#Data w vrtan.legs.punch.r.script


	;# Body Sprite
	;#Data w vrtan.body.idle.r.0
	;#Data w vrtan.body.idle.l.0
	;#Data w vrtan.body.idle.r.1
	;#Data w vrtan.body.idle.l.1
	;#Data w vrtan.body.idle.r.2
	;#Data w vrtan.body.idle.l.2
	
	;#Data w vrtan.body.walk.r.0
	;#Data w vrtan.body.walk.l.0
	;#Data w vrtan.body.walk.r.1
	;#Data w vrtan.body.walk.l.1
	;#Data w vrtan.body.walk.r.2
	;#Data w vrtan.body.walk.l.2

	;#Data w vrtan.body.jump.r.0
	
	;#Data w vrtan.body.punch.r.0
	;#Data w vrtan.body.punch.r.1
	
	;#Data w vrtan.body.uppercut.r.0
	;#Data w vrtan.body.uppercut.r.1
	;#Data w vrtan.body.uppercut.r.2

	;# Legs Sprite
	;#Data w vrtan.legs.idle.r.0
	
	;#Data w vrtan.legs.walk.r.0
	;#Data w vrtan.legs.walk.r.1
	;#Data w vrtan.legs.walk.r.2
	;#Data w vrtan.legs.walk.r.3
	;#Data w vrtan.legs.walk.r.4
	;#Data w vrtan.legs.walk.r.5

	;#Data w vrtan.legs.jump.r.0






	;#Data l rom_header
	;#Data l vector_table
	
