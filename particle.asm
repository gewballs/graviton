
            ;# ===============================================================//
            ;#Code w {Particle}                                               //
            ;# ===============================================================//
            ;PHP                 // Php();
            ;REP #$30            // Rep(P_m|P_x);
            ;
            ;LDX #$0000          // for(X=0:X<particle.n:X+=2){
;{-Loop}    ;LDA particle.on,X   //     if(particle.on[X]) particle.code[X]();
            ;BEQ {+Next}         //
            ;JSR (particle.code,X)
;{+Next}    ;INX                 //
            ;INX                 //
            ;CPX particle.n      //
            ;BCC {-Loop}         // }
            ;
            ;PLP                 // Plp();
            ;RTS                 // return;
            
			;# ===============================================================//
            ;#Code w {Particle.Next}                                          //
            ;# ===============================================================//
			;PHP                 // Php();
			;REP #$30            // Rep(P_m|P_x);
			;
			;LDX particle.last   // X=last;
;{-Loop}    ;INX                 //
			;INX                 //
			;CPX particle.n      //
			;BCS {+Wrap}         //
            ;LDA particle.on,X   //
			;BEQ {+Found}        //
			;BRA {-Loop}         //
;{+Wrap}	;LDX #$0000          //
;{-Loop}    ;CPX particle.n      //
			;BCS {+Fail}         //
			;LDA particle.on,X   //
			;BEQ {+Found}        //
			;INX                 //
			;INX                 //
			;BRA {-Loop}         //
;{+Found}   ;STX particle.last   //
            ;LDA #$FFFF          //
			;STA particle.on,X   //
			;TXA
			;BRA {+Done}         //
;{+Fail}    ;LDA #$FFFF          //
			;
;{+Done}    ;PLP                 // Plp();
			;RTS                 // return;

            ;# ===============================================================//
            ;#Code w {Particle.Dust}                                          //
            ;# ===============================================================//
            ;# Delete =============
            ;DEC particle.timer,X// if(!--particle.timer[X]) particle.on[X]=0;
            ;BEQ {+Process}      //
            ;STZ particle.on,X   //
;{+Process} ;RTS                 // return;

            ;# ===============================================================//
            ;#Code w {Particle.Gibs}                                          //
            ;# ===============================================================//
            ;# Delete =============
            ;DEC particle.timer,X// if(!--particle.timer[X]){
            ;BNE {+Process}      //     particle.on[X]=0;
            ;STZ particle.on,X   //     return;
            ;RTS                 // }
;{+Process} ;
            ;# Blink ==============
            ;LDA particle.timer,X
            ;CMP #$0010          // if(particle.timer[X]<0x0000){
            ;BCS {+Show}         //
			;BIT #$0001
			;BNE {+Odd}
			;TXA
			;BIT #$0002
			;BNE {+GroupB}
			;LDA #$FFFF
			;BRA {+Set}
;{+GroupB}  ;LDA #$0000
			;BRA {+Set}
;{+Odd}     ;TXA
            ;BIT #$0002
			;BNE {+GroupB}
			;LDA #$0000
			;BRA {+Set}
;{+GroupB}  ;LDA #$FFFF
;{+Set}     ;STA particle.draw,X
;{+Show}    ;
            ;# Dx =================
            ;CLC                 // particle.x[X]+=particle.xv[X];
            ;LDA particle.xv,X   //
            ;ADC particle.x,X    //
            ;STA particle.x,X    //
            ;
            ;# Dy =================
            ;CLC                 // particle.y[X]+=particle.yv[X];
            ;LDA particle.yv,X   //
            ;ADC particle.y,X    //
            ;STA particle.y,X    //
            ;
            ;# Dyv ================
            ;LDA particle.yv,X   // particle.yv[X]+=gravity>=0?0x0003:0xFFFD;
            ;LDY gravity1        //
            ;BMI {+Minus}        //
			;CLC                 //
            ;ADC #$0040          //
            ;BRA {+Plus}         //
;{+Minus}   ;SEC                 //
            ;SBC #$0040          //
;{+Plus}    ;STA particle.yv,X   //
            ;
;{+Done}    ;RTS

			
            ;#Data w Spawn.Gibs.scripts{
			    gibs.arm0.r.script
			    gibs.arm0.l.script
			    gibs.arm1.r.script
			    gibs.arm1.l.script
			    gibs.foot.r.script
			    gibs.foot.l.script
			    gibs.head.r.script
			    gibs.head.l.script
			    gibs.bone.script
			    gibs.bone.script
			    gibs.bone.script
			    gibs.bone.script
			    gibs.gore.r.script
			    gibs.gore.ri.script
			    gibs.gore.l.script
			    gibs.gore.li.script
			}

            ;# ===============================================================//
            ;#Code w {Spawn.Gibs}                                             //
            ;# ===============================================================//
			;PHP
			;REP #$30
			;
			;JSR Particle.Next
			;CMP #$FFFF
			;BEQ {+Overflow}
			;TAX
			;
			;LDA Spawn.x
			;STA particle.x,X
			;LDA Spawn.y
			;STA particle.y,X
			;
			;JSL Rng
			;AND #$03FF
			;BIT #$0200
			;BEQ {+Sign}
			;ORA #$FE00
;{+Sign}    ;STA particle.xv,X
			;
			;JSL Rng
			;AND #$03FF
			;BIT #$0200
			;BEQ {+Sign}
			;ORA #$FE00
;{+Sign}    ;LDY gravity1
            ;BMI {+Minus}
			;SEC
			;SBC #$0200
			;BRA {+Plus}
;{+Minus}   ;CLC
            ;ADC #$0400
;{+Plus}	;STA particle.yv,X
			;
			;LDA #$FFFF
			;STA particle.draw,X
			;
			;LDA #$0020
			;STA particle.timer,X
			;
			;LDA #Particle.Gibs
			;STA particle.code,X
			;
			;LDA Spawn.type
			;ASL A
			;AND #$001F
			;TAX
			;LDA Spawn.Gibs.scripts,X
			;STA particle.script,X
			;STZ particle.frame,X
			;STZ particle.delay,X
			;
;{+Overflow};PLP
			;RTS
            
			;# ===============================================================//
            ;#                                                                //
            ;#                                                                //
            ;#                                                                //
            ;# ===============================================================//

