            
			;#Name $0000 TILE_air
            ;#Name $0020 TILE_solid
            ;#Name $0026 TILE_mossUp
            ;#Name $0027 TILE_mossDown
            ;#Name $0021 TILE_spike


            ;# ===============================================================//
            ;#Code w {Move.Mob}                                               //
            ;# ===============================================================//
            ;PHP                  // Php();
            ;REP #$30             // Rep(0x30);
            ;
            ;LDA Move.dx          // if(abs(dx)>=abs(dy)){
            ;BPL {+Abs}           //
            ;EOR #$FFFF           //
            ;INC A                //
;{+Abs}     ;STA Move.abs         //
            ;LDA Move.dy          //
            ;BPL{+Abs}            //
            ;EOR #$FFFF           //
            ;INC A                //
;{+Abs}     ;CMP Move.abs         //
            ;BCC {+Y}             //
            ;
            ;LDA Move.x0          //     Push(x0);
            ;PHA                  //
            ;JSR Move.Mob.X       //     Move.Mob.X();
            ;LDA Move.x1          //     x0=x1;
            ;STA Move.x0          //
            ;JSR Move.Mob.Y       //     Move.Mob.Y();
            ;PLA                  //     x0=Pull();
            ;STA Move.x0          //
            ;BRA {+X}             // }else{
            ;
;{+Y}       ;LDA Move.y0          //     Push(y0);
            ;PHA                  //
            ;JSR Move.Mob.Y       //     Move.Mob.Y();
            ;LDA Move.y1          //     y0=y1;
            ;STA Move.y0          //
            ;JSR Move.Mob.X       //     Move.Mob.X();
            ;PLA                  //     y0=Pull();
            ;STA Move.y0          // }
            ;
;{+X}       ;PLP                  // Plp();
            ;RTS                  // return;

            ;# ===============================================================//
            ;#Code w {Move.Mob.X}                                             //
            ;# ===============================================================//
            ;LDA Move.dx          // if(dx==0){
            ;BNE {+Move}          //
            ;LDA Move.x0          //     x1=x0;
            ;STA Move.x1          //     return;
            ;RTS                  // }
            ;
;{+Move}    ;LDA Move.x0          // x1=(x0+dx)&0x00FF;
            ;CLC                  //
            ;ADC Move.dx          //
            ;AND #$00FF           //
            ;STA Move.x1          //
            ;
            ;LDA Move.dx          // if(dx>=0){
            ;BMI {+Minus}         //
            ;LDA Move.x0          //     xa=(x0+xw)&0x00FF;
            ;CLC                  //
            ;ADC Move.xw          //
            ;AND #$00FF           //
            ;STA Move.xa          //
            ;CLC                  //     xb=(xa+xy-1)&0x00FF;
            ;ADC Move.dx          //
            ;DEC A                //
            ;AND #$00FF           //
            ;STA Move.xb          //
            ;BRA {+Plus}          // }else{
;{+Minus}   ;LDA Move.x0          //     xb=(x0-1)&0x00FF;
            ;DEC A                //
            ;AND #$00FF           //
            ;STA Move.xb          //
            ;CLC                  //     xa=(xb+dx+1)&0x00FF;
            ;ADC Move.dx          //
            ;INC A                //
            ;AND #$00FF           //
            ;STA Move.xa          // }
;{+Plus}    ;
            ;LDA Move.y0          // ya=y0;
            ;STA Move.ya          //
            ;CLC                  // yb=(ya+yw-1)&0x00FF;
            ;ADC Move.yw          //
            ;DEC A                //
            ;AND #$00FF           //
            ;STA Move.yb          //
            ;
            ;LDX #$0000           // for(X=0:X<box.n:X++){
;{-Loop}    ;
            ;LDA box.wy,X         //     bw=box.wy[X];
            ;STA Move.bw          //
            ;LDA box.y,X          //     ba=box.y[X];
            ;STA Move.ba          //
            ;CLC                  //     bb=(ba+bw-1)&0x00FF;
            ;ADC Move.bw          //
            ;DEC A                //
            ;AND #$00FF           //
            ;STA Move.bb          //
            ;LDA Move.yw          //     if(!MoveIntersectY(yw)) continue;
            ;JSR Move.Intersect.Y //
            ;BCS {+}              //
            ;BRL {+Next}          //
;{+}        ;
            ;LDA box.wx,X         //     bw=box.wx[X];
            ;STA Move.bw          //
            ;LDA box.x,X          //     ba=box.x[X];
            ;STA Move.ba          //
            ;CLC                  //     bb=(ba+bw-1)&0x00FF;
            ;ADC Move.bw          //
            ;DEC A                //
            ;AND #$00FF           //
            ;STA Move.bb          //
            ;LDA Move.dx          //     if(!MoveIntersectX(dx)) continue;
            ;JSR Move.Intersect.X //
            ;BCC {+Next}          //
            ;
            ;LDA Move.dx          //     x1=(dx>=0?ba-xw:ba+bw)&0x00FF;
            ;BMI {+Minus}         //
            ;LDA Move.ba          //
            ;SEC                  //
            ;SBC Move.xw          //
            ;BRA {+Plus}          //
;{+Minus}   ;LDA Move.ba          //
            ;CLC                  //
            ;ADC Move.bw          //
;{+Plus}    ;AND #$00FF           //
            ;STA Move.x1          //
            ;
            ;LDA Move.x0          //     xa=x0;
            ;STA Move.xa          //
            ;CLC                  //     xb=(xa+dx)&0x00FF;
            ;ADC Move.dx          //
            ;AND #$00FF           //
            ;STA Move.xb          //
            ;LDA Move.dx          //     if(dx<0){
            ;BPL {+NoSwap}        //         A=xa;
            ;LDA Move.xa          //         Y=xb;
            ;LDY Move.xb          //         xa=Y;
            ;STA Move.xb          //         xb=A;
            ;STY Move.xa          //     }
;{+NoSwap}  ;JSR Move.InInterval.X//     if(!MoveInIntervalX()){
            ;BCS {+Valid}         //
            ;LDA Move.x0          //         x1=x0;
            ;STA Move.x1          //
            ;LDA #$0000           //         dx=0;
            ;STA Move.dx          //         return;
            ;BRA {+Return}        //     }
;{+Valid}   ;LDA Move.x1          //     A=x1-x0;
            ;SEC                  //
            ;SBC Move.x0          //
            ;BEQ {+Set}           //     if(A){
            ;LDY Move.dx          //         if(dx>=0){
            ;BMI {+Minus}         //
            ;BCS {+Set}           //             if(A<0) A+=0x0100;
            ;CLC                  //
            ;ADC #$0100           //
            ;BRA {+Set}           //         }else{
;{+Minus}   ;BCC {+Set}           //             if(A>=0) A-=0x0100;
            ;SEC                  //         }
            ;SBC #$0100           //     }
;{+Set}     ;STA Move.dx          //     dx=A;
            ;
            ;LDA Move.xa          //     xb=(xa+xw+dx-1)&0x00FF;
            ;CLC                  //
            ;ADC Move.xw          //
            ;ADC Move.dx          //
            ;DEC A                //
            ;AND #$00FF           //
            ;STA Move.xb          //
            ;
;{+Next}    ;INX                  // }
            ;INX                  //
            ;CPX box.n            //
            ;BCS {+Return}        //
            ;BRL {-Loop}          //
            ;
;{+Return}  ;RTS                  // return;

            ;# ===============================================================//
            ;#Code w {Move.Mob.Y}                                             //
            ;# ===============================================================//
            ;LDA Move.dy          // if(dy==0){
            ;BNE {+Move}          //
            ;LDA Move.y0          //     y1=y0;
            ;STA Move.y1          //     return;
            ;RTS                  // }
            ;
;{+Move}    ;LDA Move.y0          // y1=(y0+dy)&0x00FF;
            ;CLC                  //
            ;ADC Move.dy          //
            ;AND #$00FF           //
            ;STA Move.y1          //
            ;
            ;LDA Move.dy          // if(dy>=0){
            ;BMI {+Minus}         //
            ;LDA Move.y0          //     ya=(y0+yw)&0x00FF;
            ;CLC                  //
            ;ADC Move.yw          //
            ;AND #$00FF           //
            ;STA Move.ya          //
            ;CLC                  //     yb=(ya+yy-1)&0x00FF;
            ;ADC Move.dy          //
            ;DEC A                //
            ;AND #$00FF           //
            ;STA Move.yb          //
            ;BRA {+Plus}          // }else{
;{+Minus}   ;LDA Move.y0          //     yb=(y0-1)&0x00FF;
            ;DEC A                //
            ;AND #$00FF           //
            ;STA Move.yb          //
            ;CLC                  //     ya=(yb+dy+1)&0x00FF;
            ;ADC Move.dy          //
            ;INC A                //
            ;AND #$00FF           //
            ;STA Move.ya          // }
;{+Plus}    ;
            ;LDA Move.x0          // xa=x0;
            ;STA Move.xa          //
            ;CLC                  // xb=(xa+xw-1)&0x00FF;
            ;ADC Move.xw          //
            ;DEC A                //
            ;AND #$00FF           //
            ;STA Move.xb          //
            ;
            ;LDX #$0000           // for(X=0:X<box.n:X++){
;{-Loop}    ;
            ;LDA box.wx,X         //     bw=box.wx[X];
            ;STA Move.bw          //
            ;LDA box.x,X          //     ba=box.x[X];
            ;STA Move.ba          //
            ;CLC                  //     bb=(ba+bw-1)&0x00FF;
            ;ADC Move.bw          //
            ;DEC A                //
            ;AND #$00FF           //
            ;STA Move.bb          //
            ;LDA Move.xw          //     if(!MoveIntersectX(xw)) continue;
            ;JSR Move.Intersect.X //
            ;BCS {+}              //
            ;BRL {+Next}          //
;{+}        ;
            ;LDA box.wy,X         //     bw=box.wy[X];
            ;STA Move.bw          //
            ;LDA box.y,X          //     ba=box.y[X];
            ;STA Move.ba          //
            ;CLC                  //     bb=(ba+bw-1)&0x00FF;
            ;ADC Move.bw          //
            ;DEC A                //
            ;AND #$00FF           //
            ;STA Move.bb          //
            ;LDA Move.dy          //     if(!MoveIntersectY(dy)) continue;
            ;JSR Move.Intersect.Y //
            ;BCC {+Next}          //
            ;
            ;LDA Move.dy          //     y1=(dy>=0?ba-yw:ba+bw)&0x00FF;
            ;BMI {+Minus}         //
            ;LDA Move.ba          //
            ;SEC                  //
            ;SBC Move.yw          //
            ;BRA {+Plus}          //
;{+Minus}   ;LDA Move.ba          //
            ;CLC                  //
            ;ADC Move.bw          //
;{+Plus}    ;AND #$00FF           //
            ;STA Move.y1          //
            ;
            ;LDA Move.y0          //     ya=y0;
            ;STA Move.ya          //
            ;CLC                  //     yb=(ya+dy)&0x00FF;
            ;ADC Move.dy          //
            ;AND #$00FF           //
            ;STA Move.yb          //
            ;LDA Move.dy          //     if(dy<0){
            ;BPL {+NoSwap}        //         A=ya;
            ;LDA Move.ya          //         Y=yb;
            ;LDY Move.yb          //         ya=Y;
            ;STA Move.yb          //         yb=A;
            ;STY Move.ya          //     }
;{+NoSwap}  ;JSR Move.InInterval.Y//     if(!MoveInIntervalY()){
            ;BCS {+Valid}         //
            ;LDA Move.y0          //         y1=y0;
            ;STA Move.y1          //
            ;LDA #$0000           //         dy=0;
            ;STA Move.dy          //         return;
            ;BRA {+Return}        //     }
;{+Valid}   ;LDA Move.y1          //     A=y1-y0;
            ;SEC                  //
            ;SBC Move.y0          //
            ;BEQ {+Set}           //     if(A){
            ;LDY Move.dy          //         if(dy>=0){
            ;BMI {+Minus}         //
            ;BCS {+Set}           //             if(A<0) A+=0x0100;
            ;CLC                  //
            ;ADC #$0100           //
            ;BRA {+Set}           //         }else{
;{+Minus}   ;BCC {+Set}           //             if(A>=) A-=0x0100;
            ;SEC                  //         }
            ;SBC #$0100           //     }
;{+Set}     ;STA Move.dy          //     dy=A;
            ;
            ;LDA Move.ya          //     yb=(ya+yw+dy-1)&0x00FF;
            ;CLC                  //
            ;ADC Move.yw          //
            ;ADC Move.dy          //
            ;AND #$00FF           //
            ;DEC A                //
            ;STA Move.yb          //
            ;
;{+Next}    ;INX                  // }
            ;INX                  //
            ;CPX box.n            //
            ;BCS {+Return}        //
            ;BRL {-Loop}          //
            ;
;{+Return}  ;RTS                  // return;

            ;# ===============================================================//
            ;#Code w {Move.InInterval.X}                                      //
            ;# ===============================================================//
            ;LDA Move.xb          // if(
            ;CMP Move.xa          //     (xb>=xa)&&(xa<=x1&&x1<=xb)||
            ;BCC {+Wrap}          //
            ;LDA Move.x1          //
            ;CMP Move.xa          //
            ;BCC {+Miss}          //
            ;CMP Move.xb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           //
            ;BRA {+Miss}          //
;{+Wrap}    ;LDA Move.x1          //     (xb< xa)&&(xa<=x1||x1<=xb)
            ;CMP Move.xa          //
            ;BCS {+Hit}           //
            ;CMP Move.xb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           // ){
;{+Miss}    ;CLC                  //     return 1;
            ;RTS                  // }else{
;{+Hit}     ;SEC                  //     return 0;
            ;RTS                  // }

            ;# ===============================================================//
            ;#Code w {Move.InInterval.Y}                                      //
            ;# ===============================================================//
            ;LDA Move.yb          // if(
            ;CMP Move.ya          //     (yb>=ya)&&(ya<=y1&&y1<=yb)||
            ;BCC {+Wrap}          //
            ;LDA Move.y1          //
            ;CMP Move.ya          //
            ;BCC {+Miss}          //
            ;CMP Move.yb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           //
            ;BRA {+Miss}          //
;{+Wrap}    ;LDA Move.y1          //     (yb< ya)&&(ya<=y1||y1<=yb)
            ;CMP Move.ya          //
            ;BCS {+Hit}           //
            ;CMP Move.yb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           // ){
;{+Miss}    ;CLC                  //     return 1;
            ;RTS                  // }else{
;{+Hit}     ;SEC                  //     return 0;
            ;RTS                  // }

            ;# ===============================================================//
            ;#Code w {Move.Intersect.X}                                       //
            ;# ===============================================================//
            ;BPL {+Abs}           // if(
            ;EOR #$FFFF           //     (abs(A)<bw)&&(
            ;INC A                //
;{+Abs}     ;CMP Move.bw          //
            ;BCS {+Dx}            //
            ;
            ;LDA Move.bb          //         (bb>=ba)&&(
            ;CMP Move.ba          //
            ;BCC {+Wrap}          //
            ;
            ;LDA Move.xa          //             (ba<=xa&&xa<=bb)||
            ;CMP Move.ba          //
            ;BCC {+Or}            //
            ;CMP Move.bb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           //
            ;
;{+Or}      ;LDA Move.xb          //             (ba<=xb&&xb<=bb)
            ;CMP Move.ba          //
            ;BCC {+Miss}          //
            ;CMP Move.bb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           //         )||
            ;BRA {+Miss}          //         (bb< ba)&&(
            ;
;{+Wrap}    ;LDA Move.xa          //             (ba<=xa||xa<=bb)||
            ;CMP Move.ba          //
            ;BCS {+Hit}           //
            ;CMP Move.bb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           //
            ;
            ;LDA Move.xb          //             (ba<=xb||xb<=bb)
            ;CMP Move.ba          //
            ;BCS {+Hit}           //
            ;CMP Move.bb          //
            ;BCC {+Hit}           //         )
            ;BEQ {+Hit}           //     )||
            ;BRA {+Miss}          //     (abs(A)>=bw)&&(
            ;
;{+Dx}      ;LDA Move.xb          //         (xb>=xa)&&(
            ;CMP Move.xa          //
            ;BCC {+Wrap}          //
            ;
            ;LDA Move.ba          //             (xa<=ba&&ba<=xb)||
            ;CMP Move.xa          //
            ;BCC {+Or}            //
            ;CMP Move.xb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           //
            ;
;{+Or}      ;LDA Move.bb          //             (xa<=bb&&bb<=xb)
            ;CMP Move.xa          //
            ;BCC {+Miss}          //
            ;CMP Move.xb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           //         )||
            ;BRA {+Miss}          //         (xb< xa)&&(
            ;
;{+Wrap}    ;LDA Move.ba          //             (xa<=ba||ba<=xb)||
            ;CMP Move.xa          //
            ;BCS {+Hit}           //
            ;CMP Move.xb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           //
            ;
            ;LDA Move.bb          //             (xa<=bb||bb<=xb)
            ;CMP Move.xa          //
            ;BCS {+Hit}           //
            ;CMP Move.xb          //        )
            ;BCC {+Hit}           //     )
            ;BEQ {+Hit}           // ){
            ;
;{+Miss}    ;CLC                  //     return 1;
            ;RTS                  // }else{
;{+Hit}     ;SEC                  //     return 0;
            ;RTS                  // }

            ;# ===============================================================//
            ;#Code w {Move.Intersect.Y}                                       //
            ;# ===============================================================//
            ;BPL {+Abs}           // if(
            ;EOR #$FFFF           //     (abs(A)<bw)&&(
            ;INC A                //
;{+Abs}     ;CMP Move.bw          //
            ;BCS {+Dy}            //
            ;
            ;LDA Move.bb          //         (bb>=ba)&&(
            ;CMP Move.ba          //
            ;BCC {+Wrap}          //
            ;
            ;LDA Move.ya          //             (ba<=ya&&ya<=bb)||
            ;CMP Move.ba          //
            ;BCC {+Or}            //
            ;CMP Move.bb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           //
            ;
;{+Or}      ;LDA Move.yb          //             (ba<=yb&&yb<=bb)
            ;CMP Move.ba          //
            ;BCC {+Miss}          //
            ;CMP Move.bb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           //         )||
            ;BRA {+Miss}          //         (bb< ba)&&(
            ;
;{+Wrap}    ;LDA Move.ya          //             (ba<=ya||ya<=bb)||
            ;CMP Move.ba          //
            ;BCS {+Hit}           //
            ;CMP Move.bb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           //
            ;
            ;LDA Move.yb          //             (ba<=yb||yb<=bb)
            ;CMP Move.ba          //
            ;BCS {+Hit}           //
            ;CMP Move.bb          //
            ;BCC {+Hit}           //         )
            ;BEQ {+Hit}           //     )||
            ;BRA {+Miss}          //     (abs(A)>=bw)&&(
            ;
;{+Dy}      ;LDA Move.yb          //         (yb>=ya)&&(
            ;CMP Move.ya          //
            ;BCC {+Wrap}          //
            ;
            ;LDA Move.ba          //             (ya<=ba&&ba<=yb)||
            ;CMP Move.ya          //
            ;BCC {+Or}            //
            ;CMP Move.yb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           //
            ;
;{+Or}      ;LDA Move.bb          //             (ya<=bb&&bb<=yb)
            ;CMP Move.ya          //
            ;BCC {+Miss}          //
            ;CMP Move.yb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           //         )||
            ;BRA {+Miss}          //         (yb< ya)&&(
            ;
;{+Wrap}    ;LDA Move.ba          //             (ya<=ba||ba<=yb)||
            ;CMP Move.ya          //
            ;BCS {+Hit}           //
            ;CMP Move.yb          //
            ;BCC {+Hit}           //
            ;BEQ {+Hit}           //
            ;
            ;LDA Move.bb          //             (ya<=bb||bb<=yb)
            ;CMP Move.ya          //
            ;BCS {+Hit}           //
            ;CMP Move.yb          //        )
            ;BCC {+Hit}           //     )
            ;BEQ {+Hit}           // ){
            ;
;{+Miss}    ;CLC                  //     return 1;
            ;RTS                  // }else{
;{+Hit}     ;SEC                  //     return 0;
            ;RTS                  // }




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
            ;STZ Move.stop        // stop=0;
            ;JSR Move.Y           // Move.Y();
            ;LDA Move.y0          //
            ;PHA                  //
            ;LDA Move.y1          // y0=y1;
            ;STA Move.y0          //
            ;JSR Move.X           // Move.X();
            ;PLA                  //
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
;{+Delta}   ;BMI {+Left}          // x0Pixel=dx<0?x0:x0+width-1;
            ;LDA Move.x0          //
            ;CLC                  //
            ;ADC Move.xw       //
            ;DEC A                //
            ;BRA {+Right}         //
;{+Left}    ;LDA Move.x0          //
;{+Right}   ;TAY                  //
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
;{+Sign}    ;SEC                  //
            ;SBC Move.dx.tile     //
            ;BPL {+Abs}           // // Absolute value
            ;EOR #$FFFF           //
            ;INC A                //
;{+Abs}     ;INC A                //
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
            ;ADC Move.yw      //
            ;DEC A                //
            ;LSR A                //
            ;LSR A                //
            ;LSR A                //
            ;SEC                  //
            ;SBC Move.dy.tile     //
            ;BPL {+Abs}           // // Absolute value
            ;EOR #$FFFF           //
            ;INC A                //
;{+Abs}     ;INC A                //
            ;STA Move.dy.tile     //
            ;
            ;# First Tile ==========
            ;STZ Move.iteration   // iteration=0;
            ;LDA Move.x0          // index=(dx<0?x0:x0+width-1)%0x0100/8;
            ;LDX Move.dx          //
            ;BMI {+Minus}         //
            ;CLC                  //
            ;ADC Move.xw       //
            ;DEC A                //
;{+Minus}   ;AND #$00FF           //
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
;{-Column}  ;LDY Move.dy.tile     // for(:dxTile:dxTile--){ // Column
;{-Row}     ;TAX                  //   X=index;
            ;LDA level,X          //   for(Y=dyTile:Y:Y--){ // Row
            ;AND #$03FF           //     switch(level[X]&0x03FF){
            ;CMP #TILE_solid      //     case TILE_solid:
            ;BEQ {+Stop}          //
            ;CMP #TILE_mossUp
            ;BEQ {+Stop}
            ;CMP #TILE_mossDown
            ;BNE {+Air}
;{+Stop}    ;LDA Move.iteration   //       if(iteration==0){
            ;BNE {+Outside}       //
            ;LDA Move.x0          //         x1=x0;
            ;BRA {+Inside}        //       }else{
;{+Outside} ;TXA                  //         A=X*4&0x00F8;
            ;ASL A                //
            ;ASL A                //
            ;AND #$00F8           //
            ;LDX Move.dx          //         x1=A+(dx<0?0x08:-width)&0x00FF;
            ;BMI {+Left}          //
            ;SEC                  //
            ;SBC Move.xw       //
            ;BRA {+Right}         //
;{+Left}    ;CLC                  //
            ;ADC #$0008           //
;{+Right}   ;AND #$00FF           //
;{+Inside}  ;STA Move.x1          //       }
            ;LDA Move.dx          //       Move.stop|=dx<0?0x0004:0x0001;
            ;BMI {+Left}          //
            ;LDA #$0001           //
            ;BRA {+Right}         //
;{+Left}    ;LDA #$0004           //
;{+Right}   ;ORA Move.stop        //
            ;STA Move.stop        //       return;
            ;RTS                  //     }
;{+Air}     ;TXA                  //     X=(X+0x0040)%0x0800;
            ;CLC                  //
            ;ADC #$0040           //
            ;AND #$07FF           //
            ;DEY                  //
            ;BEQ {+}              //
            ;BRL {-Row}           //   }
;{+}        ;LDA Move.index       //   X=index;
            ;TAX                  //
            ;LDY Move.dx          //   index=X%0x07C0|(X+(dx<0?-2:2))%0x40;
            ;BMI {+Dec}           //
            ;INC A                //
            ;INC A                //
            ;BRA {+Inc}           //
;{+Dec}     ;DEC A                //
            ;DEC A                //
;{+Inc}     ;AND #$003F           //
            ;STA Move.index       //
            ;TXA                  //
            ;AND #$07C0           //   
            ;ORA Move.index       //
            ;STA Move.index       //
            ;INC Move.iteration   //   iteration++;
            ;DEC Move.dx.tile     // }
            ;BEQ {+}              //
            ;BRL {-Column}        //
;{+}        ;LDA Move.x0          // x1=(x0+dx)%0x0100;
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
;{+Delta}   ;BMI {+Up}            // y0Pixel=dy<0?y0:y0+height-1;
            ;LDA Move.y0          //
            ;CLC                  //
            ;ADC Move.yw      //
            ;DEC A                //
            ;BRA {+Down}          //
;{+Up}      ;LDA Move.y0          //
;{+Down}    ;TAY                  //
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
;{+Sign}    ;SEC                  //
            ;SBC Move.dy.tile     //
            ;BPL {+Abs}           // // Absolute value
            ;EOR #$FFFF           //
            ;INC A                //
;{+Abs}     ;INC A                //
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
            ;ADC Move.xw       //
            ;DEC A                //
            ;LSR A                //
            ;LSR A                //
            ;LSR A                //
            ;SEC                  //
            ;SBC Move.dx.tile     //
            ;BPL {+Abs}           // // Absolute value
            ;EOR #$FFFF           //
            ;INC A                //
;{+Abs}     ;INC A                //
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
            ;ADC Move.yw      //
            ;DEC A                //
;{+Minus}   ;AND #$00F8           //
            ;ASL A                //
            ;ASL A                //
            ;CLC                  //
            ;ADC Move.index       //
            ;ASL A                // // Word indexing
            ;STA Move.index       // index*=2;
            ;
            ;# Iterate =============
;{-Row}     ;LDY Move.dx.tile     // for(:dyTile:dyTile--){ // Column
;{-Column}  ;TAX                  //   X=index;
            ;LDA level,X          //   for(Y=dxTile:Y:Y--){ // Row
            ;AND #$03FF           //     if((level[X]&0x03FF)==TILE_stone){
            ;CMP #TILE_solid      //     case TILE_solid:
            ;BEQ {+Stop}          //
            ;CMP #TILE_mossUp
            ;BEQ {+Stop}
            ;CMP #TILE_mossDown
            ;BNE {+Air}
;{+Stop}    ;LDA Move.iteration   //       if(iteration==0){
            ;BNE {+Outside}       //
            ;LDA Move.y0          //         y1=y0;
            ;BRA {+Inside}        //       }else{
;{+Outside} ;TXA                  //
            ;LSR A                //         y1=X/8&0x00F8+(dy<0?0x08:-height);
            ;LSR A                //
            ;LSR A                //
            ;AND #$00F8           //
            ;LDX Move.dy          //
            ;BMI {+Up}            //
            ;SEC                  //
            ;SBC Move.yw      //
            ;BRA {+Down}          //
;{+Up}      ;CLC                  //
            ;ADC #$0008           //
;{+Down}    ;AND #$00FF           //         y1%=0x0100
;{+Inside}  ;STA Move.y1          //       }
            ;LDA Move.dy          //       Move.stop|=dy<0?0x0008:0x0002;
            ;BMI {+Up}            //
            ;LDA #$0002           //
            ;BRA {+Down}          //
;{+Up}      ;LDA #$0008           //
;{+Down}    ;ORA Move.stop        //
            ;STA Move.stop        //       return;
            ;RTS                  //     }
;{+Air}     ;TXA                  //     X=X&0x07C0|(X+2)%0x40;
            ;INC A                //
            ;INC A                //
            ;AND #$003F           //
            ;STA Move.temp        //
            ;TXA                  //
            ;AND #$07C0           //
            ;ORA Move.temp        //
            ;DEY                  //
            ;BEQ {+}              //
            ;BRL {-Column}        //   }
;{+}        ;LDA Move.index       //   index+=dy<0?-0x40:0x40;
            ;LDY Move.dy          //
            ;BMI {+Dec}           //
            ;CLC                  //
            ;ADC #$0040           //
            ;BRA {+Inc}           //
;{+Dec}     ;SEC                  //
            ;SBC #$0040           //
;{+Inc}     ;AND #$07FF           //   index%=0x0800;
            ;STA Move.index       //
            ;INC Move.iteration   //   iteration++;
            ;DEC Move.dy.tile     // }
            ;BEQ {+}              //
            ;BRL {-Row}           //
;{+}        ;LDA Move.y0          // y1=(y0+dy)%0x0100;
            ;CLC                  //
            ;ADC Move.dy          //
            ;AND #$00FF           //
            ;STA Move.y1          //
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#                                                                //
            ;# ===============================================================//

