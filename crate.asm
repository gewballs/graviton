            ;#Name $0300 crateFallSpeed          //  !!! DEBUG !!! Placeholder
            ;#Name $0000 crate.hit.x
            ;#Name $0000 crate.hit.y
            ;#Name $1000 crate.hit.dx
            ;#Name $1000 crate.hit.dy

            ;# ===============================================================//
            ;#Code w {Crate}                                                  //
            ;# ===============================================================//
            ;PHP                  // Php();
            ;REP #$30             // Rep(0x30);
			;
            ;LDX #$0000
            ;
            ;# Dx ==================
;{-Loop}    ;LDA #$0000           //
            ;STA crate.vx,X       //
            ;
            ;# Dy ==================
            ;LDA #crateFallSpeed  //
            ;LDY gravity1         //
            ;BPL {+Dy}            //
            ;EOR #$FFFF           //
            ;INC A                //
;{+Dy}      ;STA crate.vy,X       //
            ;
            ;# Move ================
            ;JSR Crate.Move       // Crate.Move();
            ;
            ;INX
            ;INX
            ;CPX crate.n
            ;BNE {-Loop}
            ;
            ;PLP                  // Plp();
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Crate.Move}                                             //
            ;# ===============================================================//
            ;LDA crate.x,X        // Move.x0=x0+hit.x;
            ;CLC                  //
            ;ADC #crate.hit.x     //
            ;STA Move.x0          //
            ;LDA crate.y,X        // Move.y0=y0+hit.y;
            ;CLC                  //
            ;ADC #crate.hit.y     //
            ;STA Move.y0          //
            ;LDA crate.vx,X       // Move.dx=vx;
            ;STA Move.dx          //
            ;LDA crate.vy,X       // Move.dy=vy;
            ;STA Move.dy          //
            ;LDA #crate.hit.dx    // Move.xw=hit.width;
            ;STA Move.xw          //
            ;LDA #crate.hit.dy    // Move.yw=hit.height;
            ;STA Move.yw          //
            ;PHX
            ;JSR Move.Level       // Move();
            ;PLX
            ;
            ;LDA Move.x1          // x1=Move.x1-hit.x;
            ;SEC                  //
            ;SBC #crate.hit.x     //
            ;STA crate.x,X        //
            ;LDA Move.y1          // y1=Move.y1-hit.y;
            ;SEC                  //
            ;SBC #crate.hit.y     //
            ;STA crate.y,X        //
            ;
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#                                                                //
            ;# ===============================================================//

