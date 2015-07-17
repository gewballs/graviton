
            ;# ===============================================================//O
            ;#Code w {Edit}                                                   //
            ;# ===============================================================//
            ;PHP
            ;REP #$30
            ;
            ;LDA joy1.edge
            ;BIT #JOY_select
            ;BEQ {+Same}
            ;LDA Edit.mode
            ;BNE {+Off}
            ;LDA #$FFFF
            ;BRA {+On}
;{+Off}     ;LDA #$0000
;{+On}      ;STA Edit.mode
;{+Same}    ;
            ;LDA Edit.mode
            ;BNE {+Edit}
            ;PLP
            ;RTS
;{+Edit}    ;
            ;# Position ==============
            ;LDA joy1.edge
            ;BIT #JOY_right
            ;BEQ {+Left}
            ;LDA Edit.x
            ;INC A
            ;AND #$001F
            ;STA Edit.x
            ;BRA {+Down}
            ;
;{+Left}    ;BIT #JOY_left
            ;BEQ {+Down}
            ;LDA Edit.x
            ;DEC A
            ;AND #$001F
            ;STA Edit.x
            ;
;{+Down}    ;LDA joy1.edge
            ;BIT #JOY_down
            ;BEQ {+Up}
            ;LDA Edit.y
            ;INC A
            ;AND #$001F
            ;STA Edit.y
            ;BRA {+Tile}
            ;
;{+Up}      ;BIT #JOY_up
            ;BEQ {+Tile}
            ;LDA Edit.y
            ;DEC A
            ;AND #$001F
            ;STA Edit.y
            ;
            ;# Tile ==================
;{+Tile}    ;STZ Edit.tile
            ;
            ;# Name ==================
            ;LDA joy1.edge
            ;BIT #JOY_y
            ;BEQ {+Decrease}
            ;LDA Edit.n
            ;INC A
            ;BRA {+Increase}
            ;
;{+Decrease};BIT #JOY_b
            ;BNE {+Edit}
            ;LDA Edit.n
            ;BRA {+Tile}
;{+Edit}    ;LDA Edit.n
            ;DEC A
;{+Increase};AND #$03FF
            ;STA Edit.n
;{+Tile}    ;ORA Edit.tile
            ;STA Edit.tile
            ;
            ;# Flip ==================
            ;LDA joy1.edge
            ;BIT #JOY_x
            ;BNE {+Edit}
            ;LDA Edit.f
            ;BRA {+Tile}
;{+Edit}    ;LDA Edit.f
            ;INC A
            ;AND #$0003
            ;STA Edit.f
;{+Tile}    ;CLC
            ;ROR A
            ;ROR A
            ;ROR A
            ;ORA Edit.tile
            ;STA Edit.tile
            ;
            ;# Priority ==============
            ;LDA joy1.edge
            ;BIT #JOY_l
            ;BNE {+Edit}
            ;LDA Edit.p
            ;BRA {+Tile}
;{+Edit}    ;LDA Edit.p
            ;INC A
            ;AND #$0001
            ;STA Edit.p
;{+Tile}    ;CLC
            ;ROR A
            ;ROR A
            ;ROR A
            ;ROR A
            ;ORA Edit.tile
            ;STA Edit.tile
            ;
            ;# Palette ===============
            ;LDA joy1.edge
            ;BIT #JOY_r
            ;BNE {+Edit}
            ;LDA Edit.c
            ;BRA {+Tile}
;{+Edit}    ;LDA Edit.c
            ;INC A
            ;AND #$0007
            ;STA Edit.c
;{+Tile}    ;XBA
            ;ASL A
            ;ASL A
            ;ORA Edit.tile
            ;STA Edit.tile
            ;
            ;# Commit ================
;{+Commit}  ;LDA joy1
            ;BIT #JOY_a
            ;BEQ {+Return}
			;
			;LDA $DB0000
            ;PHB
            ;PEA $7E00
            ;PLB
            ;PLB
            ;LDA Edit.y
            ;ASL A
            ;ASL A
            ;ASL A
            ;ASL A
            ;ASL A
            ;ASL A
            ;CLC
            ;ADC Edit.x
            ;ADC Edit.x
            ;TAY
            ;LDA Edit.tile
            ;STA level,Y
            ;PLB
            ;
            ;LDX Nmi.Write.i
            ;STA Nmi.Write.data,X
            ;TYA
            ;LSR A
            ;CLC
            ;ADC #vram.bg1.name
            ;STA Nmi.Write.base,X
            ;INX
            ;INX
            ;INX
            ;INX
            ;STX Nmi.Write.i
            ;
;{+Return}  ;PLP
            ;RTS
            
            ;# ===============================================================//
            ;#                                                                //
            ;#                                                                //
            ;#                                                                //
            ;# ===============================================================//

