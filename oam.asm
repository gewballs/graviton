            
            ;# ===============================================================//
            ;#Code l {Ready_Oam}                                              //
            ;# ===============================================================//
            ;PHP
            ;PHB
            ;PEA $7E00
            ;PLB
            ;PLB
            ;REP #$30
            ;STZ oam_i
            ;STZ oam2_byte_i // and bit OS
            ;LDX #$001E
;{-}        ;STZ oam2,X
            ;DEX
            ;DEX
            ;BPL {-}
            ;PLB
            ;PLP
            ;RTL
            
            ;# ===============================================================//
            ;#Code l {Hide_Unused_Oam}                                        //
            ;# ===============================================================//
            ;PHP
            ;REP #$20
            ;LDA oam_i
            ;CMP #$0200
            ;BMI {+}
            ;PLP
            ;RTL
;{+}        ;LSR A
            ;STA $00
            ;LSR A
            ;ADC $00
            ;STA $00
            ;CLC
            ;PER $000C
            ;PLA
            ;ADC $00
            ;STA $00
            ;SEP #$20
            ;LDA #$F0
            ;JMP ($0000)
            ;STA $0101
            ;STA $0105
            ;STA $0109
            ;STA $010D
            ;STA $0111
            ;STA $0115
            ;STA $0119
            ;STA $011D
            ;STA $0121
            ;STA $0125
            ;STA $0129
            ;STA $012D
            ;STA $0131
            ;STA $0135
            ;STA $0139
            ;STA $013D
            ;STA $0141
            ;STA $0145
            ;STA $0149
            ;STA $014D
            ;STA $0151
            ;STA $0155
            ;STA $0159
            ;STA $015D
            ;STA $0161
            ;STA $0165
            ;STA $0169
            ;STA $016D
            ;STA $0171
            ;STA $0175
            ;STA $0179
            ;STA $017D
            ;STA $0181
            ;STA $0185
            ;STA $0189
            ;STA $018D
            ;STA $0191
            ;STA $0195
            ;STA $0199
            ;STA $019D
            ;STA $01A1
            ;STA $01A5
            ;STA $01A9
            ;STA $01AD
            ;STA $01B1
            ;STA $01B5
            ;STA $01B9
            ;STA $01BD
            ;STA $01C1
            ;STA $01C5
            ;STA $01C9
            ;STA $01CD
            ;STA $01D1
            ;STA $01D5
            ;STA $01D9
            ;STA $01DD
            ;STA $01E1
            ;STA $01E5
            ;STA $01E9
            ;STA $01ED
            ;STA $01F1
            ;STA $01F5
            ;STA $01F9
            ;STA $01FD
            ;STA $0201
            ;STA $0205
            ;STA $0209
            ;STA $020D
            ;STA $0211
            ;STA $0215
            ;STA $0219
            ;STA $021D
            ;STA $0221
            ;STA $0225
            ;STA $0229
            ;STA $022D
            ;STA $0231
            ;STA $0235
            ;STA $0239
            ;STA $023D
            ;STA $0241
            ;STA $0245
            ;STA $0249
            ;STA $024D
            ;STA $0251
            ;STA $0255
            ;STA $0259
            ;STA $025D
            ;STA $0261
            ;STA $0265
            ;STA $0269
            ;STA $026D
            ;STA $0271
            ;STA $0275
            ;STA $0279
            ;STA $027D
            ;STA $0281
            ;STA $0285
            ;STA $0289
            ;STA $028D
            ;STA $0291
            ;STA $0295
            ;STA $0299
            ;STA $029D
            ;STA $02A1
            ;STA $02A5
            ;STA $02A9
            ;STA $02AD
            ;STA $02B1
            ;STA $02B5
            ;STA $02B9
            ;STA $02BD
            ;STA $02C1
            ;STA $02C5
            ;STA $02C9
            ;STA $02CD
            ;STA $02D1
            ;STA $02D5
            ;STA $02D9
            ;STA $02DD
            ;STA $02E1
            ;STA $02E5
            ;STA $02E9
            ;STA $02ED
            ;STA $02F1
            ;STA $02F5
            ;STA $02F9
            ;STA $02FD
            ;PLP
            ;RTL
            
            
            ;# ===============================================================//
            ;#Code l {Draw_Sprite} (sprite,x,y,char_i,override)               //
            ;# ===============================================================//
            ;PHP
            ;REP #$10
            ;LDY oam_i
            ;CPY #$0200 // OAM Overflow
            ;BCC {+}
            ;PLP
            ;RTL
;{+}        ;PHB
            ;SEP #$20
            ;LDA Draw_Sprite.data_bank
            ;PHA
            ;PLB
            ;LDX Draw_Sprite.data_i
            ;LDA $0000,X // OBJ Count
            ;BRA {+}
;{--}       ;CPY #$0200 // OAM Overflow
            ;BCC {++}
            ;BRL {+Return}
;{++}       ;INX
            ;INX
            ;INX
            ;INX
;{+}        ;INX
            ;STA Draw_Sprite.obj_count
            ;LDA $0000,X // OBJ X Position
            ;PHX
            ;CLC
            ;ADC Draw_Sprite.x
            ;STA oam.x,Y
            ;LDA $0004,X // OBJ OAM II
            ;AND #$03
            ;BCC {+}
            ;EOR #$01
;{+}        ;STY oam_i
            ;SEP #$10
            ;LDY oam2_bit_i
;{-}        ;BEQ {+}
            ;ASL A
            ;ASL A
            ;DEY
            ;DEY
            ;BRA {-}
;{+}        ;LDY oam2_byte_i
            ;ORA oam2,Y
            ;STA oam2,Y
            ;LDY oam2_bit_i
            ;INY
            ;INY
            ;CPY #$08
            ;BCC {+}
            ;LDY #$00
            ;INC oam2_byte_i
;{+}        ;STY oam2_bit_i
            ;REP #$10
            ;LDY oam_i
            ;PLX
            ;LDA $0001,X // OBJ Y Position
            ;CLC
            ;ADC Draw_Sprite.y
            ;STA oam.y,Y
            ;REP #$20
            ;LDA $0002,X // OBJ Character/Settings
            ;AND #$01FF
            ;CLC
            ;ADC Draw_Sprite.char_i
            ;AND #$01FF
            ;SEP #$20
            ;STA oam.c,Y
            ;XBA
            ;EOR $0003,X
            ;PHA
            ;LDA Draw_Sprite.obj_p_override
            ;BEQ {+}
            ;PLA
            ;AND #$C1
            ;ORA Draw_Sprite.obj_p_override
            ;BRA {++}
;{+}        ;PLA
;{++}       ;STA oam.p,Y // Draw Sprite OBJ P
            ;INY
            ;INY
            ;INY
            ;INY
            ;LDA Draw_Sprite.obj_count
            ;DEC A
            ;BMI {+Return}
            ;BRL {--}
;{+Return}  ;STY oam_i
            ;PLB
            ;PLP
            ;RTL
            
            
            ;# ===============================================================//
            ;#Code w {AnimateSprite}                                          //
            ;# ===============================================================//
            ;PHP
            ;REP #$30
            ;LDA (AnimateSprite.base) // Get script pointer
			;BEQ {+Done}
            ;STA AnimateSprite.script
            ;LDY #$0002
            ;LDA (AnimateSprite.base),Y // Get frame offset
            ;ASL A
            ;ASL A
            ;CLC
            ;ADC #$0002 // Skip frame count
            ;TAY
            ;LDA (AnimateSprite.script),Y // Get sprite pointer
            ;STA Draw_Sprite.data_i
            ;INY
            ;INY
            ;LDA (AnimateSprite.script),Y // Get timer max
            ;STA AnimateSprite.timer
            ;JSR Draw_Sprite
            ;
            ;LDY #$0004
            ;LDA (AnimateSprite.base),Y // Get timer
            ;INC A
            ;CMP AnimateSprite.timer
            ;BNE {+Stay}
            ;
            ;LDY #$0002 // Increment or loop frame
            ;LDA (AnimateSprite.base),Y
            ;INC A
            ;CMP (AnimateSprite.script) // Compare with number of frames
            ;BNE {+NoLoop}
            ;LDA #$0000
;{+NoLoop}  ;STA (AnimateSprite.base),Y
            ;
            ;LDA #$0000
            ;LDY #$0004
            ;
;{+Stay}    ;STA (AnimateSprite.base),Y
            ;
;{+Done}    ;PLP
            ;RTS

            ;# ===============================================================//
            ;#                                                                //
            ;#                                                                //
            ;#                                                                //
            ;# ===============================================================//

