            ;# Graviton Memory Map =============================================
            
            ;# Dir Address  Name                 Size      Notes
            
            ;# WRAM $7E:0000-$7E:2000
            
            ;# Direct Page
            
            ;#Name $00      scratch_pad          b[0x10]
            ;#Name $20      inidisp              b
            ;#Name $21      objsel               b
            ;#Name $22      oamadd               w
            ;#Name $24      bgmode               b
            ;#Name $25      mosaic               b
            ;#Name $26      bg1sc                b
            ;#Name $27      bg2sc                b
            ;#Name $28      bg3sc                b
            ;#Name $29      bg4sc                b
            ;#Name $2A      bg12nba              b
            ;#Name $2B      bg34nba              b
            ;#Name $2C      bg1hofs              w
            ;#Name $2E      bg1vofs              w
            ;#Name $30      bg2hofs              w
            ;#Name $32      bg2vofs              w
            ;#Name $34      bg3hofs              w
            ;#Name $36      bg3vofs              w
            ;#Name $38      bg4hofs              w
            ;#Name $3A      bg4vofs              w
            ;#Name $3C      vmainc               b
            ;#Name $3D      vmadd                w
            ;#Name $3F      m7sel                b
            ;#Name $40      m7a                  w
            ;#Name $42      m7b                  w
            ;#Name $44      m7c                  w
            ;#Name $46      m7d                  w
            ;#Name $48      m7x                  w
            ;#Name $4A      m7y                  w
            ;#Name $4C      cgadd                b
            ;#Name $4D      w12sel               b
            ;#Name $4E      w34sel               b
            ;#Name $4F      wobjsel              b
            ;#Name $50      wh0                  b
            ;#Name $51      wh1                  b
            ;#Name $52      wh2                  b
            ;#Name $53      wh3                  b
            ;#Name $54      wbglog               b
            ;#Name $55      wobjlog              b
            ;#Name $56      tm                   b
            ;#Name $57      ts                   b
            ;#Name $58      tmw                  b
            ;#Name $59      tsw                  b
            ;#Name $5A      cgswsel              b
            ;#Name $5B      cgadsub              b
            ;#Name $5C      coldata_blue         b
            ;#Name $5D      coldata_green        b
            ;#Name $5E      coldata_red          b
            ;#Name $5F      setini               b
            ;#Name $60      ophct                w
            ;#Name $62      opvct                w
            ;#Name $64      stat77               b
            ;#Name $65      stat78               b
            ;#Name $66      apuio0               b
            ;#Name $67      apuio1               b
            ;#Name $68      apuio2               b
            ;#Name $69      apuio3               b
            ;#Name $6A      wmadd                l
            ;#Name $6D      nmitimen             b
            ;#Name $6E      wrio                 b
            ;#Name $6F      htime                w
            ;#Name $71      vtime                w
            ;#Name $73      mdmaen               b
            ;#Name $74      hdmaen               b
            ;#Name $75      memsel               b
            ;#Name $76      rdnmi                b
            ;#Name $77      timeup               b
            ;#Name $78      hvbjoy               b
            ;#Name $79      rdio                 b
            ;#Name $007A    joy                  w[0x04]
            ;#Name $7A      joy1                 w
            ;#Name $7C      joy2                 w
            ;#Name $7E      joy3                 w
            ;#Name $80      joy4                 w
            
            ;#Name $0082    joy.last             w[0x04]
            ;#Name $82      joy1.last            w
            ;#Name $84      joy2.last            w
            ;#Name $86      joy3.last            w
            ;#Name $88      joy4.last            w
            ;#Name $008A    joy.edge             w[0x04]
            ;#Name $8A      joy1.edge            w
            ;#Name $8C      joy2.edge            w
            ;#Name $8E      joy3.edge            w
            ;#Name $90      joy4.edge            w
            ;#Name $0092    joy.hold             b[0x04]
            ;#Name $92      joy1.hold            b
            ;#Name $93      joy2.hold            b
            ;#Name $94      joy3.hold            b
            ;#Name $95      joy4.hold            b
            ;#Name $0096    joy.cool             b[0x04]
            ;#Name $96      joy1.cool            b
            ;#Name $97      joy2.cool            b
            ;#Name $98      joy3.cool            b
            ;#Name $99      joy4.cool            b
            
            ;#Name $9A      Nmi.ready            b
            ;#Name $9B      Nmi.count            w
            ;#Name $9D      Nmi.Hdma.data        l
            ;#Name $A0      Nmi.Dma.data         l
            ;#Name $A3      Nmi.Dma.i            w
            ;#Name $A5      Nmi.Write.i          w
            
            ;#Name $A7      irq_program          l
            
            ;#Name $AA      Main.count           w
            ;#Name $AC      Main.program         w
            ;#Name $AE      Sub.program          w
            
            ;#Name $B0      oam_i                w
            ;#Name $B2      oam2_byte_i          b
            ;#Name $B3      oam2_bit_i           b
            
            ;#Name $B6      Rng.number           w
            ;#Name $B8      pause                b
            
            ;#Name $B9      usage                b
            
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
            ;#Name $04      Move.dx
            ;#Name $06      Move.dy
            ;#Name $08      Move.width
            ;#Name $0A      Move.height
            ;#Name $0C      Move.x1
            ;#Name $0E      Move.y1
            ;#Name $10      Move.dx.tile
            ;#Name $12      Move.dy.tile
            ;#Name $14      Move.index
            ;#Name $16      Move.temp
            ;#Name $18      Move.iteration
            ;#Name $1A      Move.stop
            ;#Name $1C      Move.hazard
            ;#Name $1E      Move.copy

            ;# Graphic Buffer ==================================================

            ;#Name $0100    oam                  b[0x0200]
            ;#Name $0100    oam.x                b
            ;#Name $0101    oam.y                b
            ;#Name $0102    oam.c                b
            ;#Name $0103    oam.p                b
            ;#Name $0300    oam2                 b[0x20]
            
            ;#Name $0320    cgram                b[0x0200]
            
            ;#Name $0520    Nmi.Write.table b[0xE0]
            ;#Name $0520    Nmi.Write.base  w
            ;#Name $0522    Nmi.Write.data  w

            ;# Player Structure ================================================
            ;#Name $0600    vrtan.state0
            ;#Name $0602    vrtan.state1

            ;#Name $0604    vrtan.x0
            ;#Name $0606    vrtan.y0
            
            ;#Name $0608    vrtan.x1
            ;#Name $060A    vrtan.y1

            ;#Name $060C    vrtan.vx
            ;#Name $060E    vrtan.vy

            ;#Name $0610    vrtan.left0
            ;#Name $0612    vrtan.left1
            ;#Name $0614    vrtan.flip
            
            ;#Name $0616    vrtan.ghost
            ;#Name $0618    vrtan.jump
            ;#Name $061A    vrtan.hit.x
            ;#Name $061C    vrtan.hit.y
            ;#Name $061E    vrtan.hit.width
            ;#Name $0620    vrtan.hit.height

            ;#Name $0622    vrtan.body.script
            ;#Name $0624    vrtan.body.frame
            ;#Name $0626    vrtan.body.timer
            
            ;#Name $0628    vrtan.legs.script
            ;#Name $062A    vrtan.legs.frame
            ;#Name $062C    vrtan.legs.timer

            ;#Name $062E    vrtan.stop
            ;#Name $0630    vrtan.hazard
            ;#Name $0632    vrtan.hit.show
            
            ;#Name $0650    player0.score
            ;#Name $0651    player1.score
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
            
            ;#Code w Vector.Reset
            ;#Code w Vector.Nmi
            ;#Code w Vector.Trap
            
            ;#Code l Reset
            ;#Code w Reset.Registers
            ;#Code w Reset.Vram
            ;#Code w Reset.Oam
            ;#Code w Reset.Cgram
            ;#Code w Reset.Apu
            
            ;#Code l Nmi.Wait
            ;#Code l Nmi
            ;#Code w Nmi.Registers
            ;#Code w Nmi.Hdma
            ;#Code w Nmi.Dma
            ;#Code w Nmi.Write
            
            ;#Code l Main
            ;#Data w Main.programs
            ;#Code w Engine.Initiate
            ;#Code w Engine.Fadein
            ;#Code w Engine.Run
            ;#Code w Joy
            ;#Code w Pause

            ;#Code w Debug
            
            ;#Code w Vrtan
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

            ;#Code w Vrtan.Sprite
            ;#Code w Vrtan.Move

            ;#Code w Move
            ;#Code w Move.X
            ;#Code w Move.Y

            ;#Code w Draw
            ;#Code w Draw.Debug
            ;#Code w Draw.Palette
            ;#Code w Draw.Character
            ;#Code w Draw.Hud
            ;#Code w Draw.Level
            ;#Code w Draw.Players
            ;#Code w Draw.Entity
            

            ;#Code l Dma.Immediate
            
            ;#Code l Ready_Oam
            ;#Code l Hide_Unused_Oam
            ;#Code l Draw_Sprite
            ;#Code w AnimateSprite
            
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

            ;# Sprite Scripts ========================
            ;#Data w vrtan.body.idle.r.script
            ;#Data w vrtan.body.idle.l.script
            ;#Data w vrtan.body.walk.r.script
            ;#Data w vrtan.body.walk.l.script
            ;#Data w vrtan.body.jump.r.script
            ;#Data w vrtan.body.jump.l.script
            ;#Data w vrtan.body.punch.r.script
            ;#Data w vrtan.body.punch.l.script
            ;#Data w vrtan.body.uppercut.r.script
            ;#Data w vrtan.body.uppercut.l.script

            ;#Data w vrtan.legs.idle.r.script
            ;#Data w vrtan.legs.idle.l.script
            ;#Data w vrtan.legs.walk.r.script
            ;#Data w vrtan.legs.walk.l.script
            ;#Data w vrtan.legs.jump.r.script
            ;#Data w vrtan.legs.jump.l.script
            ;#Data w vrtan.legs.punch.r.script
            ;#Data w vrtan.legs.punch.l.script

            ;# Sprite ================================
            ;# Hitbox
            ;#Data w hit.tl.sprite
            ;#Data w hit.bl.sprite
            ;#Data w hit.br.sprite
            ;#Data w hit.tr.sprite

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
            ;#Data w vrtan.body.jump.l.0
            
            ;#Data w vrtan.body.punch.r.0
            ;#Data w vrtan.body.punch.l.0
            ;#Data w vrtan.body.punch.r.1
            ;#Data w vrtan.body.punch.l.1
            
            ;#Data w vrtan.body.uppercut.r.0
            ;#Data w vrtan.body.uppercut.l.0
            ;#Data w vrtan.body.uppercut.r.1
            ;#Data w vrtan.body.uppercut.l.1
            ;#Data w vrtan.body.uppercut.r.2
            ;#Data w vrtan.body.uppercut.l.2

            ;# Legs Sprite
            ;#Data w vrtan.legs.idle.r.0
            ;#Data w vrtan.legs.idle.l.0
            
            ;#Data w vrtan.legs.walk.r.0
            ;#Data w vrtan.legs.walk.l.0
            ;#Data w vrtan.legs.walk.r.1
            ;#Data w vrtan.legs.walk.l.1
            ;#Data w vrtan.legs.walk.r.2
            ;#Data w vrtan.legs.walk.l.2
            ;#Data w vrtan.legs.walk.r.3
            ;#Data w vrtan.legs.walk.l.3
            ;#Data w vrtan.legs.walk.r.4
            ;#Data w vrtan.legs.walk.l.4
            ;#Data w vrtan.legs.walk.r.5
            ;#Data w vrtan.legs.walk.l.5

            ;#Data w vrtan.legs.jump.r.0
            ;#Data w vrtan.legs.jump.l.0

            ;# Technical ============================
            ;#Data l header
            ;#Data l vector
            
