	
	;# !!!DEBUG!!!
	;#Data w hit.tl.sprite{
	    $00
	    $00 $00 $3C7F $00
	}
	;#Data w hit.bl.sprite{
	    $00
	    $00 $F8 $BC7F $00
	}
	;#Data w hit.br.sprite{
	    $00
	    $F8 $F8 $FC7F $01
	}
	;#Data w hit.tr.sprite{
	    $00
	    $F8 $00 $7C7F $01
	}

	;# !!! DEBUG !!!
	;#Name $0800 hit.show

	;# !!! DEBUG !!!
	;#Code w {DrawHitbox}
	;PHP
	;SEP #$20
	;STZ Draw_Sprite.obj_p_override
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
	;SEP #$20
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
	;SEP #$20
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
	;SEP #$20
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
	;PLP
	;RTS
	
	;# ===============================================================//
	;#Code w {Vrtan}                                                  //
	;# ===============================================================//
	;PHP                  // Php();
	;REP #$30             // Rep(0x30);
	;
	;# Program =============
	;LDX #$0000           // state0();
	;JSR (vrtan.state0,X) //
	;
	;# Drawing =============
	;JSR Vrtan.Sprite     // VrtanSprite();
	;
	;# Rotate State ========
	;LDA vrtan.state1     // state0=state1;
	;STA vrtan.state0     //
	;LDA vrtan.left1      // left0=left1;
	;STA vrtan.left0      //
	;LDA vrtan.x1         // x0=x1;
	;STA vrtan.x0         //
	;LDA vrtan.y1         // y0=y1;
	;STA vrtan.y0         //
	;
	;# !!! DEBUG !!!
	;# Hitbox ==============
	;LDA joy1.edge        // if(joy1.edge&0x0020){
	;BIT #$0020           //
	;BEQ {+}              //
	;LDA hit.show         //   hit.show==!hit.show;
	;EOR #$FFFF           //
	;STA hit.show         // }
;{+}	;LDA hit.show         // if(hit.show) DrawHitBox();
	;BEQ {+}              //
	;JSR DrawHitbox       //
;{+}        ;
	;PLP                  // Plp();
	;RTS                  // return;
	
	;# ===============================================================//
	;#Code w {Vrtan.Idle}                                             //
	;# ===============================================================//
	;# Dx ==================
	;LDA joy1             // if(joy1&0x0100){ // D-pad right
	;BIT #$0100           //
	;BEQ {+Left}          //   // X button
	;BIT #$4000           //   vx=joy1&0x4000?2:1;
	;BNE {+Fast}          //
	;LDA #$0001           //
	;BRA {+Dx}            //
;{+Fast}	;LDA #$0002           //
	;BRA {+Dx}            // }else if(joy1&0200){ // D-pad left
;{+Left}	;BIT #$0200           //
	;BEQ {+Neutral}       //   // X button
	;BIT #$4000           //   vx=joy1&0x4000?-2:-1;
	;BNE {+Fast}          //
	;LDA #$FFFF           //
	;BRA {+Dx}            //
;{+Fast}	;LDA #$FFFE           //
	;BRA {+Dx}            // }else{
;{+Neutral}	;LDA #$0000           //   vx=0;
;{+Dx}	;STA vrtan.vx         // }
	;
	;# Dy ==================
	;LDA joy1             // // B button;
	;BIT #$8000           // vy=joy1&0x8000?-3:2;
	;BEQ {+Fall}          //
	;LDA #$FFFD           //
	;BRA {+Dy}            //
;{+Fall}	;LDA #$0002           //
;{+Dy}	;STA vrtan.vy         //
	;
	;# Move ================
	;JSR Vrtan.Move       // VrtanMove();
	;LDA Move.y1          // if(y1<y0){
	;CMP Move.y0          //
	;BCS {+Fall}          //
	;LDA #Vrtan.Jump      //   state1=VrtanJump;
	;STA vrtan.state1     //
	;LDA #$0018           //   jump=0x0018;
	;STA vrtan.jump       //
	;BRA {+Break}         //
;{+Fall}	;BEQ {+Walk}          // }else if(y1>y0){
	;LDA #Vrtan.Fall      //   state1=VrtanFall;
	;STA vrtan.state1     //
	;BRA {+Break}         // }else if(x1!=x0){
;{+Walk}	;LDA Move.x1          //
	;CMP Move.x0          //
	;BEQ {+Idle}          //
	;LDA #Vrtan.Walk      //   state1=VrtanWalk;
	;STA vrtan.state1     //
	;BRA {+Break}         // }else{
;{+Idle}	;LDA #Vrtan.Idle      //   state1=VrtanIdle;
	;STA vrtan.state1     // }
;{+Break}	;
	;RTS                  // return;
	
	;# ===============================================================//
	;#Code w {Vrtan.Walk}                                             //
	;# ===============================================================//
	;# Dx ==================
	;LDA joy1             // if(joy1&0x0100){ // Right
	;BIT #$0100           //
	;BEQ {+Left}          //   // X Button
	;BIT #$4000           //   vx=joy1&0x4000?2:1;
	;BNE {+Fast}          //
	;LDA #$0001           //
	;BRA {+Dx}            //
;{+Fast}	;LDA #$0002           //
	;BRA {+Dx}            // }else if(joy1&0200){ //Left
;{+Left}	;BIT #$0200           //
	;BEQ {+Neutral}       //   // X button
	;BIT #$4000           //   vx=joy1&0x4000?-2:-1;
	;BNE {+Fast}          //
	;LDA #$FFFF           //
	;BRA {+Dx}            //
;{+Fast}	;LDA #$FFFE           //
	;BRA {+Dx}            // }else{
;{+Neutral}	;LDA #$0000           //   vx=0;
;{+Dx}	;STA vrtan.vx         // }
	;
	;# Dy ==================
	;LDA joy1             // // B button;
	;BIT #$8000           // vy=joy1&0x8000?-3:2;
	;BEQ {+Fall}          //
	;LDA #$FFFD           //
	;BRA {+Dy}            //
;{+Fall}	;LDA #$0002           //
;{+Dy}	;STA vrtan.vy         //
	;
	;# Move ================
	;JSR Vrtan.Move       // VrtanMove();
	;LDA Move.y1          // if(y1<y0){
	;CMP Move.y0          //
	;BCS {+Fall}          //
	;LDA #Vrtan.Jump      //   state1=VrtanJump;
	;STA vrtan.state1     //
	;LDA joy1             //   jump=joy1&0x4000?0x0028:0x0020;
	;BIT #$4000           //
	;BNE {+Fast}          //
	;LDA #$0020           //
	;BRA {+Slow}          //
;{+Fast}	;LDA #$0028           //
;{+Slow}	;STA vrtan.jump       //
	;BRA {+Break}         //
;{+Fall}	;BEQ {+Walk}          // }else if(y1>y0){
	;LDA #Vrtan.Fall      //   state1=VrtanFall;
	;STA vrtan.state1     //
	;BRA {+Break}         //
;{+Walk}	;LDA Move.x1          // }else if(x1!=x0){
	;CMP Move.x0          //
	;BEQ {+Idle}          //
	;LDA #Vrtan.Walk      //   state1=VrtanWalk;
	;STA vrtan.state1     //
	;BRA {+Break}         // }else{
;{+Idle}	;LDA #Vrtan.Idle      //   state1=VrtanIdle;
	;STA vrtan.state1     // }
;{+Break}	;
	;RTS                  // return;
	
	;# ===============================================================//
	;#Code w {Vrtan.Jump}                                             //
	;# ===============================================================//
	;# Dy ==================
	;LDA joy1             // if(joy1&0x8000&&jump<0){ // B Button
	;BIT #$8000           //
	;BEQ {+Fall}          //
	;LDA vrtan.jump       //
	;BMI {+Fall}          //
	;DEC vrtan.jump       //   jump--;
	;LDA #$FFFD           //   vy=-3;
	;BRA {+Dy}            // }else{
;{+Fall}	;LDA #$0000           //   vy=0;
;{+Dy}	;STA vrtan.vy         // }
	;
	;# Dx ==================
	;LDA joy1             // if(joy1&0x0100){ // D-pad right
	;BIT #$0100           //
	;BEQ {+Left}          //   // X button
	;BIT #$4000           //   vx=joy1&0x4000?2:1;
	;BNE {+Fast}          //
	;LDA #$0001           //
	;BRA {+Dx}            //
;{+Fast}	;LDA #$0002           //
	;BRA {+Dx}            //
;{+Left}	;BIT #$0200           // }else if(joy1&0x0200){ // D-pad left
	;BEQ {+Neutral}       //   // X button
	;BIT #$4000           //   vx=joy1&0x4000?-2:-1;
	;BNE {+Fast}          //
	;LDA #$FFFF           //
	;BRA {+Dx}            //
;{+Fast}	;LDA #$FFFE           //
	;BRA {+Dx}            //
;{+Neutral}	;LDA #$0000           //
;{+Dx}	;STA vrtan.vx         //
	;
	;# Move ================
	;JSR Vrtan.Move       // VrtanMove();
	;LDA Move.y1          // if(y1>=y0){
	;CMP Move.y0          //
	;BCC {+Jump}          //
	;LDA #Vrtan.Fall      //   state1=VrtanFall;
	;STA vrtan.state1     //
	;BRA {+Break}         // }else{
;{+Jump}	;LDA #Vrtan.Jump      //   state1=VrtanJump;
	;STA vrtan.state1     // }
;{+Break}	;
	;RTS                  // return;
	
	;# ===============================================================//
	;#Code w {Vrtan.Fall}                                             //
	;# ===============================================================//
	;# Dy ==================
	;LDA #$0003           // vy=3;
	;STA vrtan.vy         //
	
	;# Dx ==================
	;LDA joy1             // if(joy1&0x0100){ // Right
	;BIT #$0100           //
	;BEQ {+Left}          //   // X Button
	;BIT #$4000           //   vx=joy1&0x4000?2:1;
	;BNE {+Fast}          //
	;LDA #$0001           //
	;BRA {+Dx}            //
;{+Fast}	;LDA #$0002           //
	;BRA {+Dx}            // }else if(joy1&0200){ //Left
;{+Left}	;BIT #$0200           //
	;BEQ {+Neutral}       //   // X button
	;BIT #$4000           //   vx=joy1&0x4000?-2:-1;
	;BNE {+Fast}          //
	;LDA #$FFFF           //
	;BRA {+Dx}            //
;{+Fast}	;LDA #$FFFE           //
	;BRA {+Dx}            // }else{
;{+Neutral}	;LDA #$0000           //   vx=0;
;{+Dx}	;STA vrtan.vx         // }
	;
	;# Move ================
	;JSR Vrtan.Move       // VrtanMove();
	;LDA Move.y1          // if(y1==y0){
	;CMP Move.y0          //
	;BNE {+Fall}          //
	;LDA Move.x1          //   if(x1==x0){
	;CMP Move.x0          //
	;BNE {+Walk}          //
	;LDA #Vrtan.Idle      //     state=VrtanIdle;
	;STA vrtan.state1     //
	;BRA {+Break}         //   }else{
;{+Walk}	;LDA #Vrtan.Walk      //     state=VrtanWalk;
	;STA vrtan.state1     //   }
	;BRA {+Break}         // }else{
;{+Fall}	;LDA #Vrtan.Fall      //   state1=VrtanFall;
	;STA vrtan.state1     // }
;{+Break}	;
	;RTS                  // return;
	
	;#Code w {Vrtan.Punch}
	;RTS                  // return;
	
	;#Code w {Vrtan.JumpPunch}
	;RTS                  // return;
	
	;#Code w {Vrtan.Uppercut}
	;RTS                  // return;
	
	;#Code w {Vrtan.Crush}
	;RTS                  // return;
	
	;#Code w {Vrtan.Spike}
	;RTS                  // return;
	
	;#Code w {Vrtan.Respawn}
	;RTS                  // return;
	
	;# ===============================================================//
	;#Code w {Vrtan.Sprite}                                           //
	;# ===============================================================//
	;LDA vrtan.state1     // if(state1!=state0||left1!=left0){
	;CMP vrtan.state0     //
	;BNE {+Walk}          //
	;LDX vrtan.left1      //
	;CPX vrtan.left0      //
	;BEQ {+Done}          //
;{+Walk}	;CMP #Vrtan.Walk      //   if(state1==Vrtan.Walk){
	;BNE {+Jump}          //
	;LDA vrtan.left1      //     if(!left){
	;BNE {+Left}          //
	;LDX #vrtan.body.walk.r.script // X=body.walk.r.script;
	;LDY #vrtan.legs.walk.r.script // Y=legs.walk.r.script;
	;BRA {+Break}         //     }else{
;{+Left}	;LDX #vrtan.body.walk.l.script // X=body.walk.l.script;
	;LDY #vrtan.legs.walk.l.script // Y=legs.walk.l.script;
	;BRA {+Break}         //     }
;{+Jump}	;CMP #Vrtan.Jump      //   }else if(state1==Vrtan.Jump){
	;BNE {+Fall}          //
	;LDA vrtan.left1      //     if(!left){
	;BNE {+Left}          //
	;LDX #vrtan.body.jump.r.script // X=body.jump.r.script;
	;LDY #vrtan.legs.jump.r.script // Y=legs.jump.r.script;
	;BRA {+Break}         //     }else{
;{+Left}	;LDX #vrtan.body.jump.l.script // X=body.jump.l.script;
	;LDY #vrtan.legs.jump.l.script // Y=legs.jump.l.script;
	;BRA {+Break}         //     }
;{+Fall}	;CMP #Vrtan.Fall      //   }else if(state1==Vrtan.Fall){
	;BNE {+Idle}          //
	;LDA vrtan.left1      //     if(!left){
	;BNE {+Left}          //
	;LDX #vrtan.body.idle.r.script // X=body.idle.r.script;
	;LDY #vrtan.legs.idle.r.script // Y=legs.idle.r.script;
	;BRA {+Break}         //     }else{
;{+Left}	;LDX #vrtan.body.idle.l.script // X=body.idle.l.script;
	;LDY #vrtan.legs.idle.l.script // Y=legs.idle.l.script;
	;BRA {+Break}         //     }
;{+Idle}	;LDA vrtan.left1      //   }else{
	;BNE {+Left}          //     if(!left){
	;LDX #vrtan.body.idle.r.script // X=body.idle.r.script;
	;LDY #vrtan.legs.idle.r.script // Y=legs.idle.r.script;
	;BRA {+Break}         //     }else{
;{+Left}	;LDX #vrtan.body.idle.l.script // X=body.idle.l.script;
	;LDY #vrtan.legs.idle.l.script // Y=legs.idle.l.script;
;{+Break}	;STX vrtan.body.script//     }
	;STZ vrtan.body.frame //   }
	;STZ vrtan.body.timer //   body.script=X,body.frame=body.timer=0;
	;STY vrtan.legs.script//   legs.script=Y,legs.frame=legs.timer=0;
	;STZ vrtan.legs.frame //
	;STZ vrtan.legs.timer // }
;{+Done}	;RTS                  // return;
	
	;# ===============================================================//
	;#Code w {Vrtan.Move}                                             //
	;# ===============================================================//
	;LDA vrtan.x0         // Move.x0=(x0+hit.x)%0x0100;
	;CLC                  //
	;ADC vrtan.hit.x      //
	;AND #$00FF           //
	;STA Move.x0          //
	;LDA vrtan.y0         // Move.y0=(y0+hit.y)%0x0100;
	;CLC                  //
	;ADC vrtan.hit.y      //
	;AND #$00FF           //
	;STA Move.y0          //
	;LDA vrtan.vx         // Move.dx=vx;
	;STA Move.dx          //
	;LDA vrtan.vy         // Move.dy=vy;
	;STA Move.dy          //
	;LDA vrtan.hit.width  // Move.hit.width=hit.width;
	;STA Move.width       //
	;LDA vrtan.hit.height // Move.hit.height=hit.height;
	;STA Move.height      //
	;JSR Move             // Move();
	;
	;LDA Move.x1          // x1=(Move.x1-hit.x)%0x0100;
	;SEC                  //
	;SBC vrtan.hit.x      //
	;AND #$00FF           //
	;STA vrtan.x1         //
	;LDA Move.y1          // y1=(Move.y1-hit.y)%0x0100;
	;SEC                  //
	;SBC vrtan.hit.y      //
	;AND #$00FF           //
	;STA vrtan.y1         //
	;
	;LDA vrtan.x1         // if(x1!=x0){ 
	;CMP vrtan.x0         //
	;BEQ {+Same}          //
	;LDA vrtan.vx         //   left1=vx<0?0xFFFF:0x0000;
	;BMI {+Left}          //
	;LDA #$0000           //
	;BRA {+Right}         //
;{+Left}	;LDA #$FFFF           //
;{+Right}	;STA vrtan.left1      // }
;{+Same}	;
	;RTS                  // return;
	
	;# ===============================================================//
	;#Code w {Move}                                                   //
	;# ===============================================================//
	;PHP                  // Php();
	;PHB                  // Phb();
	;REP #$30             // B=0x7E;
	;PEA $7E00            //
	;PLB                  //
	;PLB                  //
	;
	;STZ Move.hit.x       // hitX=0;
	;STZ Move.hit.y       // hitY=0;
	;JSR Move.Y           // Move.Y();
	;LDA Move.y0          //
	;STA Move.copy        //
	;LDA Move.y1          // y0=y1;
	;STA Move.y0          //
	;JSR Move.X           // Move.X();
	;LDA Move.copy        //
	;STA Move.y0          //
	;
	;PLB                  // Plb();
	;PLP                  // Plp();
	;RTS                  // return;
	
	;# ===============================================================//
	;#Code w {Move.X}                                                 //
	;# ===============================================================//
	;# dxTile ==============
	;LDA Move.dx          // if(dx==0){
	;BNE {+Delta}         //
	;LDA Move.x0          //   x1=x0;
	;STA Move.x1          //   return;
	;RTS                  // }
;{+Delta}	;BMI {+Left}          // x0Pixel=dx<0?x0:x0+width-1;
	;LDA Move.x0          //
	;CLC                  //
	;ADC Move.width       //
	;DEC A                //
	;BRA {+Right}         //
;{+Left}	;LDA Move.x0          //
;{+Right}	;TAY                  //
	;LSR A                // dxTile=abs((x0Pixel+dx)/8-x0Pixel/8)+1;
	;LSR A                //
	;LSR A                //
	;STA Move.dx.tile     //
	;TYA                  //
	;CLC                  //
	;ADC Move.dx          //
	;LSR A                //
	;LSR A                //
	;LSR A                //
	;BIT #$1000           // // Sign extend
	;BEQ {+Sign}          //
	;ORA #$E000           //
;{+Sign}	;SEC                  //
	;SBC Move.dx.tile     //
	;BPL {+Abs}           // // Absolute value
	;EOR #$FFFF           //
	;INC A                //
;{+Abs}	;INC A                //
	;STA Move.dx.tile     //
	;
	;# dyTile ==============
	;LDA Move.y0          // dyTile=abs((y0+height-1)/8-y0/8)+1;
	;TAY                  //
	;LSR A                //
	;LSR A                //
	;LSR A                //
	;STA Move.dy.tile     //
	;TYA                  //
	;CLC                  //
	;ADC Move.height      //
	;DEC A                //
	;LSR A                //
	;LSR A                //
	;LSR A                //
	;SEC                  //
	;SBC Move.dy.tile     //
	;BPL {+Abs}           // // Absolute value
	;EOR #$FFFF           //
	;INC A                //
;{+Abs}	;INC A                //
	;STA Move.dy.tile     //
	;
	;# First Tile ==========
	;STZ Move.iteration   // iteration=0;
	;LDA Move.x0          // index=(dx<0?x0:x0+width-1)%0x0100/8;
	;LDX Move.dx          //
	;BMI {+Minus}         //
	;CLC                  //
	;ADC Move.width       //
	;DEC A                //
;{+Minus}	;AND #$00FF           //
	;LSR A                //
	;LSR A                //
	;LSR A                //
	;STA Move.index       //
	;LDA Move.y0          // index+=y0%0x0100/8*0x0020;
	;AND #$00F8           //
	;ASL A                //
	;ASL A                //
	;CLC                  //
	;ADC Move.index       //
	;ASL A                // // Word indexing
	;STA Move.index       // index*=2;
	;
	;# Iterate =============
;{-Column}	;LDY Move.dy.tile     // for(:dxTile:dxTile--){ // Column
;{-Row}	;TAX                  //   X=index;
	;LDA level,X          //   for(Y=dyTile:Y:Y--){ // Row
	;AND #$03FF           //     if((level[X]&0x03FF)==TILE_stone){
	;CMP #$0009           //
	;BNE {+Air}           //
	;LDA Move.iteration   //       if(iteration==0){
	;BNE {+Outside}       //
	;LDA Move.x0          //         x1=x0;
	;BRA {+Inside}        //       }else{
;{+Outside}	;TXA                  //         A=X*4&0x00F8;
	;ASL A                //
	;ASL A                //
	;AND #$00F8           //
	;LDX Move.dx          //         x1=A+(dx<0?0x08:-width)&0x00FF;
	;BMI {+}              //
	;SEC                  //
	;SBC Move.width       //
	;BRA {++}             //
;{+}	;CLC                  //
	;ADC #$0008           //
;{++}	;AND #$00FF           //
;{+Inside}	;STA Move.x1          //       }
	;LDA #$FFFF           //       hit=1;
	;STA Move.hit.x       //       return;
	;RTS                  //     }
;{+Air}	;TXA                  //     X=(X+0x0040)%0x0800;
	;CLC                  //
	;ADC #$0040           //
	;AND #$07FF           //
	;DEY                  //
	;BNE {-Row}           //   }
	;LDA Move.index       //   X=index;
	;TAX                  //
	;LDY Move.dx          //   index=X%0x07C0|(X+(dx<0?-2:2))%0x40;
	;BMI {+Dec}           //
	;INC A                //
	;INC A                //
	;BRA {+Inc}           //
;{+Dec} 	;DEC A                //
	;DEC A                //
;{+Inc}	;AND #$003F           //
	;STA Move.index       //
	;TXA                  //
	;AND #$07C0           //   
	;ORA Move.index       //
	;STA Move.index       //
	;INC Move.iteration   //   iteration++;
	;DEC Move.dx.tile     // }
	;BNE {-Column}        //
	;LDA Move.x0          // x1=(x0+dx)%0x0100;
	;CLC                  //
	;ADC Move.dx          //
	;AND #$00FF           //
	;STA Move.x1          //
	;RTS                  // return;

	;# ===============================================================//
	;#Code w {Move.Y}                                                 //
	;# ===============================================================//
	;# dyTile ==============
	;LDA Move.dy          // if(dy==0){
	;BNE {+Delta}         //
	;LDA Move.y0          //   y1=y0;
	;STA Move.y1          //   return;
	;RTS                  // }
;{+Delta}	;BMI {+Up}            // y0Pixel=dy<0?y0:y0+height-1;
	;LDA Move.y0          //
	;CLC                  //
	;ADC Move.height      //
	;DEC A                //
	;BRA {+Down}          //
;{+Up}	;LDA Move.y0          //
;{+Down}	;TAY                  //
	;LSR A                // dyTile=abs((y0Pixel+dy)/8-y0Pixel/8)+1;
	;LSR A                //
	;LSR A                //
	;STA Move.dy.tile     //
	;TYA                  //
	;CLC                  //
	;ADC Move.dy          //
	;LSR A                //
	;LSR A                //
	;LSR A                //
	;BIT #$1000           // // Sign extend
	;BEQ {+Sign}          //
	;ORA #$E000           //
;{+Sign}	;SEC                  //
	;SBC Move.dy.tile     //
	;BPL {+Abs}           // // Absolute value
	;EOR #$FFFF           //
	;INC A                //
;{+Abs}	;INC A                //
	;STA Move.dy.tile     //
	;
	;# dxTile ==============
	;LDA Move.x0          // dxTile=abs((x0+width-1)/8-x0/8)+1;
	;TAY                  //
	;LSR A                //
	;LSR A                //
	;LSR A                //
	;STA Move.dx.tile     //
	;TYA                  //
	;CLC                  //
	;ADC Move.width       //
	;DEC A                //
	;LSR A                //
	;LSR A                //
	;LSR A                //
	;SEC                  //
	;SBC Move.dx.tile     //
	;BPL {+Abs}           // // Absolute value
	;EOR #$FFFF           //
	;INC A                //
;{+Abs}	;INC A                //
	;STA Move.dx.tile     //
	;
	;# First Tile ==========
	;STZ Move.iteration   // iteration=0;
	;LDA Move.x0          // index=x0%0x0100/8;
	;AND #$00FF           //
	;LSR A                //
	;LSR A                //
	;LSR A                //
	;STA Move.index       //
	;LDA Move.y0          // index+=(dy<0?y0:y0+height-1)%0x0100/8*0x20;
	;LDX Move.dy          //
	;BMI {+Minus}         //
	;CLC                  //
	;ADC Move.height      //
	;DEC A                //
;{+Minus}	;AND #$00F8           //
	;ASL A                //
	;ASL A                //
	;CLC                  //
	;ADC Move.index       //
	;ASL A                // // Word indexing
	;STA Move.index       // index*=2;
	;
	;# Iterate =============
;{-Row}	;LDY Move.dx.tile     // for(:dyTile:dyTile--){ // Column
;{-Column}	;TAX                  //   X=index;
	;LDA level,X          //   for(Y=dxTile:Y:Y--){ // Row
	;AND #$03FF           //     if((level[X]&0x03FF)==TILE_stone){
	;CMP #$0009           //
	;BNE {+Air}           //
	;LDA Move.iteration   //       if(iteration==0){
	;BNE {+Outside}       //
	;LDA Move.y0          //         y1=y0;
	;BRA {+Inside}        //       }else{
;{+Outside}	;TXA                  //
	;LSR A                //         y1=X/8&0x00F8+(dy<0?0x08:-height);
	;LSR A                //
	;LSR A                //
	;AND #$00F8           //
	;LDX Move.dy          //
	;BMI {+}              //
	;SEC                  //
	;SBC Move.height      //
	;BRA {++}             //
;{+}	;CLC                  //
	;ADC #$0008           //
;{++}	;AND #$00FF           //         y1%=0x0100
;{+Inside}	;STA Move.y1          //       }
	;LDA #$FFFF           //       hit=1;
	;STA Move.hit.y       //       return;
	;RTS                  //     }
;{+Air}	;TXA                  //     X=X&0x07C0|(X+2)%0x40;
	;INC A                //
	;INC A                //
	;AND #$003F           //
	;STA Move.temp        //
	;TXA                  //
	;AND #$07C0           //
	;ORA Move.temp        //
	;DEY                  //
	;BNE {-Column}        //   }
	;LDA Move.index       //   index+=dy<0?-0x40:0x40;
	;LDY Move.dy          //
	;BMI {+Dec}           //
	;CLC                  //
	;ADC #$0040           //
	;BRA {+Inc}           //
;{+Dec} 	;SEC                  //
	;SBC #$0040           //
;{+Inc}	;AND #$07FF           //   index%=0x0800;
	;STA Move.index       //
	;INC Move.iteration   //   iteration++;
	;DEC Move.dy.tile     // }
	;BNE {-Row}           //
	;LDA Move.y0          // y1=(y0+dy)%0x0100;
	;CLC                  //
	;ADC Move.dy          //
	;AND #$00FF           //
	;STA Move.y1          //
	;RTS                  // return;
	
	;# ===============================================================//
	;#                                                                //
	;# ===============================================================//

