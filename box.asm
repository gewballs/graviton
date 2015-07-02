            ;#Name $0003 boxFallSpeed          //  !!! DEBUG !!! Placeholder
            ;#Name $0000 box.hit.x
            ;#Name $0000 box.hit.y
            ;#Name $0010 box.hit.dx
            ;#Name $0010 box.hit.dy

            ;# ===============================================================//
            ;#Code w {Box}                                                    //
            ;# ===============================================================//
            ;PHP                  // Php();
            ;REP #$30             // Rep(0x30);
            ;
            ;LDX #$0000
            ;
            ;# Dx ==================
;{-Loop}    ;LDA #$0000           //
            ;STA box.vx,X         //
            ;
            ;# Dy ==================
            ;LDA #boxFallSpeed    //
            ;LDY gravity1         //
            ;BPL {+Dy}            //
            ;EOR #$FFFF           //
            ;INC A                //
;{+Dy}      ;STA box.vy,X         //
            ;
            ;# Move ================
            ;JSR Box.Move         // Box.Move();
            ;
            ;INX
            ;INX
            ;CPX box.n
            ;BNE {-Loop}
            ;
            ;PLP                  // Plp();
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Box.Move}                                               //
            ;# ===============================================================//
            ;LDA box.x,X          // Move.x0=(x0+hit.x)%0x0100;
            ;CLC                  //
            ;ADC #box.hit.x       //
            ;AND #$00FF           //
            ;STA Move.x0          //
            ;LDA box.y,X          // Move.y0=(y0+hit.y)%0x0100;
            ;CLC                  //
            ;ADC #box.hit.y       //
            ;AND #$00FF           //
            ;STA Move.y0          //
            ;LDA box.vx,X         // Move.dx=vx;
            ;STA Move.dx          //
            ;LDA box.vy,X         // Move.dy=vy;
            ;STA Move.dy          //
            ;LDA #box.hit.dx      // Move.hit.width=hit.width;
            ;STA Move.width       //
            ;LDA #box.hit.dy      // Move.hit.height=hit.height;
            ;STA Move.height      //
            ;PHX
            ;JSR Move             // Move();
            ;PLX
            ;
            ;LDA Move.x1          // x1=(Move.x1-hit.x)%0x0100;
            ;SEC                  //
            ;SBC #box.hit.x       //
            ;AND #$00FF           //
            ;STA box.x,X          //
            ;LDA Move.y1          // y1=(Move.y1-hit.y)%0x0100;
            ;SEC                  //
            ;SBC #box.hit.y       //
            ;AND #$00FF           //
            ;STA box.y,X          //
            ;
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#                                                                //
            ;# ===============================================================//

