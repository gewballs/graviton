            
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
            ;SEI                  // SetE(EMULATION_off);
            ;CLC                  //
            ;XCE                  //
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
            
            ;# Game ================
            ;#File draw.asm       // Render code
			;#File gravity.asm    // Gravity code
            ;#File vrtan.asm      // Player code
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
            
            ;# ===============================================================//
            ;#Code w {Engine.Initiate}                                        //
            ;# ===============================================================//
            ;PHP                  // Php();
            ;PHB                  // Phb();
            ;PHK                  // B=K;
            ;PLB                  //
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
            ;JSL Dma.Immediate    // Dma.Immediate(0x01,0x18,vrtan.char,0x1000);
            ;#Data {$01 $18 vrtan.char $1000} // Obj characer set, 8x8p, 4-bit
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
            ;LDA #03              // // OBJ=8x8,NameSelect=+0x2000,Base=0xC000
            ;STA objsel           // objsel=0x03;
            ;LDA #$01             // // BG(4,3,2,1)=8x8,BG3Priority=0,Mode 1
            ;STA bgmode           // bgmode=0x01;
            ;LDA #$00             // // BG1 VRAM Base=0x0000,SC=1x1
            ;STA bg1sc            // bg1sc=0x00;
            ;LDA #$04             // // BG2 VRAM Base=0x0800,SC=1x1
            ;STA bg2sc            // bg2sc=0x04;
            ;LDA #$08             // // BG3 VRAM Base=0x1000,SC=1x1
            ;STA bg3sc            // bg3sc=0x08;
            ;LDA #$11             // // BG2 Name=0x2000,BG1 Name=0x2000
            ;STA bg12nba          // bg12nba=0x11;
            ;LDA #$02             // // BG4 Name=0x0000,BG3 Name=0x2000
            ;STA bg34nba          // bg34nba=0x02;
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
            ;CLI                  // Cli();
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
            ;LDA #$0078           // vrtan.x0=0x0078;
            ;STA vrtan.x0         //
            ;LDA #$00A8           // vrtan.y0=0x00A8;
            ;STA vrtan.y0         // 
            ;STZ vrtan.vx         // vrtan.vx=0;
            ;STZ vrtan.vy         // vrtan.vy=0;
            ;STZ vrtan.left0      // vrtan.left0=0;
            ;STZ vrtan.flip       // vrtan.flip=0;
            ;LDA #$0003           // vrtan.hit.x=0x0003;
            ;STA vrtan.hit.x      //
            ;LDA #$0006           // vrtan.hit.y=0x0006;
            ;STA vrtan.hit.y      //
            ;LDA #$0008           // vrtan.hit.width=0x0008;
            ;STA vrtan.hit.width  //
            ;LDA #$0019           // vrtan.hit.height=0x0019;
            ;STA vrtan.hit.height //
            ;LDA #$0040           // vrtan.ghost=0x0040;
            ;STA vrtan.ghost      //
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
			;JSR Gravity          //   Gravity();
            ;JSR Vrtan            //   Vrtan();
            ;JSR Draw             //   Draw();
            ;JSR Debug            //   Debug();
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
            ;#File vrtan.spr      // Player sprite and animatin scripts
            
            ;#Data l bg.char    {#bg.chr}       // Background char, 8x8p 4-bit
            ;#Data l vrtan.char {#vrtan.chr}    // Player obj char, 8x8p 4-bit
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

