            ;#Name $0010 JOY_r
            ;#Name $0020 JOY_l
            ;#Name $0040 JOY_x
            ;#Name $0080 JOY_a
            ;#Name $0100 JOY_right
            ;#Name $0200 JOY_left
            ;#Name $0400 JOY_down
            ;#Name $0800 JOY_up
            ;#Name $1000 JOY_start
            ;#Name $2000 JOY_select
            ;#Name $4000 JOY_y
            ;#Name $8000 JOY_b
            
            ;#Name $8000 JOY_jump
            ;#Name $4000 JOY_attack

            ;#Name $0300 fallSpeed               //  !!! DEBUG !!! Placeholder
            ;#Name $FD00 jumpSpeed               //  !!! DEBUG !!! Placeholder
			;#Name $0100 walkSpeed
			;#Name $0200 runSpeed

            ;# ===============================================================//
            ;#Code w {Vrtan}                                                  //
            ;# ===============================================================//
            ;PHP                  // Php();
            ;REP #$30             // Rep(0x30);
            ;
            ;# Common Tasks ========
            ;
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
            ;# Hitbox ==============
            ;LDA joy1.edge        // if(joy1.edge&0x0020){
            ;AND #$0020           //
            ;BEQ {+Same}          //
            ;LDA vrtan.hit.show   //
            ;EOR #$FFFF           //
            ;STA vrtan.hit.show   // }
;{+Same}    ;
            ;PLP                  // Plp();
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Vrtan.Idle}                                             //
            ;# ===============================================================//
            ;LDA joy1
			;BIT #JOY_x
			;BEQ {+Idle}
			;LDA #Vrtan.Crush  
			;STA vrtan.state1
			;LDA vrtan.x0
			;STA vrtan.x1
			;LDA vrtan.y0
			;STA vrtan.y1
			;RTS
			;
            ;# Dx ==================
            ;
;{+Idle}    ;LDA joy1.edge
            ;BIT #$0300
            ;BNE {+Tap}
            ;STZ p0.run.flag
            ;LDA p0.run.timer
            ;BEQ {+Cool}
            ;DEC p0.run.timer
            ;BRA {+Cool}
;{+Tap}     ;LDA #$000C
            ;LDX p0.run.timer
            ;STA p0.run.timer
            ;BNE {+Run}
            ;LDA #$0000
            ;BRA {+Walk}
;{+Run}     ;LDA #$FFFF
;{+Walk}    ;STA p0.run.flag
;{+Cool}    ;
            ;LDA joy1             // if(joy1&JOY_right){
            ;BIT #JOY_right       //
            ;BEQ {+Left}          //
            ;LDA p0.run.flag      //   vx=p0.run.flag?2:1;
            ;BNE {+Fast}          //
            ;LDA #walkSpeed       //
            ;BRA {+Dx}            //
;{+Fast}    ;LDA #runSpeed        //
            ;BRA {+Dx}            // }else if(joy1&JOY_left){
;{+Left}    ;BIT #JOY_left        //
            ;BEQ {+Neutral}       //
            ;LDA p0.run.flag      //   vx=p0.run.flag?-2:-1;
            ;BNE {+Fast}          //
            ;LDA #walkSpeed       //
			;EOR #$FFFF
			;INC A
            ;BRA {+Dx}            //
;{+Fast}    ;LDA #runSpeed        //
			;EOR #$FFFF
			;INC A
            ;BRA {+Dx}            // }else{
;{+Neutral} ;LDA #$0000           //   vx=0;
;{+Dx}      ;STA vrtan.vx         // }
            ;
            ;# Dy ==================
            ;LDA joy1             // vy=joy1&JOY_jump?-3:2;
            ;BIT #JOY_jump        //
            ;BEQ {+Fall}          //
            ;LDA #jumpSpeed       //
            ;LDX gravity1
            ;BPL {+Dy}
            ;EOR #$FFFF
            ;INC A
            ;BRA {+Dy}            //
;{+Fall}    ;LDA #fallSpeed       //
            ;LDX gravity1
            ;BPL {+Dy}
            ;EOR #$FFFF
            ;INC A
;{+Dy}      ;STA vrtan.vy         //
            ;
            ;# Move ================
            ;JSR Vrtan.Move       // VrtanMove();
            ;LDX gravity1
            ;BMI {+Anti}
            ;LDA Move.y1          // if(y1<y0){
            ;CMP Move.y0          //
            ;BCS {+Fall}          //
            ;BRA {+Jump}
;{+Anti}    ;LDA Move.y0          // if(y1<y0){
            ;CMP Move.y1          //
            ;BCS {+Fall}          //
;{+Jump}    ;LDA #Vrtan.Jump      //   state1=VrtanJump;
            ;STA vrtan.state1     //
            ;LDA #$0018           //   jump=0x0018;
            ;STA vrtan.jump       //
            ;BRA {+Break}         //
;{+Fall}    ;BEQ {+Punch}         // }else if(y1>y0){
            ;LDA #Vrtan.Fall      //   state1=VrtanFall;
            ;STA vrtan.state1     //
            ;BRA {+Break}         // }else if(x1!=x0){
;{+Punch}   ;LDA joy1.edge        //
            ;BIT #JOY_attack      //
            ;BEQ {+Walk}          //
            ;LDA #$000A           //
            ;STA p0.punch.timer   //
            ;LDA #Vrtan.Punch     //
            ;STA vrtan.state1     //
            ;BRA {+Break}         //
;{+Walk}    ;LDA Move.x1          //
            ;CMP Move.x0          //
            ;BEQ {+Idle}          //
            ;LDA #Vrtan.Walk      //   state1=VrtanWalk;
            ;STA vrtan.state1     //
            ;LDA #$000C           //
            ;STA p0.run.timer     //
            ;BRA {+Break}         // }else{
;{+Idle}    ;LDA #Vrtan.Idle      //   state1=VrtanIdle;
            ;STA vrtan.state1     // }
;{+Break}   ;
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Vrtan.Walk}                                             //
            ;# ===============================================================//
            ;# Dx ==================
            ;LDA joy1             // if(joy1&JOY_right){
            ;BIT #JOY_right       //
            ;BEQ {+Left}          //
            ;LDA p0.run.flag      //   vx=p0.run.flag?2:1;
            ;BNE {+Fast}          //
            ;LDA #walkSpeed       //
            ;BRA {+Dx}            //
;{+Fast}    ;LDA #runSpeed        //
            ;BRA {+Dx}            // }else if(joy1&JOY_left){
;{+Left}    ;BIT #JOY_left        //
            ;BEQ {+Neutral}       //
            ;LDA p0.run.flag      //   vx=p0.run.flag?-2:-1;
            ;BNE {+Fast}          //
            ;LDA #walkSpeed       //
			;EOR #$FFFF
			;INC A
            ;BRA {+Dx}            //
;{+Fast}    ;LDA #runSpeed        //
			;EOR #$FFFF
			;INC A
            ;BRA {+Dx}            // }else{
;{+Neutral} ;LDA #$0000           //   vx=0;
;{+Dx}      ;STA vrtan.vx         // }
            ;
            ;# Dy ==================
            ;LDA joy1             // vy=joy1&JOY_jump?-3:2;
            ;BIT #JOY_jump        //
            ;BEQ {+Fall}          //
            ;LDA #jumpSpeed       //
            ;LDX gravity1
            ;BPL {+Dy}
            ;EOR #$FFFF
            ;INC A
            ;BRA {+Dy}            //
;{+Fall}    ;LDA #fallSpeed       //
            ;LDX gravity1
            ;BPL {+Dy}
            ;EOR #$FFFF
            ;INC A
;{+Dy}      ;STA vrtan.vy         //
            ;
            ;# Move ================
            ;JSR Vrtan.Move       // VrtanMove();
            ;LDX gravity1
            ;BMI {+Anti}
            ;LDA Move.y1          // if(y1<y0){
            ;CMP Move.y0          //
            ;BCS {+Fall}          //
            ;BRA {+Jump}
;{+Anti}    ;LDA Move.y0
            ;CMP Move.y1
            ;BCS {+Fall}
;{+Jump}    ;LDA #Vrtan.Jump      //   state1=VrtanJump;
            ;STA vrtan.state1     //
            ;LDA joy1             //   jump=joy1&0x40?0x0028:0x0020;
            ;BIT #$4000           //
            ;BNE {+Fast}          //
            ;LDA #$0020           //
            ;BRA {+Slow}          //
;{+Fast}    ;LDA #$0028           //
;{+Slow}    ;STA vrtan.jump       //
            ;BRA {+Break}         //
;{+Fall}    ;BEQ {+Punch}         // }else if(y1>y0){
            ;LDA #Vrtan.Fall      //   state1=VrtanFall;
            ;STA vrtan.state1     //
            ;BRA {+Break}         //
;{+Punch}   ;LDA joy1.edge        //
            ;BIT #JOY_attack      //
            ;BEQ {+Walk}          //
            ;LDA #$000A           //
            ;STA p0.punch.timer   //
            ;LDA #Vrtan.Punch     //
            ;STA vrtan.state1     //
            ;BRA {+Break}         //
;{+Walk}    ;LDA Move.x1          // }else if(x1!=x0){
            ;CMP Move.x0          //
            ;BEQ {+Idle}          //
            ;LDA #Vrtan.Walk      //   state1=VrtanWalk;
            ;STA vrtan.state1     //
            ;BRA {+Break}         // }else{
;{+Idle}    ;LDA #Vrtan.Idle      //   state1=VrtanIdle;
            ;STA vrtan.state1     // }
;{+Break}   ;
            ;LDA p0.run.timer
            ;BEQ {+Zero}
            ;DEC p0.run.timer
;{+Zero}    ;
            ;LDA vrtan.left1
            ;CMP vrtan.left0
            ;BEQ {+}
            ;STZ p0.run.flag
            ;STZ p0.run.timer
;{+}        ;
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Vrtan.Jump}                                             //
            ;# ===============================================================//
            ;LDA joy
            ;BIT #$0300
            ;BNE {+}
            ;STZ p0.run.flag
;{+}        ;
            ;# Dy ==================
            ;LDA joy1             // vy=joy1&JOY_jump?-3:2;
            ;BIT #JOY_jump        //
            ;BEQ {+Fall}          //
            ;LDA vrtan.jump       //
            ;BMI {+Fall}          //
            ;DEC vrtan.jump       //   jump--;
            ;LDA #jumpSpeed       //
            ;LDX gravity1
            ;BPL {+Dy}
            ;EOR #$FFFF
            ;INC A
            ;BRA {+Dy}            //
;{+Fall}    ;LDA #$0000
;{+Dy}      ;STA vrtan.vy         //
            ;
            ;# Dx ==================
            ;LDA joy1             // if(joy1&JOY_right){
            ;BIT #JOY_right       //
            ;BEQ {+Left}          //
            ;LDA p0.run.flag      //   vx=p0.run.flag?2:1;
            ;BNE {+Fast}          //
            ;LDA #walkSpeed       //
            ;BRA {+Dx}            //
;{+Fast}    ;LDA #runSpeed        //
            ;BRA {+Dx}            // }else if(joy1&JOY_left){
;{+Left}    ;BIT #JOY_left        //
            ;BEQ {+Neutral}       //
            ;LDA p0.run.flag      //   vx=p0.run.flag?-2:-1;
            ;BNE {+Fast}          //
            ;LDA #walkSpeed       //
			;EOR #$FFFF
			;INC A
            ;BRA {+Dx}            //
;{+Fast}    ;LDA #runSpeed        //
			;EOR #$FFFF
			;INC A
            ;BRA {+Dx}            // }else{
;{+Neutral} ;LDA #$0000           //   vx=0;
;{+Dx}      ;STA vrtan.vx         // }
            ;
            ;# Move ================
            ;JSR Vrtan.Move       // VrtanMove();
            ;LDX gravity1
            ;BMI {+Anti}
            ;LDA Move.y1          // if(y1>=y0){
            ;CMP Move.y0          //
            ;BCC {+Jump}          //
            ;BRA {+Fall}
;{+Anti}    ;LDA Move.y0          //
            ;CMP Move.y1          //
            ;BCC {+Jump}          //
;{+Fall}    ;LDA #Vrtan.Fall      //   state1=VrtanFall;
            ;STA vrtan.state1     //
            ;BRA {+Break}         // }else{
;{+Jump}    ;LDA #Vrtan.Jump      //   state1=VrtanJump;
            ;STA vrtan.state1     // }
;{+Break}   ;
            ;LDA p0.run.timer
            ;BEQ {+Zero}
            ;DEC p0.run.timer
;{+Zero}    ;
            ;LDA vrtan.left1
            ;CMP vrtan.left0
            ;BEQ {+}
            ;STZ p0.run.flag
            ;STZ p0.run.timer
;{+}        ;
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Vrtan.Fall}                                             //
            ;# ===============================================================//
            ;LDA joy
            ;BIT #$0300
            ;BNE {+}
            ;STZ p0.run.flag
;{+}        ;
            ;# Dy ==================
            ;LDA #fallSpeed      // vy=3;
            ;LDX gravity1
            ;BPL {+Dy}
            ;EOR #$FFFF
            ;INC A
;{+Dy}      ;STA vrtan.vy         //
            ;
            ;# Dx ==================
            ;LDA joy1             // if(joy1&JOY_right){
            ;BIT #JOY_right       //
            ;BEQ {+Left}          //
            ;LDA p0.run.flag      //   vx=p0.run.flag?2:1;
            ;BNE {+Fast}          //
            ;LDA #walkSpeed       //
            ;BRA {+Dx}            //
;{+Fast}    ;LDA #runSpeed        //
            ;BRA {+Dx}            // }else if(joy1&JOY_left){
;{+Left}    ;BIT #JOY_left        //
            ;BEQ {+Neutral}       //
            ;LDA p0.run.flag      //   vx=p0.run.flag?-2:-1;
            ;BNE {+Fast}          //
            ;LDA #walkSpeed       //
			;EOR #$FFFF
			;INC A
            ;BRA {+Dx}            //
;{+Fast}    ;LDA #runSpeed        //
            ;EOR #$FFFF
			;INC A
            ;BRA {+Dx}            // }else{
;{+Neutral} ;LDA #$0000           //   vx=0;
;{+Dx}      ;STA vrtan.vx         // }
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
;{+Walk}    ;LDA #Vrtan.Walk      //     state=VrtanWalk;
            ;STA vrtan.state1     //   }
            ;BRA {+Break}         // }else{
;{+Fall}    ;LDA #Vrtan.Fall      //   state1=VrtanFall;
            ;STA vrtan.state1     // }
;{+Break}   ;
            ;LDA p0.run.timer
            ;BEQ {+Zero}
            ;DEC p0.run.timer
;{+Zero}    ;
            ;LDA vrtan.left1
            ;CMP vrtan.left0
            ;BEQ {+}
            ;STZ p0.run.flag
            ;STZ p0.run.timer
;{+}        ;
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Vrtan.Punch}
            ;# ===============================================================//
            ;# Dx ==================
            ;LDA joy1             // if(joy1&JOY_right){
            ;BIT #JOY_right       //
            ;BEQ {+Left}          //
            ;LDA p0.run.flag      //   vx=p0.run.flag?2:1;
            ;BNE {+Fast}          //
            ;LDA #walkSpeed       //
            ;BRA {+Dx}            //
;{+Fast}    ;LDA #runSpeed        //
            ;BRA {+Dx}            // }else if(joy1&JOY_left){
;{+Left}    ;BIT #JOY_left        //
            ;BEQ {+Neutral}       //
            ;LDA p0.run.flag      //   vx=p0.run.flag?-2:-1;
            ;BNE {+Fast}          //
            ;LDA #walkSpeed       //
			;EOR #$FFFF
			;INC A
            ;BRA {+Dx}            //
;{+Fast}    ;LDA #runSpeed        //
			;EOR #$FFFF
			;INC A
            ;BRA {+Dx}            // }else{
;{+Neutral} ;LDA #$0000           //   vx=0;
;{+Dx}      ;STA vrtan.vx         // }
            ;
            ;# Dy ==================
            ;LDA joy1             // vy=joy1&JOY_jump?-3:2;
            ;BIT #JOY_jump        //
            ;BEQ {+Fall}          //
            ;LDA #jumpSpeed       //
            ;LDX gravity1
            ;BPL {+Dy}
            ;EOR #$FFFF
            ;INC A
            ;BRA {+Dy}            //
;{+Fall}    ;LDA #fallSpeed       //
            ;LDX gravity1
            ;BPL {+Dy}
            ;EOR #$FFFF
            ;INC A
;{+Dy}      ;STA vrtan.vy         //
            ;
            ;# Move ================
            ;JSR Vrtan.Move       // VrtanMove();
            ;LDX gravity1
            ;BMI {+Anti}
            ;LDA Move.y1          // if(y1<y0){
            ;CMP Move.y0          //
            ;BCS {+Fall}          //
            ;BRA {+Upper}         //
;{+Anti}    ;LDA Move.y0
            ;CMP Move.y1
            ;BCS {+Fall}
;{+Upper}   ;LDA #Vrtan.Uppercut  //   state1=VrtanUppercut;
            ;STA vrtan.state1     //
            ;LDA joy1             //   jump=joy1&JOY_a?0x0028:0x0020;
            ;BIT #JOY_a           //
            ;BNE {+Fast}          //
            ;LDA #$0020           //
            ;BRA {+Slow}          //
;{+Fast}    ;LDA #$0028           //
;{+Slow}    ;STA vrtan.jump       //
            ;BRA {+Break}         //
;{+Fall}    ;BEQ {+Punch}         // }else if(y1>y0){
            ;LDA #Vrtan.Fall      //   state1=VrtanFall;
            ;STA vrtan.state1     //
            ;BRA {+Break}         //
;{+Punch}   ;LDA p0.punch.timer   //
            ;BMI {+Walk}          //
            ;DEC A                //
            ;STA p0.punch.timer   //
            ;LDA #Vrtan.Punch     //
            ;STA vrtan.state1     //
            ;BRA {+Break}         //
;{+Walk}    ;LDA Move.x1          // }else if(x1!=x0){
            ;CMP Move.x0          //
            ;BEQ {+Idle}          //
            ;LDA #Vrtan.Walk      //   state1=VrtanWalk;
            ;STA vrtan.state1     //
            ;BRA {+Break}         // }else{
;{+Idle}    ;LDA #Vrtan.Idle      //   state1=VrtanIdle;
            ;STA vrtan.state1     // }
;{+Break}   ;
            ;LDA p0.run.timer
            ;BEQ {+Zero}
            ;DEC p0.run.timer
;{+Zero}    ;
            ;LDA vrtan.left1
            ;CMP vrtan.left0
            ;BEQ {+}
            ;STZ p0.run.flag
            ;STZ p0.run.timer
;{+}        ;
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Vrtan.Uppercut}                                         //
            ;# ===============================================================//
            ;# Dy ==================
            ;LDA joy1             // if(joy1&JOY_jump&&jump<0){
            ;BIT #JOY_jump        //
            ;BEQ {+Fall}          //
            ;LDA vrtan.jump       //
            ;BMI {+Fall}          //
            ;DEC vrtan.jump       //   jump--;
            ;LDA #jumpSpeed       //   vy=-3;
            ;LDX gravity1
            ;BPL {+Dy}
            ;EOR #$FFFF
            ;INC A
            ;BRA {+Dy}            // }else{
;{+Fall}    ;LDA #$0000           //   vy=0;
;{+Dy}      ;STA vrtan.vy         // }
            ;
            ;# Dx ==================
            ;LDA joy1             // if(joy1&JOY_right){
            ;BIT #JOY_right       //
            ;BEQ {+Left}          //
            ;LDA p0.run.flag      //   vx=p0.run.flag?2:1;
            ;BNE {+Fast}          //
            ;LDA #walkSpeed       //
            ;BRA {+Dx}            //
;{+Fast}    ;LDA #runSpeed        //
            ;BRA {+Dx}            // }else if(joy1&JOY_left){
;{+Left}    ;BIT #JOY_left        //
            ;BEQ {+Neutral}       //
            ;LDA p0.run.flag      //   vx=p0.run.flag?-2:-1;
            ;BNE {+Fast}          //
            ;LDA #walkSpeed       //
			;EOR #$FFFF
			;INC A
            ;BRA {+Dx}            //
;{+Fast}    ;LDA #runSpeed        //
			;EOR #$FFFF
			;INC A
            ;BRA {+Dx}            // }else{
;{+Neutral} ;LDA #$0000           //   vx=0;
;{+Dx}      ;STA vrtan.vx         // }
            ;
            ;# Move ================
            ;JSR Vrtan.Move       // VrtanMove();
            ;LDX gravity1
            ;BMI {+Anti}
            ;LDA Move.y1          // if(y1>=y0){
            ;CMP Move.y0          //
            ;BCC {+Jump}          //
            ;BRA {+Fall}
;{+Anti}    ;LDA Move.y0
            ;CMP Move.y1
            ;BCC {+Jump}
;{+Fall}    ;STZ p0.run.flag      //
            ;STZ p0.run.timer
            ;LDA #Vrtan.Fall      //   state1=VrtanFall;
            ;STA vrtan.state1     //
            ;BRA {+Break}         // }else{
;{+Jump}    ;LDA #Vrtan.Uppercut  //   state1=VrtanJump;
            ;STA vrtan.state1     // }
;{+Break}   ;
            ;LDA p0.run.timer
            ;BEQ {+Zero}
            ;DEC p0.run.timer
;{+Zero}    ;
            ;LDA vrtan.left1
            ;CMP vrtan.left0
            ;BEQ {+}
            ;STZ p0.run.flag
            ;STZ p0.run.timer
;{+}        ;
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Vrtan.Crush}                                            //
            ;# ===============================================================//
			;STZ p0.run.flag
			;STZ p0.run.timer
			;STZ p0.timer
			;
			;LDA #Vrtan.Crushing
			;STA vrtan.state1
			;JMP Vrtan.Crushing
            
            ;# ===============================================================//
            ;#Code w {Vrtan.Crushing}                                         //
            ;# ===============================================================//
			;LDA p0.timer
			;CMP #$0018
			;BCC {+Crush}
            ;LDA #Vrtan.Respawn
			;STA vrtan.state1
			;RTS
;{+Crush}   ;CMP #$000C
            ;BNE {+NoGibs}
			;
			;LDY #$0000
			;
;{-Loop}    ;JSL Rng
            ;AND #$000F
			;STA Spawn.type
			;LDA vrtan.hit.width
			;LSR A
			;CLC
			;ADC vrtan.hit.x
			;ADC vrtan.x0
			;SEC
			;SBC #$0400
			;STA Spawn.x
			;LDA vrtan.hit.height
			;LSR A
			;CLC
			;ADC vrtan.hit.y
			;ADC vrtan.y0
			;SEC
			;SBC #$0400
			;STA Spawn.y
			;PHY
			;JSR Spawn.Gibs
			;PLY
			;
			;INY
            ;CPY #$0008
			;BCC {-Loop}
;{+NoGibs}  ;
			;INC p0.timer
			;
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Vrtan.Spike}                                            //
            ;# ===============================================================//
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Vrtan.Respawn}                                          //
            ;# ===============================================================//
			;JSL Rng
			;# STA vrtan.x1
			;JSL Rng
			;# STA vrtan.y1
			;LDA #Vrtan.Idle
			;STA vrtan.state1
			;
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Vrtan.Sprite}                                           //
            ;# ===============================================================//
            ;LDA vrtan.state1     // if(state1!=state0||left1!=left0){
            ;CMP vrtan.state0     //
            ;BNE {+Update}        //
            ;LDX vrtan.left1      //
            ;CPX vrtan.left0      //
            ;BNE {+Update}        //
			;LDA vrtan.state1
			;CMP #Vrtan.Crush
			;BEQ {+Return}
			;CMP #Vrtan.Respawn
			;BEQ {+Return}
            ;LDA gravity1
            ;EOR gravity0
            ;AND #$8000
            ;BNE {+Update}
;{+Return}  ;RTS                  //
;{+Update}  ;
            ;# Walk ================
            ;CMP #Vrtan.Walk      //   if(state1==Vrtan.Walk){
            ;BNE {+Jump}          //
            ;LDA vrtan.left1      //     if(!left){
            ;BNE {+Left}          //
            ;LDA gravity1
            ;BMI {+Flip}
            ;LDX #vrtan.body.walk.r.script // X=body.walk.r.script;
            ;LDY #vrtan.legs.walk.r.script // Y=legs.walk.r.script;
            ;BRL {+Break}
;{+Flip}    ;LDX #vrtan.body.walk.ri.script // X=body.walk.r.script;
            ;LDY #vrtan.legs.walk.ri.script // Y=legs.walk.r.script;
            ;BRL {+Break}
;{+Left}    ;LDA gravity1
            ;BMI {+Flip}
            ;LDX #vrtan.body.walk.l.script // X=body.walk.l.script;
            ;LDY #vrtan.legs.walk.l.script // Y=legs.walk.l.script;
            ;BRL {+Break}
;{+Flip}    ;LDX #vrtan.body.walk.li.script // X=body.walk.l.script;
            ;LDY #vrtan.legs.walk.li.script // Y=legs.walk.l.script;
            ;BRL {+Break}
            ;
            ;# Jump ================
;{+Jump}    ;CMP #Vrtan.Jump      //   }else if(state1==Vrtan.Jump){
            ;BNE {+Fall}          //
            ;LDA vrtan.left1      //     if(!left){
            ;BNE {+Left}          //
            ;LDA gravity1
            ;BMI {+Flip}
            ;LDX #vrtan.body.jump.r.script // X=body.jump.r.script;
            ;LDY #vrtan.legs.jump.r.script // Y=legs.jump.r.script;
            ;BRL {+Break}         //     }else{
;{+Flip}    ;LDX #vrtan.body.jump.ri.script // X=body.jump.r.script;
            ;LDY #vrtan.legs.jump.ri.script // Y=legs.jump.r.script;
            ;BRL {+Break}         //     }else{
;{+Left}    ;LDA gravity1
            ;BMI {+Flip}
            ;LDX #vrtan.body.jump.l.script // X=body.jump.l.script;
            ;LDY #vrtan.legs.jump.l.script // Y=legs.jump.l.script;
            ;BRL {+Break}         //     }
;{+Flip}    ;LDX #vrtan.body.jump.li.script // X=body.jump.l.script;
            ;LDY #vrtan.legs.jump.li.script // Y=legs.jump.l.script;
            ;BRL {+Break}         //     }
            ;
            ;# Fall ================
;{+Fall}    ;CMP #Vrtan.Fall      //   }else if(state1==Vrtan.Fall){
            ;BNE {+Punch}         //
            ;LDA vrtan.left1      //     if(!left){
            ;BNE {+Left}          //
            ;LDA gravity1
            ;BMI {+Flip}
            ;LDX #vrtan.body.idle.r.script // X=body.idle.r.script;
            ;LDY #vrtan.legs.idle.r.script // Y=legs.idle.r.script;
            ;BRL {+Break}         //     }else{
;{+Flip}    ;LDX #vrtan.body.idle.ri.script // X=body.idle.r.script;
            ;LDY #vrtan.legs.idle.ri.script // Y=legs.idle.r.script;
            ;BRL {+Break}         //     }else{
;{+Left}    ;LDA gravity1
            ;BMI {+Flip}
            ;LDX #vrtan.body.idle.l.script // X=body.idle.l.script;
            ;LDY #vrtan.legs.idle.l.script // Y=legs.idle.l.script;
            ;BRL {+Break}         //     }
;{+Flip}    ;LDX #vrtan.body.idle.li.script // X=body.idle.l.script;
            ;LDY #vrtan.legs.idle.li.script // Y=legs.idle.l.script;
            ;BRL {+Break}         //     }
            ;
            ;# Punch ===============
;{+Punch}   ;CMP #Vrtan.Punch     //   }else if(state1==Vrtan.Punch){
            ;BNE {+Upper}         //
            ;LDA vrtan.left1      //     if(!left){
            ;BNE {+Left}          //
            ;LDA gravity1
            ;BMI {+Flip}
            ;LDX #vrtan.body.punch.r.script // X=body.idle.r.script;
            ;LDY #vrtan.legs.idle.r.script // Y=legs.idle.r.script;
            ;BRL {+Break}         //     }else{
;{+Flip}    ;LDX #vrtan.body.punch.ri.script // X=body.idle.r.script;
            ;LDY #vrtan.legs.idle.ri.script // Y=legs.idle.r.script;
            ;BRL {+Break}         //     }else{
;{+Left}    ;LDA gravity1
            ;BMI {+Flip}
            ;LDX #vrtan.body.punch.l.script // X=body.idle.l.script;
            ;LDY #vrtan.legs.idle.l.script // Y=legs.idle.r.script;
            ;BRL {+Break}         //     }
;{+Flip}    ;LDX #vrtan.body.punch.li.script // X=body.idle.l.script;
            ;LDY #vrtan.legs.idle.li.script // Y=legs.idle.r.script;
            ;BRL {+Break}         //     }
            ;
            ;# Uppercut ============
;{+Upper}   ;CMP #Vrtan.Uppercut  //   }else if(state1==Vrtan.Uppercut){
            ;BNE {+Crush}         //
            ;LDA vrtan.left1      //     if(!left){
            ;BNE {+Left}          //
            ;LDA gravity1
            ;BMI {+Flip}
            ;LDX #vrtan.body.uppercut.r.script // X=body.uppercut.r.script;
            ;LDY #vrtan.legs.jump.r.script // Y=legs.jump.r.script;
            ;BRL {+Break}         //     }else{
;{+Flip}    ;LDX #vrtan.body.uppercut.ri.script // X=body.uppercut.ri.script;
            ;LDY #vrtan.legs.jump.ri.script // Y=legs.jump.r.script;
            ;BRL {+Break}         //     }else{
;{+Left}    ;LDA gravity1
            ;BMI {+Flip}
            ;LDX #vrtan.body.uppercut.l.script // X=body.uppercut.l.script;
            ;LDY #vrtan.legs.jump.l.script // Y=legs.jump.l.script;
            ;BRL {+Break}         //     }
;{+Flip}    ;LDX #vrtan.body.uppercut.li.script // X=body.uppercut.li.script;
            ;LDY #vrtan.legs.jump.li.script // Y=legs.jump.l.script;
            ;BRL {+Break}         //     }
            ;
            ;# Crush ===============
;{+Crush}   ;CMP #Vrtan.Crushing  //   }else if(state1==Vrtan.Crush){
            ;BEQ {+Crushing}      //
            ;CMP #Vrtan.Crush     //   }else if(state1==Vrtan.Crush){
            ;BNE {+Respawn}       //
;{+Crushing};LDA vrtan.left1      //     if(!left){
            ;BNE {+Left}          //
            ;LDA gravity1         //
            ;BMI {+Flip}          //
            ;LDX #vrtan.body.crush.r.script // X=body.crush.r.script;
            ;LDY #$0000           //         Y=0;
            ;BRL {+Break}         //     }else{
;{+Flip}    ;LDX #vrtan.body.crush.ri.script // X=body.crush.ri.script;
            ;LDY #$0000           //         Y=0;
            ;BRL {+Break}         //     }else{
;{+Left}    ;LDA gravity1         //
            ;BMI {+Flip}          //
            ;LDX #vrtan.body.crush.l.script // X=body.crush.l.script;
            ;LDY #$0000           //         Y=0;
            ;BRL {+Break}         //     }
;{+Flip}    ;LDX #vrtan.body.crush.li.script // X=body.crush.li.script;
            ;LDY #$0000           //         Y=0;
            ;BRL {+Break}         //     }
            ;
            ;# Respawn =============
;{+Respawn} ;CMP #Vrtan.Respawn
			;BNE {+Idle}
			;LDX #$0000
			;LDY #$0000
			;BRA {+Break}
			;
            ;# Idle ================
;{+Idle}    ;LDA vrtan.left1      //   }else{
            ;BNE {+Left}          //     if(!left){
            ;LDA gravity1
            ;BMI {+Flip}
            ;LDX #vrtan.body.idle.r.script // X=body.idle.r.script;
            ;LDY #vrtan.legs.idle.r.script // Y=legs.idle.r.script;
            ;BRA {+Break}         //     }else{
;{+Flip}    ;LDX #vrtan.body.idle.ri.script // X=body.idle.r.script;
            ;LDY #vrtan.legs.idle.ri.script // Y=legs.idle.r.script;
            ;BRA {+Break}         //     }else{
;{+Left}    ;LDA gravity1
            ;BMI {+Flip}
            ;LDX #vrtan.body.idle.l.script // X=body.idle.l.script;
            ;LDY #vrtan.legs.idle.l.script // Y=legs.idle.l.script;
            ;BRA {+Break}
;{+Flip}    ;LDX #vrtan.body.idle.li.script // X=body.idle.l.script;
            ;LDY #vrtan.legs.idle.li.script // Y=legs.idle.l.script;
;{+Break}   ;
            ;STX vrtan.body.script//     }
            ;STZ vrtan.body.frame //   }
            ;STZ vrtan.body.timer //   body.script=X,body.frame=body.timer=0;
            ;STY vrtan.legs.script//   legs.script=Y,legs.frame=legs.timer=0;
            ;STZ vrtan.legs.frame //
            ;STZ vrtan.legs.timer // }
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#Code w {Vrtan.Move}                                             //
            ;# ===============================================================//
            ;LDA vrtan.x0         // Move.x0=(x0+hit.x)%0x0100;
            ;CLC                  //
            ;ADC vrtan.hit.x      //
            ;STA Move.x0          //
            ;LDA vrtan.y0         // Move.y0=(y0+hit.y)%0x0100;
            ;CLC                  //
            ;ADC vrtan.hit.y      //
            ;STA Move.y0          //
            ;LDA vrtan.vx         // Move.dx=vx;
            ;STA Move.dx          //
            ;LDA vrtan.vy         // Move.dy=vy;
            ;STA Move.dy          //
            ;LDA vrtan.hit.width  // Move.hit.width=hit.width;
            ;STA Move.xw       //
            ;LDA vrtan.hit.height // Move.hit.height=hit.height;
            ;STA Move.yw      //
            ;STZ Move.stop        // stop=0;
            ;JSR Move.Mob
            ;JSR Move.Level       // Move();
            ;
            ;LDA Move.x1          // x1=(Move.x1-hit.x)%0x0100;
            ;SEC                  //
            ;SBC vrtan.hit.x      //
            ;STA vrtan.x1         //
            ;LDA Move.y1          // y1=(Move.y1-hit.y)%0x0100;
            ;SEC                  //
            ;SBC vrtan.hit.y      //
            ;STA vrtan.y1         //
            ;
            ;LDA Move.stop        // vrtan.stop=Move.stop;
            ;STA vrtan.stop       //
            ;STZ vrtan.hazard     //
            ;
            ;LDA vrtan.x1         // if(x1!=x0){ 
            ;CMP vrtan.x0         //
            ;BEQ {+Same}          //
            ;LDA vrtan.vx         //   left1=vx<0?0xFFFF:0x0000;
            ;BMI {+Left}          //
            ;LDA #$0000           //
            ;BRA {+Right}         //
;{+Left}    ;LDA #$FFFF           //
;{+Right}   ;STA vrtan.left1      // }
;{+Same}    ;
            ;RTS                  // return;
            
            ;# ===============================================================//
            ;#                                                                //
            ;# ===============================================================//

