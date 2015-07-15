            
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
;{+Move}    ;LDA Move.x0          // x1=x0+dx;
            ;CLC                  //
            ;ADC Move.dx          //
            ;STA Move.x1          //
            ;
            ;LDA Move.dx          // if(dx>=0){
            ;BMI {+Minus}         //
            ;LDA Move.x0          //     xa=x0+xw;
            ;CLC                  //
            ;ADC Move.xw          //
            ;STA Move.xa          //
            ;CLC                  //     xb=xa+xy-1;
            ;ADC Move.dx          //
            ;DEC A                //
            ;STA Move.xb          //
            ;BRA {+Plus}          // }else{
;{+Minus}   ;LDA Move.x0          //     xb=x0-1;
            ;DEC A                //
            ;STA Move.xb          //
            ;CLC                  //     xa=xb+dx+1;
            ;ADC Move.dx          //
            ;INC A                //
            ;STA Move.xa          // }
;{+Plus}    ;
            ;LDA Move.y0          // ya=y0;
            ;STA Move.ya          //
            ;CLC                  // yb=ya+yw-1;
            ;ADC Move.yw          //
            ;DEC A                //
            ;STA Move.yb          //
            ;
            ;LDX #$0000           // for(X=0:X<crate.n:X++){
;{-Loop}    ;
            ;LDA crate.wy,X       //     bw=crate.wy[X];
            ;STA Move.bw          //
            ;LDA crate.y,X        //     ba=crate.y[X];
            ;STA Move.ba          //
            ;CLC                  //     bb=ba+bw-1;
            ;ADC Move.bw          //
            ;DEC A                //
            ;STA Move.bb          //
            ;LDA Move.yw          //     if(!MoveIntersectY(yw)) continue;
            ;JSR Move.Intersect.Y //
            ;BCS {+}              //
            ;BRL {+Next}          //
;{+}        ;
            ;LDA crate.wx,X       //     bw=crate.wx[X];
            ;STA Move.bw          //
            ;LDA crate.x,X        //     ba=crate.x[X];
            ;STA Move.ba          //
            ;CLC                  //     bb=ba+bw-1;
            ;ADC Move.bw          //
            ;DEC A                //
            ;STA Move.bb          //
            ;LDA Move.dx          //     if(!MoveIntersectX(dx)) continue;
            ;JSR Move.Intersect.X //
            ;BCC {+Next}          //
            ;
            ;LDA Move.dx          //     x1=(dx>=0)?(ba-xw):(ba+bw);
            ;BMI {+Minus}         //
            ;LDA Move.ba          //
            ;SEC                  //
            ;SBC Move.xw          //
            ;BRA {+Plus}          //
;{+Minus}   ;LDA Move.ba          //
            ;CLC                  //
            ;ADC Move.bw          //
;{+Plus}    ;STA Move.x1          //
            ;
            ;LDA Move.x0          //     xa=x0;
            ;STA Move.xa          //
            ;CLC                  //     xb=xa+dx;
            ;ADC Move.dx          //
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
            ;BCS {+Set}           //             if(A<0) A=-A;
            ;BRA {+Negate}        //         }else{
;{+Minus}   ;BCC {+Set}           //             if(A>=0) A=-A;
;{+Negate}  ;EOR #$FFFF           //         }
            ;INC A                //     }
;{+Set}     ;STA Move.dx          //     dx=A;
            ;
            ;LDA Move.xa          //     xb=xa+xw+dx-1;
            ;CLC                  //
            ;ADC Move.xw          //
            ;ADC Move.dx          //
            ;DEC A                //
            ;STA Move.xb          //
            ;
;{+Next}    ;INX                  // }
            ;INX                  //
            ;CPX crate.n          //
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
;{+Move}    ;LDA Move.y0          // y1=y0+dy;
            ;CLC                  //
            ;ADC Move.dy          //
            ;STA Move.y1          //
            ;
            ;LDA Move.dy          // if(dy>=0){
            ;BMI {+Minus}         //
            ;LDA Move.y0          //     ya=y0+yw;
            ;CLC                  //
            ;ADC Move.yw          //
            ;STA Move.ya          //
            ;CLC                  //     yb=ya+yy-1;
            ;ADC Move.dy          //
            ;DEC A                //
            ;STA Move.yb          //
            ;BRA {+Plus}          // }else{
;{+Minus}   ;LDA Move.y0          //     yb=y0-1;
            ;DEC A                //
            ;STA Move.yb          //
            ;CLC                  //     ya=yb+dy+1;
            ;ADC Move.dy          //
            ;INC A                //
            ;STA Move.ya          // }
;{+Plus}    ;
            ;LDA Move.x0          // xa=x0;
            ;STA Move.xa          //
            ;CLC                  // xb=xa+xw-1;
            ;ADC Move.xw          //
            ;DEC A                //
            ;STA Move.xb          //
            ;
            ;LDX #$0000           // for(X=0:X<crate.n:X++){
;{-Loop}    ;
            ;LDA crate.wx,X       //     bw=crate.wx[X];
            ;STA Move.bw          //
            ;LDA crate.x,X        //     ba=crate.x[X];
            ;STA Move.ba          //
            ;CLC                  //     bb=ba+bw-1;
            ;ADC Move.bw          //
            ;DEC A                //
            ;STA Move.bb          //
            ;LDA Move.xw          //     if(!MoveIntersectX(xw)) continue;
            ;JSR Move.Intersect.X //
            ;BCS {+}              //
            ;BRL {+Next}          //
;{+}        ;
            ;LDA crate.wy,X       //     bw=crate.wy[X];
            ;STA Move.bw          //
            ;LDA crate.y,X        //     ba=crate.y[X];
            ;STA Move.ba          //
            ;CLC                  //     bb=ba+bw-1;
            ;ADC Move.bw          //
            ;DEC A                //
            ;STA Move.bb          //
            ;LDA Move.dy          //     if(!MoveIntersectY(dy)) continue;
            ;JSR Move.Intersect.Y //
            ;BCC {+Next}          //
            ;
            ;LDA Move.dy          //     y1=(dy>=0)?(ba-yw):(ba+bw);
            ;BMI {+Minus}         //
            ;LDA Move.ba          //
            ;SEC                  //
            ;SBC Move.yw          //
            ;BRA {+Plus}          //
;{+Minus}   ;LDA Move.ba          //
            ;CLC                  //
            ;ADC Move.bw          //
;{+Plus}    ;STA Move.y1          //
            ;
            ;LDA Move.y0          //     ya=y0;
            ;STA Move.ya          //
            ;CLC                  //     yb=ya+dy;
            ;ADC Move.dy          //
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
            ;BCS {+Set}           //             if(A<0) A=-A;
            ;BRA {+Negate}        //         }else{
;{+Minus}   ;BCC {+Set}           //             if(A>=0) A=-A;
;{+Negate}  ;EOR #$FFFF           //         }
            ;INC A                //     }
;{+Set}     ;STA Move.dy          //     dy=A;
            ;
            ;LDA Move.ya          //     yb=ya+yw+dy-1;
            ;CLC                  //
            ;ADC Move.yw          //
            ;ADC Move.dy          //
            ;DEC A                //
            ;STA Move.yb          //
            ;
;{+Next}    ;INX                  // }
            ;INX                  //
            ;CPX crate.n          //
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
            ;#Code w {Move.Level}                                             //
            ;# ===============================================================//
            ;PHP                  // Php();
            ;PHB                  // Phb();
            ;REP #$30             // B=0x7E;
            ;PEA $7E00            //
            ;PLB                  //
            ;PLB                  //
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
            ;JSR Move.Level.X     //     Move.Level.X();
            ;LDA Move.x1          //     x0=x1;
            ;STA Move.x0          //
            ;JSR Move.Level.Y     //     Move.Level.Y();
            ;PLA                  //     x0=Pull();
            ;STA Move.x0          //
            ;BRA {+X}             // }else{
            ;
;{+Y}       ;LDA Move.y0          //     Push(y0);
            ;PHA                  //
            ;JSR Move.Level.Y     //     Move.Level.Y();
            ;LDA Move.y1          //     y0=y1;
            ;STA Move.y0          //
            ;JSR Move.Level.X     //     Move.Level.X();
            ;PLA                  //     y0=Pull();
            ;STA Move.y0          // }
            ;
;{+X}       ;PLB                  // Plb();
            ;PLP                  // Plp();
            ;RTS                  // return;


            ;# ===============================================================//
            ;#Code w {Move.Level.X}                                           //
            ;# ===============================================================//
            ;# Still ===============
            ;LDA Move.dx          // if(dx==0){
            ;BNE {+Move}          //
            ;LDA Move.x0          //     x1=x0;
            ;STA Move.x1          //
            ;STZ Move.dx          //     dx=0;
            ;RTS                  //     return;
;{+Move}    ;
            ;# dxTile ==============
            ;BMI {+Minus}         // }else if(dx>=0){
            ;LDA Move.x0          //     xa=(x0+xw)&0xF800;
            ;CLC                  //
            ;ADC Move.xw          //
            ;TAY                  //
            ;AND #$F800           //
            ;STA Move.dx.tile     //
            ;TYA                  //     xb=(x0+xw+dx-1)&0xF800;
            ;CLC                  //
            ;ADC Move.dx          //
            ;DEC A                //
            ;BRA {+Sub}           // }else if(dx<0){
;{+Minus}   ;LDA Move.x0          //     xa=(x0-1+dx+1)&0xF800;
            ;DEC A                //
            ;TAY                  //
            ;CLC                  //
            ;ADC Move.dx          //
            ;INC A                //
            ;AND #$F800           //
            ;STA Move.dx.tile     //
            ;TYA                  //     xb=(x0-1)&0xF800;
;{+Sub}     ;AND #$F800           // }
            ;SEC                  // dxTile=(((xb-xa)>>11)+1)&0x001F;
            ;SBC Move.dx.tile     //
            ;LSR A                //
            ;LSR A                //
            ;LSR A                //
            ;XBA                  //
            ;INC A                //
            ;AND #$001F           //
            ;STA Move.dx.tile     //
            ;
            ;# dyTile ==============
            ;LDA Move.y0          // ya=(y0)&0xF800;
            ;TAY                  //
            ;AND #$F800           //
            ;STA Move.dy.tile     //
            ;TYA                  // yb=(y0+yw-1)&0xF800;
            ;CLC                  //
            ;ADC Move.yw          //
            ;DEC A                //
            ;AND #$F800           //
            ;SEC                  // dyTile=(((yb-ya)>>11)+1)&0x001F;
            ;SBC Move.dy.tile     //
            ;LSR A                //
            ;LSR A                //
            ;LSR A                //
            ;XBA                  //
            ;INC A                //
            ;AND #$001F           //
            ;STA Move.dy.tile     //
            ;
            ;# First Tile ==========
            ;LDA #$FFFF           // lock=0xFFFF;
            ;STA Move.lock        //
            ;LDA Move.x0          // index=((dx>=?x0+xw:x0-1)&0xF800)>>11;
            ;LDX Move.dx          //
            ;BMI {+Minus}         //
            ;CLC                  //
            ;ADC Move.xw          //
            ;BRA {+Plus}          //
;{+Minus}   ;DEC A                //
;{+Plus}    ;AND #$F800           //
            ;LSR A                //
            ;LSR A                //
            ;LSR A                //
            ;XBA                  //
            ;STA Move.index       //
            ;LDA Move.y0          // index+=(((y0)&0xF800)>>11)*0x0020;
            ;AND #$F800           //
            ;XBA                  //
            ;ASL A                //
            ;ASL A                //
            ;CLC                  //
            ;ADC Move.index       //
            ;ASL A                // // Word indexing
            ;STA Move.index       // index*=2;
            ;
            ;# Iterate =============
;{-Column}  ;LDY Move.dy.tile     // for(:dxTile:dxTile--){ // Column
;{-Row}     ;TAX                  //     X=index;
            ;LDA level,X          //     for(Y=dyTile:Y:Y--){ // Row
            ;AND #$03FF           //         A=level[X]&0x03FF;
            ;CMP #TILE_solid      //         if(   A==TILE_solid
            ;BEQ {+Solid}         //
            ;CMP #TILE_mossUp     //             ||A==TILE_mossUp
            ;BEQ {+Solid}         //
            ;CMP #TILE_mossDown   //             ||A==TILE_mossDown
            ;BNE {+Air}           //         ){
;{+Solid}   ;LDA Move.lock        //             if(lock){
            ;BEQ {+Unlock}        //
            ;LDA Move.x0          //                 x1=x0;
            ;STA Move.x1          //                 dx=0;
            ;STZ Move.dx          //                 return;
            ;RTS                  //             }
;{+Unlock}  ;TXA                  //             A=(X*4&0x00F8)<<8;
            ;ASL A                //
            ;ASL A                //
            ;AND #$00F8           //
            ;XBA                  //
            ;LDX Move.dx          //             x1=A+(dx>=0?-xw:0x0800);
            ;BMI {+Left}          //
            ;SEC                  //
            ;SBC Move.xw          //
            ;BRA {+Right}         //
;{+Left}    ;CLC                  //
            ;ADC #$0800           //
;{+Right}   ;STA Move.x1          //
            ;LDA Move.dx          //             Move.stop|=dx<0?0x0004:0x0001;
            ;BMI {+Left}          //
            ;LDA #$0001           //
            ;BRA {+Right}         //
;{+Left}    ;LDA #$0004           //
;{+Right}   ;ORA Move.stop        //
            ;STA Move.stop        //             return;
            ;RTS                  //         }
;{+Air}     ;DEY                  //
            ;BEQ {+Break}         //
            ;TXA                  //         X=(X+0x0040)&0x07FF;
            ;CLC                  //
            ;ADC #$0040           //
            ;AND #$07FF           //
            ;BRL {-Row}           //     }
;{+Break}   ;DEC Move.dx.tile     //
            ;BEQ {+Break}         //
            ;LDA Move.index       //
            ;TAX                  //     X=index;
            ;LDY Move.dx          //     index=X&0x07C0|(X+(dx<0?-2:2))&0x003F;
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
            ;STZ Move.lock        //     lock=0x0000;
            ;BRL {-Column}        // }
;{+Break}   ;LDA Move.x0          // x1=x0+dx;
            ;CLC                  //
            ;ADC Move.dx          //
            ;STA Move.x1          //
            ;RTS                  // return;


            ;# ===============================================================//
            ;#Code w {Move.Level.Y}                                           //
            ;# ===============================================================//
            ;# Still ===============
            ;LDA Move.dy          // if(dy==0){
            ;BNE {+Move}          //
            ;LDA Move.y0          //     y1=y0;
            ;STA Move.y1          //
            ;STZ Move.dy          //     dy=0;
            ;RTS                  //     return;
;{+Move}    ;
            ;# dyTile ==============
            ;BMI {+Minus}         // }else if(dy>=0){
            ;LDA Move.y0          //     ya=(y0+yw)&0xF800;
            ;CLC                  //
            ;ADC Move.yw          //
            ;TAY                  //
            ;AND #$F800           //
            ;STA Move.dy.tile     //
            ;TYA                  //     yb=(y0+yw+dy-1)&0xF800;
            ;CLC                  //
            ;ADC Move.dy          //
            ;DEC A                //
            ;BRA {+Sub}           // }else if(dy<0){
;{+Minus}   ;LDA Move.y0          //     ya=(y0-1+dy+1)&0xF800;
            ;DEC A                //
            ;TAY                  //
            ;CLC                  //
            ;ADC Move.dy          //
            ;INC A                //
            ;AND #$F800           //
            ;STA Move.dy.tile     //
            ;TYA                  //     yb=(y0-1)&0xF800;
;{+Sub}     ;AND #$F800           // }
            ;SEC                  // dxTile=(((yb-ya)>>11)+1)&0x001F;
            ;SBC Move.dy.tile     //
            ;LSR A                //
            ;LSR A                //
            ;LSR A                //
            ;XBA                  //
            ;INC A                //
            ;AND #$001F           //
            ;STA Move.dy.tile     //
            ;
            ;# dxTile ==============
            ;LDA Move.x0          // xa=(x0)&0xF800;
            ;TAY                  //
            ;AND #$F800           //
            ;STA Move.dx.tile     //
            ;TYA                  // xb=(x0+xw-1)&0xF800;
            ;CLC                  //
            ;ADC Move.xw          //
            ;DEC A                //
            ;AND #$F800           //
            ;SEC                  // dxTile=(((xb-xa)>>11)+1)&0x001F;
            ;SBC Move.dx.tile     //
            ;LSR A                //
            ;LSR A                //
            ;LSR A                //
            ;XBA                  //
            ;INC A                //
            ;AND #$001F           //
            ;STA Move.dx.tile     //
            ;
            ;# First Tile ==========
            ;LDA #$FFFF           // lock=0xFFFF;
            ;STA Move.lock        //
            ;LDA Move.x0          // index=(x0&0xF800)>>11;
            ;AND #$F800           //
            ;LSR A                //
            ;LSR A                //
            ;LSR A                //
            ;XBA                  //
            ;STA Move.index       //
            ;LDA Move.y0          // index+=((dy>=0?y0+yw:y0-1)&0xF800)>>6;
            ;LDX Move.dy          //
            ;BMI {+Minus}         //
            ;CLC                  //
            ;ADC Move.yw          //
            ;BRA {+Plus}          //
;{+Minus}   ;DEC A                //
;{+Plus}    ;AND #$F800           //
            ;XBA                  //
            ;ASL A                //
            ;ASL A                //
            ;CLC                  //
            ;ADC Move.index       //
            ;ASL A                // // Word indexing
            ;STA Move.index       // index*=2;
            ;
            ;# Iterate =============
;{-Row}     ;LDY Move.dx.tile     // for(:dyTile:dyTile--){ // Column
;{-Column}  ;TAX                  //     X=index;
            ;LDA level,X          //     for(Y=dxTile:Y:Y--){ // Row
            ;AND #$03FF           //         A=level[X]&0x03FF;
            ;CMP #TILE_solid      //         if(   A==TILE_solid
            ;BEQ {+Solid}         //
            ;CMP #TILE_mossUp     //             ||A==TILE_mossUp
            ;BEQ {+Solid}         //
            ;CMP #TILE_mossDown   //             ||A==TILE_mossDown
            ;BNE {+Air}           //         ){
;{+Solid}   ;LDA Move.lock        //             if(lock){
            ;BEQ {+Unlock}        //
            ;LDA Move.y0          //                 y1=y0;
            ;STA Move.y1          //                 yx=0;
            ;STZ Move.dy          //                 return;
            ;RTS                  //             }
;{+Unlock}  ;TXA                  //             A=(X&0x07C0)<<5;
            ;AND #$07C0           //
            ;LSR A                //
            ;LSR A                //
            ;LSR A                //
            ;XBA                  //
            ;LDX Move.dy          //             y1=A+(dy>=0?-yw:0x0800);
            ;BMI {+Up}            //
            ;SEC                  //
            ;SBC Move.yw          //
            ;BRA {+Down}          //
;{+Up}      ;CLC                  //
            ;ADC #$0800           //
;{+Down}    ;STA Move.y1          //
            ;LDA Move.dy          //             Move.stop|=dy>=0?0x0002:0x0008;
            ;BMI {+Up}            //
            ;LDA #$0002           //
            ;BRA {+Down}          //
;{+Up}      ;LDA #$0008           //
;{+Down}    ;ORA Move.stop        //
            ;STA Move.stop        //             return;
            ;RTS                  //         }
;{+Air}     ;DEY                  //
            ;BEQ {+Break}         //
            ;TXA                  //         X=X&0x07C0|(X+0x0002)&0x003F;
            ;CLC                  //
            ;INC A                //
            ;INC A                //
            ;AND #$003F           //
            ;STA Move.temp        //
            ;TXA                  //
            ;AND #$07C0           //
            ;ORA Move.temp        //
            ;BRL {-Column}        //     }
;{+Break}   ;DEC Move.dy.tile     //
            ;BEQ {+Break}         //
            ;LDA Move.index       //     index=(index+(dy>=0?0x40:-0x40))&0x7FF;
            ;LDY Move.dy          //
            ;BMI {+Dec}           //
            ;CLC                  //
            ;ADC #$0040           //
            ;BRA {+Inc}           //
;{+Dec}     ;SEC A                //
            ;SBC #$0040           //
;{+Inc}     ;STA Move.index       //
            ;STZ Move.lock        //     lock=0x0000;
            ;BRL {-Row}           // }
;{+Break}   ;LDA Move.y0          // y1=y0+dy;
            ;CLC                  //
            ;ADC Move.dy          //
            ;STA Move.y1          //
            ;RTS                  // return;


            ;# ===============================================================//
            ;#                                                                //
            ;# ===============================================================//

