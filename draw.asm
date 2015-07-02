            
            ;# ===============================================================//
            ;#Code w {Draw}                                                   //
            ;# ===============================================================//
            ;PHP                  // Php();
            ;REP #$30             // Rep(P_m|P_x);
            ;
            ;# Draw ================
            ;JSR Draw.Debug       // Debug();
            ;JSR Draw.Palette     // Palette();
            ;JSR Draw.Character   // Character();
            ;JSR Draw.Hud         // Hud();
            ;JSR Draw.Level       // Level();
            ;JSR Draw.Box         // Box();
            ;JSR Draw.Players     // Players();
            ;JSR Draw.Entity      // Entity();
            ;JSR Draw.Gradient    // Gradient();
            ;JSR Draw.Grass       // Grass();
            ;
            ;PLP                  // Plp();
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Draw.Debug}                                             //
            ;# ===============================================================//
            ;PHP
            ;
            ;LDA vrtan.hit.show
            ;BNE {+Show}
            ;BRL {+Hide}
            ;
;{+Show}    ;SEP #$20
            ;LDA vrtan.hazard
            ;BIT #$0C
            ;BNE {+Hurt}
            ;LDA #$00
            ;BRA {+Fine}
;{+Hurt}    ;LDA #$3E
;{+Fine}    ;STA Draw_Sprite.obj_p_override
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
            ;
            ;SEP #$20
            ;LDA vrtan.hazard
            ;BIT #$06
            ;BNE {+Hurt}
            ;LDA #$00
            ;BRA {+Fine}
;{+Hurt}    ;LDA #$3E
;{+Fine}    ;STA Draw_Sprite.obj_p_override
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
            ;
            ;SEP #$20
            ;LDA vrtan.hazard
            ;BIT #$03
            ;BNE {+Hurt}
            ;LDA #$00
            ;BRA {+Fine}
;{+Hurt}    ;LDA #$3E
;{+Fine}    ;STA Draw_Sprite.obj_p_override
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
            ;
            ;SEP #$20
            ;LDA vrtan.hazard
            ;BIT #$09
            ;BNE {+Hurt}
            ;LDA #$00
            ;BRA {+Fine}
;{+Hurt}    ;LDA #$3E
;{+Fine}    ;STA Draw_Sprite.obj_p_override
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
;{+Hide}    ;
            ;PLP
            ;RTS
            
            ;# ===============================================================//
            ;#Code w {Draw.Palette}                                           //
            ;# ===============================================================//
            ;RTS
            
            ;# ===============================================================//
            ;#Code w {Draw.Character}                                         //
            ;# ===============================================================//
            ;RTS
            
            ;# ===============================================================//
            ;#Code w {Draw.Hud}                                               //
            ;# ===============================================================//
            ;
            ;# !!! DEBUG !!! =======
            ;INC p0.score    // Essentially a frame counter
            ;LDA vrtan.hazard     // Hurt/stop directions
            ;ASL A                //
            ;ASL A                //
            ;ASL A                //
            ;ASL A                //
            ;ORA vrtan.stop       //
            ;STA p1.score    //
            ;
            ;# Score 0 =============
            ;LDX Nmi.Write.i      // X=Nmi.Write.i;
            ;LDA #$0025           // Nmi.Write.base[X]=0x0025;
            ;STA Nmi.Write.base,X //
            ;LDA p0.score    // A=0x2410|p0.score&0x000F;
            ;TAY                  //
            ;AND #$000F           //
            ;ORA #$2410           //
            ;STA Nmi.Write.data,X // Nmi.Write.data[X]=A;
            ;INX                  // X+=0x0004;
            ;INX                  //
            ;INX                  //
            ;INX                  //
            ;
            ;LDA #$0024           // Nmi.Write.base[X]=0x0024;
            ;STA Nmi.Write.base,X //
            ;TYA                  // A=0x2410|(p0.score>>4)&0x000F;
            ;AND #$00F0           //
            ;LSR A                //
            ;LSR A                //
            ;LSR A                //
            ;LSR A                //
            ;ORA #$2410           //
            ;STA Nmi.Write.data,X // Nmi.Write.data[X]=A;
            ;INX                  // X+=0x0004;
            ;INX                  //
            ;INX                  //
            ;INX                  //
            ;
            ;# Score 1 =============
            ;LDA #$003E           // Nmi.Write.base[X]=0x003E;
            ;STA Nmi.Write.base,X //
            ;LDA p1.score    // A=0x2410|p1.score&0x000F;
            ;TAY                  //
            ;AND #$000F           //
            ;ORA #$2410           //
            ;STA Nmi.Write.data,X // Nmi.Write.data[X]=A;
            ;INX                  // X+=0x0004;
            ;INX                  //
            ;INX                  //
            ;INX                  //
            ;
            ;LDA #$003D           // Nmi.Write.base[X]=0x003D;
            ;STA Nmi.Write.base,X //
            ;TYA                  // A=0x2410|(p1.score>>4)&0x000F;
            ;AND #$00F0           //
            ;LSR A                //
            ;LSR A                //
            ;LSR A                //
            ;LSR A                //
            ;ORA #$2410           //
            ;STA Nmi.Write.data,X // Nmi.Write.data[X]=0x2410;
            ;INX                  // X+=0x0004;
            ;INX                  //
            ;INX                  //
            ;INX                  //
            ;STX Nmi.Write.i      // Nmi.Write.i=X;
            ;
            ;# Gravity gauge =======
            ;LDX Nmi.Write.i
            ;LDA gravity1         //
            ;TAY
            ;BEQ {+Clear}
            ;BMI {+Minus}
            ;
            ;# Positive
            ;LDA #$0030           // Vram address
;{-}          ;STA Nmi.Write.base,X
            ;TYA
            ;BNE {+Nonzero}
            ;LDA #$2408
            ;STA Nmi.Write.data,X
            ;BRA {+Next}
            ;
;{+Nonzero} ;CMP #$0008
            ;BCS {+Fill}
            ;CLC
            ;ADC #$2408
            ;STA Nmi.Write.data,X
            ;LDY #$0000
            ;BRA {+Next}
            ;
;{+Fill}    ;LDA #$240F
            ;STA Nmi.Write.data,X
            ;TYA
            ;SEC
            ;SBC #$0008
            ;TAY
            ;
;{+Next}    ;LDA Nmi.Write.base,X
            ;INX
            ;INX
            ;INX
            ;INX
            ;
            ;INC A
            ;CMP #$0034
            ;BNE {-}
            ;BRA {+Break}
            ;
;{+Clear}   ;LDA #$002F           // Vram address
              ;STA Nmi.Write.base,X
            ;LDA #$6408
            ;STA Nmi.Write.data,X
            ;INX
            ;INX
            ;INX
            ;INX
            ;LDA #$0030           // Vram address
              ;STA Nmi.Write.base,X
            ;LDA #$2408
            ;STA Nmi.Write.data,X
            ;INX
            ;INX
            ;INX
            ;INX
            ;BRA {+Break}
            ;
;{+Minus}   ;# Negative
            ;EOR #$FFFF
            ;INC A
            ;TAY
            ;LDA #$002F           // Vram address
;{-}          ;STA Nmi.Write.base,X
            ;TYA
            ;BNE {+Nonzero}
            ;LDA #$6408
            ;STA Nmi.Write.data,X
            ;BRA {+Next}
            ;
;{+Nonzero} ;CMP #$0008
            ;BCS {+Fill}
            ;CLC
            ;ADC #$6408
            ;STA Nmi.Write.data,X
            ;LDY #$0000
            ;BRA {+Next}
            ;
;{+Fill}    ;LDA #$640F
            ;STA Nmi.Write.data,X
            ;TYA
            ;SEC
            ;SBC #$0008
            ;TAY
            ;
;{+Next}    ;LDA Nmi.Write.base,X
            ;INX
            ;INX
            ;INX
            ;INX
            ;
            ;DEC A
            ;CMP #$002B
            ;BNE {-}
            ;
;{+Break}   ;STX Nmi.Write.i
            ;
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Draw.Level}                                             //
            ;# ===============================================================//
            ;LDA stat78           //
            ;BIT #$0080           //
            ;BEQ {+}              //
            ;LDA bg2hofs          // bg2hofs=(bg2hofs+1)%0x0400;
            ;INC A                //
            ;AND #$03FF           //
            ;STA bg2hofs          //
;{+}        ;
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Draw.Players}                                           //
            ;# ===============================================================//
            ;SEP #$20
            ;STZ Draw_Sprite.data_bank
            ;STZ Draw_Sprite.obj_p_override
            ;LDA vrtan.x0
            ;STA Draw_Sprite.x
            ;LDA vrtan.y0
            ;STA Draw_Sprite.y
            ;REP #$20
            ;STZ Draw_Sprite.char_i
            ;LDA #vrtan.body.script
            ;STA AnimateSprite.base
            ;JSR AnimateSprite
            ;LDA #vrtan.legs.script
            ;STA AnimateSprite.base
            ;JSR AnimateSprite
            ;RTS
            
            ;# ===============================================================//
            ;#Code w {Draw.Box}                                               //
            ;# ===============================================================//
;LDA $00BEEF

            ;LDX #$0000
;{-Loop}    ;SEP #$20
            ;STZ Draw_Sprite.data_bank
            ;STZ Draw_Sprite.obj_p_override
            ;LDA box.x,X
            ;STA Draw_Sprite.x
            ;LDA box.y,X
            ;STA Draw_Sprite.y
            ;REP #$20
            ;STZ Draw_Sprite.char_i
            ;LDA #box.sprite
            ;STA Draw_Sprite.data_i
            ;PHX
            ;JSR Draw_Sprite
            ;PLX
            ;INX
            ;INX
            ;CPX box.n
            ;BNE {-Loop}
            ;RTS
            
            ;# ===============================================================//
            ;#Code w {Draw.Entity}                                            //
            ;# ===============================================================//
            ;RTS
           
            ;#Data w hdma.sea{
                $0F gradient
                $0F $0727
                $0F $0728
                $0F $0729
                $0F $072A
                $0F $072B
                $0F $072C
                $0F $072D
                $0F $072E
                $0F $072F
                $0F $0730
                $0F $0731
                $0F $0732
                $0F $0733
                $0F $0734
                $0F $0735
                $00
            }

            ;#Data w hdma.sea.set{
                $40 $32 hdma.sea $00
                $0000
            }

            ;# ===============================================================//
            ;#Code w {Draw.Gradient}                                          //
            ;# ===============================================================//
            ;# Registers ===============
            ;SEP #$20
            ;LDA #$00
            ;STA cgswsel
            ;LDA #$20
            ;STA cgadsub
            ;
            ;# Direction ===============
            ;LDA gravity1
            ;CLC
            ;ADC #$20
            ;LSR A
            ;LSR A
            ;STA gradient.b1
            ;LDA #$0F
            ;SEC
            ;SBC gradient.b1
            ;STA gradient.b0
            ;
            ;LDA gradient.b1
            ;CMP gradient.b0
            ;BCC {+Neg}
            ;
            ;# Positive ================
            ;SEC
            ;SBC gradient.b0
            ;REP #$20
            ;AND #$00FF
            ;ASL A
            ;ASL A
            ;ASL A
            ;ASL A
            ;STA gradient.db
            ;LDX #$000F
            ;LDA gradient.b1
            ;AND #$00FF
            ;XBA
;{-Loop}     ;PHA
            ;XBA
            ;SEP #$20
            ;CMP #$20
            ;BCC {+NoClamp}
            ;LDA #$1F
;{+NoClamp} ;ORA #$80
            ;STA gradient,X
            ;REP #$20
            ;PLA
            ;SEC
            ;SBC gradient.db
            ;DEX
            ;BPL {-Loop}
            ;BRA {+Pos}
            ;
            ;# Negative ================
;{+Neg}        ;LDA gradient.b0
            ;SEC
            ;SBC gradient.b1
            ;REP #$20
            ;AND #$00FF
            ;ASL A
            ;ASL A
            ;ASL A
            ;ASL A
            ;STA gradient.db
            ;LDX #$000F
            ;LDA gradient.b1
            ;AND #$00FF
            ;XBA
;{-Loop}     ;PHA
            ;XBA
            ;SEP #$20
            ;CMP #$20
            ;BCC {+NoClamp}
            ;LDA #$1F
;{+NoClamp} ;ORA #$80
            ;STA gradient,X
            ;REP #$20
            ;PLA
            ;CLC
            ;ADC gradient.db
            ;DEX
            ;BPL {-Loop}
;{+Pos}        ;
            ;# Hdma ====================
            ;STZ Nmi.Hdma.data.h
            ;LDA #hdma.sea.set
            ;STA Nmi.Hdma.data
            ;SEP #$20
            ;LDA #$02
            ;STA hdmaen
            ;REP #$20
            ;
            ;RTS
            
            ;#Data w grass.base{
                $0088
                $009A
                $0142
                $0145
                $0232
                $025D
                $02B9
                $0362
                $037E
            }
            ;#Data w grass.tile{
                $A800
                $E800
                $6800
                $2800
                $A800
                $6800
                $E800
                $2800
                $2800
            }
            ;#Data w grass.name.v0{
                $0022
                $0023
                $0024
                $0025
            }
            ;#Data w grass.name.v1{
                $0025
                $0024
                $0023
                $0022
            }

            ;# ===============================================================//
            ;#Code w {Draw.Grass}                                             //
            ;# ===============================================================//
            ;LDA grass.timer
            ;BNE {+Wait}
            ;
            ;LDA #$0008
            ;STA grass.timer
            ;
            ;LDA gravity1
            ;BMI {+Up}
            ;DEC grass.frame
            ;DEC grass.frame
            ;BRA {+Down}
;{+Up}      ;INC grass.frame
            ;INC grass.frame
;{+Down}    ;LDA grass.frame
            ;BPL {+Max}
            ;LDA #$0000
            ;BRA {+Min}
;{+Max}     ;CMP #$0008
            ;BCC {+Ok}
            ;LDA #$0006
;{+Min}     ;STA grass.frame
;{+Ok}      ;
            ;# Update tiles
            ;
            ;
            ;LDX Nmi.Write.i
            ;LDY #$0010
;{-}        ;LDA grass.base,Y
            ;STA Nmi.Write.base,X
            ;LDA grass.tile,Y
            ;PHY
            ;LDY grass.frame
            ;BIT #$8000
            ;BNE {+Flip}
            ;ORA grass.name.v0,Y
            ;BRA {+NoFlip}
;{+Flip}    ;ORA grass.name.v1,Y
;{+NoFlip}  ;STA Nmi.Write.data,X
            ;INX
            ;INX
            ;INX
            ;INX
            ;PLY
            ;DEY
            ;DEY
            ;BPL {-}
            ;STX Nmi.Write.i
            ;
            ;
            ;
;{+Idle}    ;LDA grass.timer
            ;BEQ {+Zero}
;{+Wait}    ;DEC grass.timer
;{+Zero}    ;
            ;RTS









            ;# ===============================================================//
            ;#                                                                //
            ;# ===============================================================//

