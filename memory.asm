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

            ;#Name $00      Move.x0
            ;#Name $02      Move.y0
            ;#Name $04      Move.dx
            ;#Name $06      Move.dy
            ;#Name $08      Move.xw
            ;#Name $0A      Move.yw
            ;#Name $0C      Move.x1
            ;#Name $0E      Move.y1
            
			;#Name $10      Move.dx.tile
            ;#Name $12      Move.dy.tile
            ;#Name $14      Move.lock
            ;#Name $16      Move.index
            ;#Name $18      Move.temp

            ;#Name $10      Move.abs

			;#Name $10      Move.xa
			;#Name $12      Move.xb
            ;#Name $14      Move.ya
			;#Name $16      Move.yb
			;#Name $18      Move.ba
			;#Name $1A      Move.bb
			;#Name $1C      Move.bw
			;#Name $1E      Move.stop

			;#Name $00      Spawn.type
			;#Name $02      Spawn.x
			;#Name $04      Spawn.y



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
            
            ;#Name $0634    p0.punch.timer

            ;#Name $0636    p0.run.timer
            ;#Name $0638    p0.run.flag
            
			;#Name $063A    p0.timer

            ;#Name $0650    p0.score
            ;#Name $0651    p1.score
            
            ;#Name $0680    Edit.mode
			;#Name $0682    Edit.x
			;#Name $0684    Edit.y
			;#Name $0686    Edit.n
			;#Name $0688    Edit.c
			;#Name $068A    Edit.p
			;#Name $068C    Edit.f
			;#Name $068E    Edit.tile

            ;# Environment ====================================================
            ;#Name $0700  gravity0
            ;#Name $0702  gravity1
            
            ;#Name $0710  grass.timer
            ;#Name $0712  grass.frame
            
            ;#Name $0720  gradient.b0    b INPUT
            ;#Name $0722  gradient.b1    b INPUT
            ;#Name $0724  gradient.db    b
            ;#Name $0726  gradient       b[0x10]
            
            ;#Name $07FE  crate.n
            ;#Name $0800  crate.x        crate_t[0x?]
            ;#Name $0820  crate.y
            ;#Name $0840  crate.wx
            ;#Name $0860  crate.wy
            ;#Name $0880  crate.vx
            ;#Name $08A0  crate.vy
            
			;#Name $08FC  particle.last
			;#Name $08FE  particle.n
            ;#Name $0900  particle.on
            ;#Name $0920  particle.x
            ;#Name $0940  particle.y
            ;#Name $0960  particle.xv
            ;#Name $0980  particle.yv
            ;#Name $09A0  particle.xw
            ;#Name $09C0  particle.yw
			;#Name $09E0  particle.code
			;#Name $0A00  particle.script
			;#Name $0A20  particle.frame
			;#Name $0A40  particle.delay
            ;#Name $0A60  particle.draw
            ;#Name $0A80  particle.timer


            ;# WRAM $7E:2000-$7E:FFFF
            ;#Name $2000  level // w[0x0400]
            
            
            ;# WRAM $7F:0000-$7F:FFFF
            
            ;# VRAM
            ;#Name $0000  vram.bg1.name
            ;#Name $0400  vram.bg2.name
            ;#Name $0800  vram.bg3.name
            ;#Name $2000  vram.obj.char
            ;#Name $3000  vram.bg.char
            
            
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
			;#Code w Edit

            ;#Code w Gravity
            
			;#Code w Particle
			;#Code w Particle.Next
			;#Code w Particle.Dust
			;#Code w Particle.Gibs
			;#Code w Spawn.Gibs

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
            ;#Code w Vrtan.Crushing
            ;#Code w Vrtan.JumpSpike
            ;#Code w Vrtan.FallSpike
            ;#Code w Vrtan.Respawn

            ;#Code w Vrtan.Sprite
            ;#Code w Vrtan.Move

            ;#Code w Crate
            ;#Code w Crate.Move

            ;#Code w Move.Level
            ;#Code w Move.Level.X
            ;#Code w Move.Level.Y
            ;#Code w Move.Mob
			;#Code w Move.Mob.X
			;#Code w Move.Mob.Y
			;#Code w Move.InInterval.X
			;#Code w Move.InInterval.Y
			;#Code w Move.Intersect.X
			;#Code w Move.Intersect.Y

            ;#Code w Draw
            ;#Code w Draw.Debug
            ;#Code w Draw.Edit
            ;#Code w Draw.Palette
            ;#Code w Draw.Character
            ;#Code w Draw.Hud
            ;#Code w Draw.Level
            ;#Code w Draw.Players
            ;#Code w Draw.Crate
            ;#Code w Draw.Particle
            ;#Code w Draw.Gradient
            ;#Code w Draw.Grass
            

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
            ;#Data l obj.char

            ;# Sprite Scripts ========================

            ;#Data w gibs.arm0.r.script
            ;#Data w gibs.arm0.l.script
            ;#Data w gibs.arm1.r.script
            ;#Data w gibs.arm1.l.script
            ;#Data w gibs.foot.r.script
            ;#Data w gibs.foot.l.script
            ;#Data w gibs.head.r.script
            ;#Data w gibs.head.l.script
            ;#Data w gibs.bone.script
            ;#Data w gibs.gore.r.script
            ;#Data w gibs.gore.ri.script
            ;#Data w gibs.gore.l.script
            ;#Data w gibs.gore.li.script

            ;#Data w vrtan.body.idle.r.script
            ;#Data w vrtan.body.idle.ri.script
            ;#Data w vrtan.body.idle.l.script
            ;#Data w vrtan.body.idle.li.script
            ;#Data w vrtan.body.walk.r.script
            ;#Data w vrtan.body.walk.ri.script
            ;#Data w vrtan.body.walk.l.script
            ;#Data w vrtan.body.walk.li.script
            ;#Data w vrtan.body.jump.r.script
            ;#Data w vrtan.body.jump.ri.script
            ;#Data w vrtan.body.jump.l.script
            ;#Data w vrtan.body.jump.li.script
            ;#Data w vrtan.body.punch.r.script
            ;#Data w vrtan.body.punch.ri.script
            ;#Data w vrtan.body.punch.l.script
            ;#Data w vrtan.body.punch.li.script
            ;#Data w vrtan.body.uppercut.r.script
            ;#Data w vrtan.body.uppercut.ri.script
            ;#Data w vrtan.body.uppercut.l.script
            ;#Data w vrtan.body.uppercut.li.script
            ;#Data w vrtan.body.crush.r.script
            ;#Data w vrtan.body.crush.ri.script
            ;#Data w vrtan.body.crush.l.script
            ;#Data w vrtan.body.crush.li.script

            ;#Data w vrtan.legs.idle.r.script
            ;#Data w vrtan.legs.idle.ri.script
            ;#Data w vrtan.legs.idle.l.script
            ;#Data w vrtan.legs.idle.li.script
            ;#Data w vrtan.legs.walk.r.script
            ;#Data w vrtan.legs.walk.ri.script
            ;#Data w vrtan.legs.walk.l.script
            ;#Data w vrtan.legs.walk.li.script
            ;#Data w vrtan.legs.jump.r.script
            ;#Data w vrtan.legs.jump.ri.script
            ;#Data w vrtan.legs.jump.l.script
            ;#Data w vrtan.legs.jump.li.script
            ;#Data w vrtan.legs.punch.r.script
            ;#Data w vrtan.legs.punch.ri.script
            ;#Data w vrtan.legs.punch.l.script
            ;#Data w vrtan.legs.punch.li.script

            ;# Sprite ================================
            ;# Crate
            ;#Data w crate.sprite

            ;# Edit
            ;#Data w edit.reticle.sprite
            ;#Data w edit.info.sprite

            ;# Hitbox
            ;#Data w hit.tl.sprite
            ;#Data w hit.bl.sprite
            ;#Data w hit.br.sprite
            ;#Data w hit.tr.sprite

			;# Gibs
			;#Data w gibs.arm0.r.0
			;#Data w gibs.arm0.r.1
			;#Data w gibs.arm0.r.2
			;#Data w gibs.arm0.r.3
			;#Data w gibs.arm0.l.0
			;#Data w gibs.arm0.l.1
			;#Data w gibs.arm0.l.2
			;#Data w gibs.arm0.l.3
			
			;#Data w gibs.arm1.r.0
			;#Data w gibs.arm1.r.1
			;#Data w gibs.arm1.r.2
			;#Data w gibs.arm1.r.3
			;#Data w gibs.arm1.l.0
			;#Data w gibs.arm1.l.1
			;#Data w gibs.arm1.l.2
			;#Data w gibs.arm1.l.3
			
			;#Data w gibs.foot.r.0
			;#Data w gibs.foot.r.1
			;#Data w gibs.foot.r.2
			;#Data w gibs.foot.r.3
			;#Data w gibs.foot.l.0
			;#Data w gibs.foot.l.1
			;#Data w gibs.foot.l.2
			;#Data w gibs.foot.l.3
			
			;#Data w gibs.head.r.0
			;#Data w gibs.head.r.1
			;#Data w gibs.head.r.2
			;#Data w gibs.head.r.3
			;#Data w gibs.head.l.0
			;#Data w gibs.head.l.1
			;#Data w gibs.head.l.2
			;#Data w gibs.head.l.3

			;#Data w gibs.bone.0
			;#Data w gibs.bone.1

			;#Data w gibs.gore.r.0
			;#Data w gibs.gore.r.1
			;#Data w gibs.gore.ri.0
			;#Data w gibs.gore.ri.1
			;#Data w gibs.gore.l.0
			;#Data w gibs.gore.l.1
			;#Data w gibs.gore.li.0
			;#Data w gibs.gore.li.1

            ;# Body Sprite
            ;#Data w vrtan.body.idle.r.0
            ;#Data w vrtan.body.idle.ri.0
            ;#Data w vrtan.body.idle.l.0
            ;#Data w vrtan.body.idle.li.0
            ;#Data w vrtan.body.idle.r.1
            ;#Data w vrtan.body.idle.ri.1
            ;#Data w vrtan.body.idle.l.1
            ;#Data w vrtan.body.idle.li.1
            ;#Data w vrtan.body.idle.r.2
            ;#Data w vrtan.body.idle.ri.2
            ;#Data w vrtan.body.idle.l.2
            ;#Data w vrtan.body.idle.li.2
            
            ;#Data w vrtan.body.walk.r.0
            ;#Data w vrtan.body.walk.ri.0
            ;#Data w vrtan.body.walk.l.0
            ;#Data w vrtan.body.walk.li.0
            ;#Data w vrtan.body.walk.r.1
            ;#Data w vrtan.body.walk.ri.1
            ;#Data w vrtan.body.walk.l.1
            ;#Data w vrtan.body.walk.li.1
            ;#Data w vrtan.body.walk.r.2
            ;#Data w vrtan.body.walk.ri.2
            ;#Data w vrtan.body.walk.l.2
            ;#Data w vrtan.body.walk.li.2

            ;#Data w vrtan.body.jump.r.0
            ;#Data w vrtan.body.jump.ri.0
            ;#Data w vrtan.body.jump.l.0
            ;#Data w vrtan.body.jump.li.0
            
            ;#Data w vrtan.body.punch.r.0
            ;#Data w vrtan.body.punch.ri.0
            ;#Data w vrtan.body.punch.l.0
            ;#Data w vrtan.body.punch.li.0
            ;#Data w vrtan.body.punch.r.1
            ;#Data w vrtan.body.punch.ri.1
            ;#Data w vrtan.body.punch.l.1
            ;#Data w vrtan.body.punch.li.1
            
            ;#Data w vrtan.body.uppercut.r.0
            ;#Data w vrtan.body.uppercut.ri.0
            ;#Data w vrtan.body.uppercut.l.0
            ;#Data w vrtan.body.uppercut.li.0
            ;#Data w vrtan.body.uppercut.r.1
            ;#Data w vrtan.body.uppercut.ri.1
            ;#Data w vrtan.body.uppercut.l.1
            ;#Data w vrtan.body.uppercut.li.1
            ;#Data w vrtan.body.uppercut.r.2
            ;#Data w vrtan.body.uppercut.ri.2
            ;#Data w vrtan.body.uppercut.l.2
            ;#Data w vrtan.body.uppercut.li.2

            ;#Data w vrtan.body.crush.r.0
            ;#Data w vrtan.body.crush.ri.0
            ;#Data w vrtan.body.crush.l.0
            ;#Data w vrtan.body.crush.li.0
            ;#Data w vrtan.body.crush.r.1
            ;#Data w vrtan.body.crush.ri.1
            ;#Data w vrtan.body.crush.l.1
            ;#Data w vrtan.body.crush.li.1
            ;#Data w vrtan.body.crush.r.2
            ;#Data w vrtan.body.crush.ri.2
            ;#Data w vrtan.body.crush.l.2
            ;#Data w vrtan.body.crush.li.2
            
			;# Legs Sprite
            ;#Data w vrtan.legs.idle.r.0
            ;#Data w vrtan.legs.idle.ri.0
            ;#Data w vrtan.legs.idle.l.0
            ;#Data w vrtan.legs.idle.li.0
            
            ;#Data w vrtan.legs.walk.r.0
            ;#Data w vrtan.legs.walk.ri.0
            ;#Data w vrtan.legs.walk.l.0
            ;#Data w vrtan.legs.walk.li.0
            ;#Data w vrtan.legs.walk.r.1
            ;#Data w vrtan.legs.walk.ri.1
            ;#Data w vrtan.legs.walk.l.1
            ;#Data w vrtan.legs.walk.li.1
            ;#Data w vrtan.legs.walk.r.2
            ;#Data w vrtan.legs.walk.ri.2
            ;#Data w vrtan.legs.walk.l.2
            ;#Data w vrtan.legs.walk.li.2
            ;#Data w vrtan.legs.walk.r.3
            ;#Data w vrtan.legs.walk.ri.3
            ;#Data w vrtan.legs.walk.l.3
            ;#Data w vrtan.legs.walk.li.3
            ;#Data w vrtan.legs.walk.r.4
            ;#Data w vrtan.legs.walk.ri.4
            ;#Data w vrtan.legs.walk.l.4
            ;#Data w vrtan.legs.walk.li.4
            ;#Data w vrtan.legs.walk.r.5
            ;#Data w vrtan.legs.walk.ri.5
            ;#Data w vrtan.legs.walk.l.5
            ;#Data w vrtan.legs.walk.li.5

            ;#Data w vrtan.legs.jump.r.0
            ;#Data w vrtan.legs.jump.ri.0
            ;#Data w vrtan.legs.jump.l.0
            ;#Data w vrtan.legs.jump.li.0

            ;# Hdma
            ;#Data w hdma.sea.set
            ;#Data w hdma.sea

            ;# Technical ============================
            ;#Data l header
            ;#Data l vector
            
