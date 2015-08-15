            
            ;# ===============================================================//
            ;# SNES Registers                                                 //
            ;# ===============================================================//

            ;# Dir Address  Name                 Size      Notes
            
            ;#Name $2100    INIDISP              b
            ;#Name $2101    OBJSEL               b
            ;#Name $2102    OAMADD               w
            ;#Name $2104    OAMDATA              b         LH
            ;#Name $2105    BGMODE               b
            ;#Name $2106    MOSAIC               b
            ;#Name $2107    BG1SC                b
            ;#Name $2108    BG2SC                b
            ;#Name $2109    BG3SC                b
            ;#Name $210A    BG4SC                b
            ;#Name $210B    BG12NBA              b
            ;#Name $210C    BG34NBA              b
            ;#Name $210D    BG1HOFS              b         LH
            ;#Name $210E    BG1VOFS              b         LH
            ;#Name $210F    BG2HOFS              b         LH
            ;#Name $2110    BG2VOFS              b         LH
            ;#Name $2111    BG3HOFS              b         LH
            ;#Name $2112    BG3VOFS              b         LH
            ;#Name $2113    BG4HOFS              b         LH
            ;#Name $2114    BG4VOFS              b         LH
            ;#Name $2115    VMAINC               b
            ;#Name $2116    VMADD                w
            ;#Name $2118    VMDATA               w
            ;#Name $211A    M7SEL                b
            ;#Name $211B    M7A                  b         LH
            ;#Name $211C    M7B                  b         LH
            ;#Name $211D    M7C                  b         LH
            ;#Name $211E    M7D                  b         LH
            ;#Name $211F    M7X                  b         LH
            ;#Name $2120    M7Y                  b         LH
            ;#Name $2121    CGADD                b
            ;#Name $2122    CGDATA               b         LH
            ;#Name $2123    W12SEL               b
            ;#Name $2124    W34SEL               b
            ;#Name $2125    WOBJSEL              b
            ;#Name $2126    WH0                  b
            ;#Name $2127    WH1                  b
            ;#Name $2128    WH2                  b
            ;#Name $2129    WH3                  b
            ;#Name $212A    WBGLOG               b
            ;#Name $212B    WOBJLOG              b
            ;#Name $212C    TM                   b
            ;#Name $212D    TS                   b
            ;#Name $212E    TMW_                 b
            ;#Name $212F    TSW_                 b
            ;#Name $2130    CGSWSEL              b
            ;#Name $2131    CGADSUB              b
            ;#Name $2132    COLDATA              b
            ;#Name $2133    SETINI               b
            ;#Name $2134    RDMPY24              l         ro
            ;#Name $2137    SLHV                 b         ro
            ;#Name $2138    RDOAMDATA            b         ro,LH
            ;#Name $2139    RDVMDATA             w         ro
            ;#Name $213B    RDCGDATA             b         ro,LH
            ;#Name $213C    OPHCT                b         ro,LH
            ;#Name $213D    OPVCT                b         ro,LH
            ;#Name $213E    STAT77               b         ro
            ;#Name $213F    STAT78               b         ro
            ;#Name $2140    APUIO0               b
            ;#Name $2141    APUIO1               b
            ;#Name $2142    APUIO2               b
            ;#Name $2143    APUIO3               b
            ;#Name $2180    WMDATA               b
            ;#Name $2181    WMADD                l
            ;#Name $4016    JOYIO                w
            ;#Name $4200    NMITIMEN             b
            ;#Name $4201    WRIO                 b
            ;#Name $4202    WRMPYA               b
            ;#Name $4203    WRMPYB               b
            ;#Name $4204    WRDIVA               w
            ;#Name $4206    WRDIVB               b
            ;#Name $4207    HTIME                w
            ;#Name $4209    VTIME                w
            ;#Name $420B    MDMAEN               b
            ;#Name $420C    HDMAEN               b
            ;#Name $420D    MEMSEL               b
            ;#Name $4210    RDNMI                b         ro
            ;#Name $4211    TIMEUP               b         ro
            ;#Name $4212    HVBJOY               b         ro
            ;#Name $4213    RDIO                 b         ro
            ;#Name $4214    RDDIV                w         ro
            ;#Name $4216    RDMPY16              w         ro
            ;#Name $4218    JOY1                 w
            ;#Name $421A    JOY2                 w
            ;#Name $421C    JOY3                 w
            ;#Name $421E    JOY4                 w
            ;#Name $4300    DMAP                 b
            ;#Name $4301    DMAB                 b
            ;#Name $4302    DMAA                 l
            ;#Name $4305    DMAD                 l
            ;#Name $4308    DMAI                 w
            ;#Name $430A    DMAL                 b
            ;#Name $4300    DMAP0                b
            ;#Name $4301    DMAB0                b
            ;#Name $4302    DMAA0                l
            ;#Name $4305    DMAD0                l
            ;#Name $4308    DMAI0                w
            ;#Name $430A    DMAL0                b
            ;#Name $4310    DMAP1                b
            ;#Name $4311    DMAB1                b
            ;#Name $4312    DMAA1                l
            ;#Name $4315    DMAD1                l
            ;#Name $4318    DMAI1                w
            ;#Name $431A    DMAL1                b
            ;#Name $4320    DMAP2                b
            ;#Name $4321    DMAB2                b
            ;#Name $4322    DMAA2                l
            ;#Name $4325    DMAD2                l
            ;#Name $4328    DMAI2                w
            ;#Name $432A    DMAL2                b
            ;#Name $4330    DMAP3                b
            ;#Name $4331    DMAB3                b
            ;#Name $4332    DMAA3                l
            ;#Name $4335    DMAD3                l
            ;#Name $4338    DMAI3                w
            ;#Name $433A    DMAL3                b
            ;#Name $4340    DMAP4                b
            ;#Name $4341    DMAB4                b
            ;#Name $4342    DMAA4                l
            ;#Name $4345    DMAD4                l
            ;#Name $4348    DMAI4                w
            ;#Name $434A    DMAL4                b
            ;#Name $4350    DMAP5                b
            ;#Name $4351    DMAB5                b
            ;#Name $4352    DMAA5                l
            ;#Name $4355    DMAD5                l
            ;#Name $4358    DMAI5                w
            ;#Name $435A    DMAL5                b
            ;#Name $4360    DMAP6                b
            ;#Name $4361    DMAB6                b
            ;#Name $4362    DMAA6                l
            ;#Name $4365    DMAD6                l
            ;#Name $4368    DMAI6                w
            ;#Name $436A    DMAL6                b
            ;#Name $4370    DMAP7                b
            ;#Name $4371    DMAB7                b
            ;#Name $4372    DMAA7                l
            ;#Name $4375    DMAD7                l
            ;#Name $4378    DMAI7                w
            ;#Name $437A    DMAL7                b
            
            ;# ===============================================================//
            ;#                                                                //
            ;#                                                                //
            ;#                                                                //
            ;# ===============================================================//

;#Name $00 DSP_voll0
;#Name $01 DSP_volr0
;#Name $02 DSP_pitchl0
;#Name $03 DSP_pitchh0
;#Name $04 DSP_srcn0
;#Name $05 DSP_adsrl0
;#Name $06 DSP_adsrh0
;#Name $07 DSP_gain0
;#Name $08 DSP_envx0
;#Name $09 DSP_outx0

;#Name $10 DSP_voll1
;#Name $11 DSP_volr1
;#Name $12 DSP_pitchl1
;#Name $13 DSP_pitchh1
;#Name $14 DSP_srcn1
;#Name $15 DSP_adsrl1
;#Name $16 DSP_adsrh1
;#Name $17 DSP_gain1
;#Name $18 DSP_envx1
;#Name $19 DSP_outx1

;#Name $20 DSP_voll2
;#Name $21 DSP_volr2
;#Name $22 DSP_pitchl2
;#Name $23 DSP_pitchh2
;#Name $24 DSP_srcn2
;#Name $25 DSP_adsrl2
;#Name $26 DSP_adsrh2
;#Name $27 DSP_gain2
;#Name $28 DSP_envx2
;#Name $29 DSP_outx2

;#Name $30 DSP_voll3
;#Name $31 DSP_volr3
;#Name $32 DSP_pitchl3
;#Name $33 DSP_pitchh3
;#Name $34 DSP_srcn3
;#Name $35 DSP_adsrl3
;#Name $36 DSP_adsrh3
;#Name $37 DSP_gain3
;#Name $38 DSP_envx3
;#Name $39 DSP_outx3

;#Name $40 DSP_voll4
;#Name $41 DSP_volr4
;#Name $42 DSP_pitchl4
;#Name $43 DSP_pitchh4
;#Name $44 DSP_srcn4
;#Name $45 DSP_adsrl4
;#Name $46 DSP_adsrh4
;#Name $47 DSP_gain4
;#Name $48 DSP_envx4
;#Name $49 DSP_outx4

;#Name $50 DSP_voll5
;#Name $51 DSP_volr5
;#Name $52 DSP_pitchl5
;#Name $53 DSP_pitchh5
;#Name $54 DSP_srcn5
;#Name $55 DSP_adsrl5
;#Name $56 DSP_adsrh5
;#Name $57 DSP_gain5
;#Name $58 DSP_envx5
;#Name $59 DSP_outx5

;#Name $60 DSP_voll6
;#Name $61 DSP_volr6
;#Name $62 DSP_pitchl6
;#Name $63 DSP_pitchh6
;#Name $64 DSP_srcn6
;#Name $65 DSP_adsrl6
;#Name $66 DSP_adsrh6
;#Name $67 DSP_gain6
;#Name $68 DSP_envx6
;#Name $69 DSP_outx6

;#Name $70 DSP_voll7
;#Name $71 DSP_volr7
;#Name $72 DSP_pitchl7
;#Name $73 DSP_pitchh7
;#Name $74 DSP_srcn7
;#Name $75 DSP_adsrl7
;#Name $76 DSP_adsrh7
;#Name $77 DSP_gain7
;#Name $78 DSP_envx7
;#Name $79 DSP_outx7

;#Name $0C DSP_mvoll
;#Name $1C DSP_mvolr
;#Name $2C DSP_evoll
;#Name $3C DSP_evolr
;#Name $4C DSP_kon
;#Name $5C DSP_kof
;#Name $6C DSP_flg
;#Name $7C DSP_endx
;#Name $0D DSP_efb
;#Name $2D DSP_pmon
;#Name $3D DSP_non
;#Name $4D DSP_eon
;#Name $5D DSP_dir
;#Name $6D DSP_esa
;#Name $7D DSP_edl

