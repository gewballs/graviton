
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

;#Name $0800 hit.show

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

	;#Code w {Vrtan}
	;PHP
	;REP #$30
	;
	;LDX #$0000
	;JSR (vrtan.state,X)
	;
;LDA hit.show
;BEQ {+}
;JSR DrawHitbox
;{+}
	;
	;PLP
	;RTS
	
	;#Code w {Vrtan.Player}
	;RTS
	
	;#Code w {Vrtan.Idle}
	;
	;# Input ===========================
	;LDA joy1
	;BIT #$8000
	;BEQ {+NoJump}
	;LDA #$FFFD
	;BRA {+Dy}
;{+NoJump}	;LDA vrtan.x0
	;CLC
	;ADC vrtan.hit.x
	;STA Grounded.x
	;LDA vrtan.y0
	;CLC
	;ADC vrtan.hit.y
	;STA Grounded.y
	;LDA vrtan.hit.width
	;STA Grounded.width
	;LDA vrtan.hit.height
	;STA Grounded.height
	;JSR Grounded
	;BCS {+Neutral}
	;LDA #$0002
	;BRA {+Dy}
;{+Neutral}	;LDA #$0000
;{+Dy}	;STA vrtan.vy
	
	;LDA joy1
	;BIT #$0100 // Right
	;BEQ {+Left}
	;BIT #$4000 // X Button
	;BNE {+Fast}
	;LDA #$0001
	;BRA {+Dx}
;{+Fast}	;LDA #$0002
	;BRA {+Dx}
;{+Left}	;BIT #$0200 // Left
	;BEQ {+Neutral}
	;BIT #$4000 // X Button
	;BNE {+Fast}
	;LDA #$FFFF
	;BRA {+Dx}
;{+Fast}	;LDA #$FFFE
	;BRA {+Dx}
;{+Neutral}	;LDA #$0000
;{+Dx}	;STA vrtan.vx
	;
	;LDA vrtan.x0
	;CLC
	;ADC vrtan.hit.x
	;AND #$00FF
	;STA Move.x0
	;LDA vrtan.y0
	;CLC
	;ADC vrtan.hit.y
	;AND #$00FF
	;STA Move.y0
	;LDA vrtan.vx
	;STA Move.dx
	;LDA vrtan.vy
	;STA Move.dy
	;LDA vrtan.hit.width
	;STA Move.width
	;LDA vrtan.hit.height
	;STA Move.height
	;JSR Move
	;LDA Move.x1
	;SEC
	;SBC vrtan.hit.x
	;AND #$00FF
	;STA vrtan.x0
	;LDA Move.y1
	;SEC
	;SBC vrtan.hit.y
	;AND #$00FF
	;STA vrtan.y0
	;
	;LDA joy1.edge
	;BIT #$0020 // L
	;BEQ {+}
	;LDA hit.show
	;EOR #$FFFF
	;STA hit.show
	;
;{+}	;LDA joy1.edge
	;BIT #$0010 // R
	;BEQ {+}
	;LDA vrtan.hit.width
	;CMP #$0008
	;BEQ {+Big}
	;LDA #$0008
	;STA vrtan.hit.width
	;LDA #$0018
	;STA vrtan.hit.height
	;BRA {+}
;{+Big}	;LDA #$0020
	;STA vrtan.hit.width
	;LDA #$0028
	;STA vrtan.hit.height
;{+}	;
	;# Draw Script =====================
	;LDA joy1
	;BIT #$0F00
	;BNE {+Walk}
	;LDA vrtan.body.script
	;CMP #vrtan.body.idle.r.script
	;BEQ {+}
	;LDA #vrtan.body.idle.r.script
	;STA vrtan.body.script
	;STZ vrtan.body.frame
	;STZ vrtan.body.timer
	;LDA #vrtan.legs.idle.r.script
	;STA vrtan.legs.script
	;STZ vrtan.legs.frame
	;STZ vrtan.legs.timer
	;BRA {+}
;{+Walk}	;LDA vrtan.body.script
	;CMP #vrtan.body.walk.r.script
	;BEQ {+}
	;LDA #vrtan.body.walk.r.script
	;STA vrtan.body.script
	;LDA #vrtan.legs.walk.r.script
	;STA vrtan.legs.script
	;STZ vrtan.legs.frame
	;STZ vrtan.legs.timer
;{+}	;
	;RTS
	
	;#Code w {Vrtan.Walk}
	;RTS
	
	;#Code w {Vrtan.Jump}
	;RTS
	
	;#Code w {Vrtan.Punch}
	;RTS
	
	;#Code w {Vrtan.JumpPunch}
	;RTS
	
	;#Code w {Vrtan.Uppercut}
	;RTS
	
	;#Code w {Vrtan.Crush}
	;RTS
	
	;#Code w {Vrtan.Spike}
	;RTS
	
	;#Code w {Vrtan.Respawn}
	;RTS




	;#Code w {Grounded} ================================================
	;PHP
	;PHB
	;REP #$30
	;PEA $7E00
	;PLB
	;PLB
	;
	;LDA Grounded.x // Find initial level tile to test
	;TAY
	;LSR A
	;LSR A
	;LSR A
	;AND #$001F
	;STA Grounded.dx
	;LDA Grounded.y
	;CLC
	;ADC Grounded.height
	;AND #$00F8
	;ASL A
	;ASL A
	;CLC
	;ADC Grounded.dx
	;ASL A
	;TAX
	;
	;TYA // Find number of tiles to test
	;LSR A
	;LSR A
	;LSR A
	;STA Grounded.dx
	;TYA
	;CLC
	;ADC Grounded.width
	;DEC A
	;LSR A
	;LSR A
	;LSR A
	;SEC
	;SBC Grounded.dx
	;INC A
	;TAY
	;
;{-}	;LDA level,X
	;AND #$03FF
	;CMP #$0009 // Stone character
	;BEQ {+Pass}
	;TXA
	;AND #$FFC0
	;STA Grounded.row
	;TXA
	;INC A
	;INC A
	;AND #$003F
	;ORA Grounded.row
	;TAX
	;DEY
	;BNE {-}
	;
	;PLB
	;PLP
	;CLC // Fail
	;RTS
	;
;{+Pass}	;PLB
	;PLP
	;SEC // Pass
	;RTS


	;#Code w {Move} ====================================================
	;PHP                  // Php();
	;PHB                  // Phb();
	;REP #$30             // B=0x7E;
	;PEA $7E00            //
	;PLB                  //
	;PLB                  //
	;
	;LDA $001337          // !!! DEBUG !!!
	;
	;STZ Move.hit         // hit=0;
	;JSR Move.Y           // Move.Y();
	;LDA Move.y1          // y0=y1;
	;STA Move.y0          //
	;JSR Move.X           // Move.X();
	;
	;PLB                  // Plb();
	;PLP                  // Plp();
	;RTS                  // return;


	;#Code w {Move.X} ==================================================
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
	;STA Move.hit         //       return;
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


	;#Code w {Move.Y} ==================================================
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
	;STA Move.hit         //       return;
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

