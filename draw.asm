            
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
            ;JSR Draw.Players     // Players();
            ;JSR Draw.Entity      // Entity();
			;JSR Draw.Effects     // Effects();
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
            ;# Meter ===============
            ;
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
            ;#Code w {Draw.Entity}                                            //
            ;# ===============================================================//
            ;RTS
           










            ;#Data w hdma.sea {
				$0F $92
				$0F $91
				$0F $90
				$0F $8F
				$0F $8E
				$0F $8D
				$0F $8C
				$0F $8B
				$0F $8A
				$0F $89
				$0F $88
				$0F $87
				$0F $86
				$0F $85
				$0F $84
				$0F $83
			}

			;#Data w hdma.sea.set {
				$00 $32 hdma.sea
				$0000
			}

            ;# ===============================================================//
            ;#Code w {Draw.Effects}                                           //
            ;# ===============================================================//
			;SEP #$20
			;LDA #$00
			;STA cgswsel
			;LDA #$20
			;STA cgadsub
			;LDA #$8F
			;STA coldata_blue
			;REP #$20
			;
			;STZ Nmi.Hdma.data.h
			;LDA #hdma.sea.set
			;STA Nmi.Hdma.data
			;SEP #$20
			;LDA #$02
			;STA hdmaen
			;REP #$20
			;
			;
			;
			;
			;
            ;RTS
            
            ;# ===============================================================//
            ;#                                                                //
            ;# ===============================================================//

