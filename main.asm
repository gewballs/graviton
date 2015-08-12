            
            ;#LoROM
            
            ;# ===============================================================//
            ;# Graviton                                                       //
            ;#                                                                //
            ;# June 2015                                                      //
            ;# ===============================================================//
            
            ;# ===============================================================//
            ;# Memory Map                                                     //
            ;# ===============================================================//
            ;#File register.asm   // SNES hardware memory map
            ;#File memory.asm     // Game memory map
            
            ;# ===============================================================//
            ;#Code w {Vector.Reset}                                           //
            ;# ===============================================================//
            ;JML Reset            // Reset();
            
            ;# ===============================================================//
            ;#Code w {Vector.Nmi}                                             //
            ;# ===============================================================//
            ;JML Nmi              // Nmi();
            
            ;# ===============================================================//
            ;#Code w {Vector.Trap}                                            //
            ;# ===============================================================//
            ;JMP Vector.Reset     // Vector.Reset();
            
            ;# ===============================================================//
            ;# Libraries                                                      //
            ;# ===============================================================//
            ;# System ==============
            ;#File vector.asm     // Vector handler code
            ;#File dma.asm        // Dma (Direct Memory Access) code
            ;#File math.asm       // Math code
            ;#File oam.asm        // Oam (Object Attribute Memory) code
            ;#File joy.asm        // Controller code
			;#File audio.asm      // Audio code
            
            ;# Game ================
            ;#File draw.asm       // Render code
            ;#File move.asm       // Movement code
			;#File edit.asm       // Editor code
            ;#File vrtan.asm      // Player code
            ;#File crate.asm      // Crate code
			;#File particle.asm   // Particle code
            ;#File gravity.asm    // Gravity code
            ;#File debug.asm      // Debug code
            
            ;# ===============================================================//
            ;#Code l {Main}                                                   //
            ;# ===============================================================//
            ;REP #$30             // Rep(P_m|P_x);
;{-Loop}    ;LDA Main.program     // for(::){
            ;ASL A                //   programs[program]();
            ;TAX                  //
            ;JSR (Main.programs,X)//
            ;INC Main.count       //   count++;
            ;BRA {-Loop}          // }
            ;#Data w Main.programs{
                Engine.Initiate
                Engine.Fadein
                Engine.Run
            }
            


            ;#Data w crate.xInitial{
                $E800
                $7000
                $8000
                $2000
                $D000
                $7000
                $8000
            }
            ;#Data w crate.yInitial{
                $5000
                $6800
                $6800
                $9000
                $9000
                $C800
                $C800
			}

            ;# Particle ============
			;LDA #$0020
			;STA particle.n
			;
            ;# Environment =========
            ;LDA #$001F           // gravity0=0x001F;
            ;STA gravity0         //
            ;STA gravity1         //
            ;SEP #$20
			}

            ;# ===============================================================//
            ;#Code w {Engine.Initiate}                                        //
            ;# ===============================================================//
            ;PHP                  // Php();
            ;PHB                  // Phb();
            ;PHK                  // B=K;
            ;PLB                  //
            ;
			;# Processor ===========
            ;CLI                  // Cli();
            ;
			;# Vram ================
            ;SEP #$20             // Sep(P_m);
            ;LDA #$80             // VMAINC=0x80;
            ;STA VMAINC           //
            ;REP #$30             // Rep(P_m|P_x);
            ;LDA #$7E00           // WMADD.b=0x7E;
            ;STA WMADD.h          // 
            ;LDA #level           // WMADD.l=level;
            ;STA WMADD.l          //
            ;JSL Dma.Immediate    // Dma.Immediate(0x00,0x80,level.name,0x0800);
            ;#Data {$00 $80 level.name $0800} // Foreground tilemap (To WRAM)
            ;LDA #vram.bg1.name   // VMADD=vram.bg1.name;
            ;STA VMADD            //
            ;JSL Dma.Immediate    // Dma.Immediate(0x01,0x18,level.name,0x0800);
            ;#Data {$01 $18 level.name $0800} // Foreground tilemap (To VRAM)
            ;LDA #vram.bg2.name   // VMADD=vram.bg2.name;
            ;STA VMADD            //
            ;JSL Dma.Immediate    // Dma.Immediate(0x01,0x18,sea.name,0x0800);
            ;#Data {$01 $18 sea.name $0800} // Background tilemap
            ;LDA #vram.bg.char    // VMADD=vram.bg.char;
            ;STA VMADD            //
            ;JSL Dma.Immediate    // Dma.Immediate(0x01,0x18,bg.char,0x0800);
            ;#Data {$01 $18 bg.char $0800} // Bg character set, 8x8p, 4-bit
            ;LDA #vram.obj.char   // VMADD=vram.obj.char;
            ;STA VMADD            //
            ;JSL Dma.Immediate    // Dma.Immediate(0x01,0x18,obj.char,0x1000);
            ;#Data {$01 $18 obj.char $1000} // Obj characer set, 8x8p, 4-bit
            ;LDA #$7E03           // WMADD=0x7E0320;
            ;STA WMADD.h          //
            ;LDA #$0320           //
            ;STA WMADD.l          //
            ;JSL Dma.Immediate    // Dma.Immediate(0x00,0x80,palette,0x0200);
            ;#Data {$00 $80 palette $0200} // Palette
            ;
            ;# Video Registers =====
            ;LDA #$03FF           // bg1vofs=0x03FF;
            ;STA bg1vofs          //
            ;STA bg2vofs          // bg2vofs=0x03FF;
            ;SEP #$20             // Sep(P_m);
            ;LDA #01              // // OBJ=8x8,NameSelect=+0x1000w,Base=0x2000w
            ;STA objsel           // objsel=0x03;
            ;LDA #$01             // // BG(4,3,2,1)=8x8,BG3Priority=0,Mode 1
            ;STA bgmode           // bgmode=0x01;
            ;LDA #$00             // // BG1 VRAM Base=0x0000w,SC=1x1
            ;STA bg1sc            // bg1sc=0x00;
            ;LDA #$04             // // BG2 VRAM Base=0x0400w,SC=1x1
            ;STA bg2sc            // bg2sc=0x04;
            ;LDA #$08             // // BG3 VRAM Base=0x0800w,SC=1x1
            ;STA bg3sc            // bg3sc=0x08;
            ;LDA #$33             // // BG2 Name=0x3000w,BG1 Name=0x3000w
            ;STA bg12nba          // bg12nba=0x11;
            ;LDA #$03             // // BG4 Name=0x0000w,BG3 Name=0x3000w
            ;STA bg34nba          // bg34nba=0x01;
            ;LDA #$17             // // OBJ=On, BG4=Off, BG3=On, BG2=On, BG1=On
            ;STA tm               // tm=0x17;
            ;LDA #$04             // // Overscan=On;
            ;STA setini           // setini=0x04;
            ;LDA #$81             // // NMI=On, Read Joy=On
            ;STA nmitimen         // nmitimen=0x81;
            ;STA NMITIMEN         // NMITIMEN=0x81;
            ;LDA #$00             // // Display=On, Brightness=0;
            ;STA inidisp          // inidisp=0x00;
            ;STA INIDISP          // INIDISP=0x00;
            ;
            ;# Utility =============
            ;REP #$30             // // Seed rng
            ;LDA #$000D           // Rng.number=0x000D;
            ;STA Rng.number       //
            ;
            ;# Players =============
            ;LDA #Vrtan.Idle      // vrtan.state0=Vrtan.Idle;
            ;STA vrtan.state0     //
            ;LDA #vrtan.body.idle.r.script
            ;STA vrtan.body.script// vrtan.body.script=vrtan.body.idle.r.script;
            ;STZ vrtan.body.frame // vrtan.body.frame=0;
            ;STZ vrtan.body.timer // vrtan.body.timer=0;
            ;LDA #vrtan.legs.idle.r.script
            ;STA vrtan.legs.script// vrtan.legs.script=vrtan.legs.idle.r.script;
            ;STZ vrtan.legs.frame // vrtan.legs.frame=0;
            ;STZ vrtan.legs.timer // vrtan.legs.timer=0;
            ;LDA #$7800           // vrtan.x0=0x7800;
            ;STA vrtan.x0         //
            ;LDA #$A800           // vrtan.y0=0xA800;
            ;STA vrtan.y0         // 
            ;STZ vrtan.vx         // vrtan.vx=0;
            ;STZ vrtan.vy         // vrtan.vy=0;
            ;STZ vrtan.left0      // vrtan.left0=0;
            ;STZ vrtan.flip       // vrtan.flip=0;
            ;LDA #$0300           // vrtan.hit.x=0x0300;
            ;STA vrtan.hit.x      //
            ;LDA #$0600           // vrtan.hit.y=0x0600;
            ;STA vrtan.hit.y      //
            ;LDA #$0800           // vrtan.hit.width=0x0800;
            ;STA vrtan.hit.width  //
            ;LDA #$1900           // vrtan.hit.height=0x1900;
            ;STA vrtan.hit.height //
            ;LDA #$0040           // vrtan.ghost=0x0040;
            ;STA vrtan.ghost      //
            ;
            ;# Crates ==============
            ;LDA #$000E
            ;STA crate.n
            ;LDX #$0000
			;LDY #$1000
;{-Loop}    ;LDA crate.xInitial,X
            ;STA crate.x,X
            ;LDA crate.yInitial,X
            ;STA crate.y,X
			;TYA
			;STA crate.wx,X
			;STA crate.wy,X
            ;INX
            ;INX
			;CPX crate.n
			;BMI {-Loop}
            ;
            ;# Particle ============
			;LDA #$0020
			;STA particle.n
			;
            ;# Environment =========
            ;LDA #$001F           // gravity0=0x001F;
            ;STA gravity0         //
            ;STA gravity1         //
            ;SEP #$20
            ;LDA #$12
            ;STA gradient.b0
            ;LDA #$03
            ;STA gradient.b1
            ;REP #$20
            ;
            ;# Debug ===============
			;LDA #$0020
			;STA Edit.n
			;LDA #$0002
			;STA Edit.c
			;LDA #$0001
			;STA Edit.p
			;STZ Edit.f
			;
            ;# Program =============
            ;INC Main.program     // Main.program++;
            ;
            ;PLB                  // Plb();
            ;PLP                  // Plp();
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Engine.Fadein}                                          //
            ;# ===============================================================//
            ;PHP                  // Php();
            ;SEP #$20             // Sep(P_m);
            ;
            ;# Utility =============
            ;JSR Joy              // Joy();
            ;
            ;# Game ================
            ;LDA inidisp          // inidisp=(inidisp+1)&0x0F;
            ;INC A                //
            ;AND #$0F             //
            ;STA inidisp          //
            ;CMP #$0F             // if(inidisp==0x0F) Main.program++;
            ;BNE {+Fade}          //
            ;INC Main.program     //
;{+Fade}    ;
            ;# Wait ===============
            ;LDA #$FF             // Nmi.ready=0xFF;
            ;STA Nmi.ready        //
            ;JSL Nmi.Wait         // Nmi.Wait();
            ;STZ pause            // pause=0;
            ;
            ;PLP                  // Plp();
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Engine.Run}                                             //
            ;# ===============================================================//
            ;PHP                  // Php();
            ;SEP #$20             // Sep(P_m);
            ;
            ;# Utility =============
            ;JSR Joy              // Joy();
            ;LDA pause            // if(pause){
            ;BEQ {+Run}           //
            ;LDA #$09             //   inidisp=0x09;
            ;STA inidisp          //
            ;JSR Pause            //   Pause();
            ;BRA {+Wait}          // }else{
;{+Run}     ;LDA #$0F             //   inidisp=0x0F;
            ;STA inidisp          //
            ;JSL Ready_Oam        //   Ready_Oam();
            ;JSL Rng              //   Rng();
            ;
            ;# Game ================
			;JSR Edit             //   Edit();
			;REP #$30
			;LDA Edit.mode
			;BEQ {+Off}
			;LDA joy1
			;PHA
			;STZ joy1
			;LDA joy1.edge
			;PHA
			;STZ joy1.edge
;{+Off}     ;
            ;JSR Gravity          //   Gravity();
			;JSR Particle         //   Particle();
            ;JSR Vrtan            //   Vrtan();
            ;JSR Crate            //   Crate();
;JSR Vrtan.SpikeTestDebug
            ;JSR Draw             //   Draw();
            ;JSR Debug            //   Debug();
            ;
			;LDA Edit.mode
			;BEQ {+Off}
			;PLA
			;STA joy1.edge
			;PLA
			;STA joy1
;{+Off}
			;
            ;# Rotate State =======
            ;REP #$20
            ;LDA gravity1
            ;STA gravity0
            ;SEP #$20
            ;
            ;# Debug ===============
            ;LDA usage            //   if(usage) INIDISP=(inidisp&0x0F)/2;
            ;BEQ {+Hide}          //
            ;LDA inidisp          //
            ;AND #$0F             //
            ;LSR A                //
            ;STA INIDISP          //
;{+Hide}    ;
            ;# Wait ================
            ;JSL Hide_Unused_Oam  //   Hide_Unused_Oam();
            ;LDA #$FF             //   Nmi.ready=0xFF;
            ;STA Nmi.ready        // }
;{+Wait}    ;JSL Nmi.Wait         // Nmi.Wait();
            ;
            ;PLP                  // Plp();
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Pause}                                                  //
            ;# ===============================================================//
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;# Data                                                           //
            ;# ===============================================================//
            ;#File sprite.asm   // Player sprite and animatin scripts
            
            ;#Data l bg.char    {#bg.chr}       // Background char, 8x8p 4-bit
            ;#Data l obj.char   {#obj.chr}      // Object char, 8x8p 4-bit
            ;#Data l palette    {#color.pal}    // Cgram palette
            ;#Data l level.name {#level.map}    // Level tilemap/level data
            ;#Data l sea.name   {#sea.map}      // Sea tilemap
            
            # ROM Registration =================================================
            ;#Data $00:FFB0 header{
                "R:" "GRAV"
                $00 $00 $00 $00 $00 $00 $00 $00 $00 $00
                "Graviton             "
                $20 $02 $09 $01 $01 $33 $00
                $0000 $FFFF
            }
            
            # Vector Table =====================================================
            ;#Data $00:FFE0 vector{
                $0000        $0000        Vector.Trap  Vector.Trap
                Vector.Trap  Vector.Nmi   $0000        Vector.Trap
                $0000        $0000        Vector.Trap  $0000
                Vector.Trap  Vector.Trap  Vector.Reset Vector.Trap
            }
            
            ;# ===============================================================//
            ;#                                                                //
            ;# ===============================================================//

