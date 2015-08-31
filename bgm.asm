;#{ PITCH for A440Hz instruments sampled at 32kHz

  C-6  C#6  D-6  D#6  E-6  F-6  F#6  G-6  G#6  A-6
  260D 2851 2AB7 2D41 2FF2 32CB 35D1 3904 3C68 3FFF

  C-5  C#5  D-5  D#5  E-5  F-5  F#5  G-5  G#5  A-5  A#5  B-5
  1306 1428 155B 16A0 17F9 1965 1AE8 1C82 1E34 2000 21E7 23EB

  C-4  C#4  D-4  D#4  E-4  F-4  F#4  G-4  G#4  A-4  A#4  B-4
  0983 0A14 0AAD 0B50 0BFC 0CB2 0D74 0E41 0F1A 1000 10F3 11F5

  C-3  C#3  D-3  D#3  E-3  F-3  F#3  G-3  G#3  A-3  A#3  B-3
  04C1 050A 0556 05A8 05FE 0659 06BA 0720 078D 0800 0879 08FA

  C-2  C#2  D-2  D#2  E-2  F-2  F#2  G-2  G#2  A-2  A#2  B-2
  0260 0285 02AB 02D4 02FF 032C 035D 0390 03C6 0400 043C 047D

  C-1  C#1  D-1  D#1  E-1  F-1  F#1  G-1  G#1  A-1  A#1  B-1
  0130 0142 0155 016A 017F 0196 01AE 01C8 01E3 0200 021E 023E

;#}

;#Name $00 BGM_pass // pass 00
;#Name $01 BGM_wait // wait 01 ww
;#Name $02 BGM_time // time 02 nn tt
;#Name $03 BGM_kon  // kon  03 rr dd
;#Name $04 BGM_kof  // kof  04 rr dd
;#Name $05 BGM_byte // byte 05 rr dd
;#Name $06 BGM_word // data 06 rr dddd
;#Name $07 BGM_jump // jump 07 aaaa
;#Name $08 BGM_loop // loop 08 ll aaaa
;#Name $09 BGM_call // call 09 aaaa
;#Name $0A BGM_back // back 0A

;# $0500 Tracks
;#Data l bgm.tracks {
  $0516 $0510 $0510 $0510 $0510 $0510 $0510 $0510
}

;# $0510 Track,Null
;#Data l bgm.null {
  BGM_wait $FF
  BGM_pass
  BGM_jump $0512
}

;# $0516 Track,Test
;#Data l bgm.test {
  BGM_time $FA $00

  BGM_word DSP_mvoll   $7F $7F
  BGM_byte DSP_flg     $20
  BGM_byte DSP_pmon    $00
  BGM_byte DSP_non     $00
  BGM_byte DSP_eon     $00
  BGM_byte DSP_dir     $06

  BGM_wait $20

  BGM_byte DSP_srcn0   $05
  BGM_word DSP_adsrl0  $D9 $E8, BGM_byte DSP_gain0 $00
  BGM_word DSP_voll0   $3F $3F, BGM_word DSP_pitchl0 $0800
  BGM_kon $01


  BGM_byte DSP_srcn0   $06
  BGM_word DSP_adsrl0  $CA $EF, BGM_byte DSP_gain0 $00
  BGM_word DSP_voll0   $3F $3F, BGM_word DSP_pitchl0 $1000
  BGM_kon $01


  BGM_byte DSP_srcn0   $07
  BGM_word DSP_adsrl0  $00 $00, BGM_byte DSP_gain0 $7F
  BGM_word DSP_voll0   $3F $3F, BGM_word DSP_pitchl0 $0800
  BGM_kon $01


  BGM_byte DSP_srcn0   $08
  BGM_word DSP_adsrl0  $00 $00, BGM_byte DSP_gain0 $7F
  BGM_word DSP_voll0   $3F $3F, BGM_word DSP_pitchl0 $0800
  BGM_kon $01


  BGM_byte DSP_srcn0   $09
  BGM_word DSP_adsrl0  $00 $00, BGM_byte DSP_gain0 $7F
  BGM_word DSP_voll0   $3F $3F, BGM_word DSP_pitchl0 $1000
  BGM_kon $01


  BGM_byte DSP_srcn0   $0A
  BGM_word DSP_adsrl0  $00 $00, BGM_byte DSP_gain0 $7F
  BGM_word DSP_voll0   $3F $3F, BGM_word DSP_pitchl0 $1000
  BGM_kon $01


  BGM_byte DSP_srcn0   $0B
  BGM_word DSP_adsrl0  $00 $00, BGM_byte DSP_gain0 $7F
  BGM_word DSP_voll0   $3F $3F, BGM_word DSP_pitchl0 $0BFC
  BGM_kon $01


  BGM_byte DSP_srcn0   $0C
  BGM_word DSP_adsrl0  $00 $00, BGM_byte DSP_gain0 $7F
  BGM_word DSP_voll0   $3F $3F, BGM_word DSP_pitchl0 $1000
  BGM_kon $01

  BGM_jump $052E
}

;#Data l dummy {
  $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00
  $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00
  $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00
}


            ;# $0600 BRR Source Directory
            ;#Data l dir00 { $0634 $0634 } // Silence
            ;#Data l dir01 { $063D $063D } // A4 Sine
            ;#Data l dir02 { $068E $068E } // A4 Triangle
            ;#Data l dir03 { $06DF $06DF } // A4 Square
            ;#Data l dir04 { $0730 $0730 } // A4 Saw
            ;#Data l dir05 { $0781 $0781 } // C3 Bass
            ;#Data l dir06 { $0931 $0931 } // C4 Horn
            ;#Data l dir07 { $0955 $0955 } // C4 Pluck
            ;#Data l dir08 { $1270 $1270 } // C4 Kick
            ;#Data l dir09 { $16F0 $16F0 } // C4 Hat
            ;#Data l dir0A { $232C $232C } // C4 Snare
            ;#Data l dir0B { $3121 $3121 } // C4 Yo
            ;#Data l dir0C { $4024 $4024 } // C4 Stab

			;# $0634 BRR Silence
            ;#Data l brr.silence { 
              $01 $00 $00 $00 $00 $00 $00 $00 $00
            }

            ;# $063D BRR Sine wave sample
            ;#Data l brr.sine {
              $C2 $01 $12 $33 $44 $55 $66 $67 $77 
              $C2 $77 $77 $77 $77 $66 $65 $54 $43
              $C2 $32 $11 $0F $FE $DD $CC $BB $AA
              $C2 $A9 $99 $99 $99 $99 $99 $AA $AB
              $C2 $BC $CD $DE $FF $01 $12 $33 $44
              $C2 $55 $66 $67 $77 $77 $77 $77 $77
              $C2 $66 $65 $54 $43 $32 $11 $0F $FE
              $C2 $DD $CC $BB $AA $A9 $99 $99 $99
              $C3 $99 $99 $AA $AB $BC $CD $DE $FF
            }

            ;# $068E BRR Triangle wave
            ;#Data l brr.triangle {
              $C2 $00 $11 $22 $23 $33 $44 $55 $56 
              $C2 $67 $77 $66 $55 $54 $43 $33 $22
              $C2 $21 $10 $00 $FF $EE $ED $DD $CC
              $C2 $BB $BA $A9 $99 $AA $BB $BC $CD
              $B2 $AB $BC $DE $EF $01 $22 $34 $55
              $C2 $33 $44 $55 $56 $67 $77 $66 $55
              $C2 $54 $43 $33 $22 $21 $10 $00 $FF
              $C2 $EE $ED $DD $CC $BB $BA $A9 $99
              $C3 $AA $BB $BC $CD $DD $EE $EF $F0
            }

            ;# $06DF BRR Square wave
            ;#Data l brr.square {
              $C2 $77 $77 $77 $77 $77 $77 $77 $77 
              $C2 $77 $77 $77 $77 $77 $77 $77 $77
              $C2 $77 $77 $99 $99 $99 $99 $99 $99
              $C2 $99 $99 $99 $99 $99 $99 $99 $99
              $C2 $99 $99 $99 $99 $77 $77 $77 $77
              $C2 $77 $77 $77 $77 $77 $77 $77 $77
              $C2 $77 $77 $77 $77 $77 $77 $99 $99
              $C2 $99 $99 $99 $99 $99 $99 $99 $99
              $C3 $99 $99 $99 $99 $99 $99 $99 $99
            }

            ;# $0730 BRR Saw wave
            ;#Data l brr.saw {
              $C2 $99 $99 $9A $AA $AA $BB $BB $BC 
              $C2 $CC $CD $DD $DD $EE $EE $EF $FF
              $B2 $FF $F0 $01 $11 $22 $33 $44 $45
              $C2 $33 $33 $34 $44 $45 $55 $55 $66
              $C2 $66 $67 $77 $77 $99 $99 $9A $AA
              $C2 $AA $BB $BB $BC $CC $CD $DD $DD
              $B2 $BC $CC $DD $EE $FF $F0 $01 $11
              $C2 $11 $12 $22 $22 $33 $33 $34 $44
              $C3 $45 $55 $55 $66 $66 $67 $77 $77
            }

            ;# $0781 BRR Samples
            ;#Data l brr.bass  { #bass.brr  } // 0x01B0 B
            ;#Data l brr.horn  { #horn.brr  } // 0x0024 B
            ;#Data l brr.pluck { #pluck.brr } // 0x091B B
            ;#Data l brr.kick  { #kick.brr  } // 0x0480 B
            ;#Data l brr.hat   { #hat.brr   } // 0x0C3C B
            ;#Data l brr.snare { #snare.brr } // 0x0DF5 B
            ;#Data l brr.yo    { #yo.brr    } // 0x0F03 B
            ;#Data l brr.stab  { #stab.brr  } // 0x158D B
            




;#{

THESE TRACKS NEED TO BE UPDATED

;# $xxxx Track0,Bass
;#Data l bgm.track0 {
    BGM_time $FA $00

    BGM_data DSP_mvoll   $7F, BGM_data DSP_mvolr   $7F
    BGM_data DSP_flg     $20
    BGM_data DSP_pmon    $00
    BGM_data DSP_non     $00
    BGM_data DSP_eon     $00
    BGM_data DSP_dir     $04

    BGM_data DSP_srcn0   $05
    BGM_data DSP_adsrl0  $D8, BGM_data DSP_adsrh0  $B8, BGM_data DSP_gain0 $00

    BGM_data DSP_voll0   $3F, BGM_data DSP_volr0   $3F
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $60
   BGM_data DSP_kon     $01, BGM_wait $04
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $3C
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $C1
   BGM_data DSP_kon     $01, BGM_wait $08
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $60
   BGM_data DSP_kon     $01, BGM_wait $04
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $3C
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $C1
   BGM_data DSP_kon     $01, BGM_wait $08
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_kon     $01, BGM_wait $10
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $60
   BGM_data DSP_kon     $01, BGM_wait $04
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $3C
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $C1
   BGM_data DSP_kon     $01, BGM_wait $08
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $60
   BGM_data DSP_kon     $01, BGM_wait $04
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $3C
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $C1
   BGM_data DSP_kon     $01, BGM_wait $08
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $05, BGM_data DSP_pitchl0 $FE
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $C1
   BGM_data DSP_kon     $01, BGM_pass
   
   BGM_data DSP_pitchh0 $01, BGM_data DSP_pitchl0 $96
   BGM_data DSP_kon     $01, BGM_wait $04
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $D4
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $03, BGM_data DSP_pitchl0 $2C
   BGM_data DSP_kon     $01, BGM_wait $08
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $01, BGM_data DSP_pitchl0 $96
   BGM_data DSP_kon     $01, BGM_wait $04
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $D4
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $03, BGM_data DSP_pitchl0 $2C
   BGM_data DSP_kon     $01, BGM_wait $08
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_kon     $01, BGM_wait $10
   BGM_data DSP_pitchh0 $01, BGM_data DSP_pitchl0 $96
   BGM_data DSP_kon     $01, BGM_wait $04
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $D4
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $03, BGM_data DSP_pitchl0 $2C
   BGM_data DSP_kon     $01, BGM_wait $08
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $00
   BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0   $5F
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $00
   BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0   $7F
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $1E
   BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0   $5F
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $3C
   BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0   $7F
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $3E
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $7D
   BGM_data DSP_kon     $01, BGM_pass

   BGM_loop $01 $05C0

    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0   $7F
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $60
   BGM_data DSP_kon     $01, BGM_wait $10
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0   $5F
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $C1
   BGM_data DSP_kon     $01, BGM_wait $04
   BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0   $7F
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $1E
   BGM_data DSP_kon     $01, BGM_wait $08
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $3C
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $00
   BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $3F, BGM_data DSP_volr0   $3F
   BGM_data DSP_pitchh0 $03, BGM_data DSP_pitchl0 $2C
   BGM_data DSP_kon     $01, BGM_wait $10
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0   $5F
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $C1
   BGM_data DSP_kon     $01, BGM_wait $04
    BGM_data DSP_voll0   $3F, BGM_data DSP_volr0   $3F
   BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0   $5F
   BGM_data DSP_pitchh0 $03, BGM_data DSP_pitchl0 $2C
   BGM_data DSP_kon     $01, BGM_wait $08
   BGM_data DSP_pitchh0 $03, BGM_data DSP_pitchl0 $C6
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $00
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $3C
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $C1
   BGM_data DSP_kon     $01, BGM_pass

   BGM_loop $03 $0734

   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $60
   BGM_data DSP_kon     $01, BGM_wait $10
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_kon     $01, BGM_wait $08
   BGM_data DSP_pitchh0 $03, BGM_data DSP_pitchl0 $90
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $03, BGM_data DSP_pitchl0 $2C
   BGM_data DSP_kon     $01, BGM_wait $10
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_kon     $01, BGM_wait $08
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $C1
   BGM_data DSP_kon     $01, BGM_pass

   BGM_data DSP_pitchh0 $03, BGM_data DSP_pitchl0 $2C
   BGM_data DSP_kon     $01, BGM_wait $10
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_kon     $01, BGM_wait $08
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $FF
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $60
   BGM_data DSP_kon     $01, BGM_wait $10
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_kon     $01, BGM_wait $08
   BGM_data DSP_pitchh0 $03, BGM_data DSP_pitchl0 $90
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $3C
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $05, BGM_data DSP_pitchl0 $A8
   BGM_data DSP_kon     $01, BGM_pass
   
   BGM_loop $01 $07F0

    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0   $7F
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $60
   BGM_data DSP_kon     $01, BGM_wait $08
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0   $5F
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $00
   BGM_data DSP_kon     $01, BGM_wait $04
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $3C
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $03, BGM_data DSP_pitchl0 $90
   BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0   $7F
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $D4
   BGM_data DSP_kon     $01, BGM_wait $0C
   BGM_data DSP_kon     $01, BGM_wait $08
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0   $5F
   BGM_data DSP_pitchh0 $03, BGM_data DSP_pitchl0 $2C
   BGM_data DSP_kon     $01, BGM_wait $04
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $D4
   BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $3F, BGM_data DSP_volr0   $3F
   BGM_data DSP_pitchh0 $03, BGM_data DSP_pitchl0 $2C
   BGM_data DSP_kon     $01, BGM_wait $08
    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0   $7F
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0   $5F
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $00
   BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0   $7F
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $3C
   BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0   $5F
   BGM_data DSP_pitchh0 $02, BGM_data DSP_pitchl0 $D4
   BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0   $7F
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $04, BGM_data DSP_pitchl0 $00
   BGM_data DSP_kon     $01, BGM_pass
   BGM_data DSP_pitchh0 $03, BGM_data DSP_pitchl0 $2C
   BGM_data DSP_kon     $01, BGM_pass
   
   BGM_loop $03 $088C
   
   BGM_jump $05C0
}

;# 096B BGM Track 1, Pluck and Horn
;#Data l bgm.track1 {
    BGM_data DSP_srcn1   $07
    BGM_data DSP_adsrl1  $D8, BGM_data DSP_adsrh1  $B8, BGM_data DSP_gain1 $00

    BGM_data DSP_voll1   $1F, BGM_data DSP_volr1   $1F
   BGM_data DSP_pitchh1 $05, BGM_data DSP_pitchl1 $FE
   BGM_data DSP_kon $02,  BGM_wait $08
   BGM_data DSP_pitchh1 $04, BGM_data DSP_pitchl1 $3C
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $04, BGM_data DSP_pitchl1 $C1
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $03, BGM_data DSP_pitchl1 $90
   BGM_data DSP_kon $02,  BGM_wait $10
   BGM_data DSP_pitchh1 $05, BGM_data DSP_pitchl1 $FE
   BGM_data DSP_kon $02,  BGM_wait $08
   BGM_data DSP_pitchh1 $04, BGM_data DSP_pitchl1 $3C
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $04, BGM_data DSP_pitchl1 $C1
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $03, BGM_data DSP_pitchl1 $90
   BGM_data DSP_kon $02,  BGM_wait $10
   BGM_data DSP_pitchh1 $05, BGM_data DSP_pitchl1 $FE
   BGM_data DSP_kon $02,  BGM_wait $08
   BGM_data DSP_pitchh1 $04, BGM_data DSP_pitchl1 $3C
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $04, BGM_data DSP_pitchl1 $C1
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $03, BGM_data DSP_pitchl1 $90
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $05, BGM_data DSP_pitchl1 $56
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $04, BGM_data DSP_pitchl1 $3C
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $04, BGM_data DSP_pitchl1 $00
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $02, BGM_data DSP_pitchl1 $D4
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $03, BGM_data DSP_pitchl1 $2C
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $02, BGM_data DSP_pitchl1 $60
   BGM_data DSP_kon $02,  BGM_wait $10
   BGM_data DSP_pitchh1 $04, BGM_data DSP_pitchl1 $00
   BGM_data DSP_kon $02,  BGM_wait $08
   BGM_data DSP_pitchh1 $02, BGM_data DSP_pitchl1 $D4
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $03, BGM_data DSP_pitchl1 $2C
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $02, BGM_data DSP_pitchl1 $60
   BGM_data DSP_kon $02,  BGM_wait $10
   BGM_data DSP_pitchh1 $04, BGM_data DSP_pitchl1 $00
   BGM_data DSP_kon $02,  BGM_wait $08
   BGM_data DSP_pitchh1 $02, BGM_data DSP_pitchl1 $D4
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $03, BGM_data DSP_pitchl1 $2C
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $02, BGM_data DSP_pitchl1 $60
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $03, BGM_data DSP_pitchl1 $90
   BGM_data DSP_kon $02,  BGM_pass
   BGM_data DSP_pitchh1 $04, BGM_data DSP_pitchl1 $3C
   BGM_data DSP_kon $02,  BGM_pass

   BGM_loop $01 $097D

   BGM_data DSP_srcn1   $06
    BGM_data DSP_adsrl1  $D8, BGM_data DSP_adsrh1  $B8, BGM_data DSP_gain1 $00
  
    BGM_data DSP_voll1   $5F, BGM_data DSP_volr1   $5F
   BGM_data DSP_pitchh1 $09, BGM_data DSP_pitchl1 $83
   BGM_data DSP_kon $02, BGM_wait $10
   BGM_data DSP_pitchh1 $0B, BGM_data DSP_pitchl1 $FC
   BGM_data DSP_kon $02, BGM_wait $04
   BGM_data DSP_pitchh1 $08, BGM_data DSP_pitchl1 $79
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_pitchh1 $09, BGM_data DSP_pitchl1 $83
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_pitchh1 $07, BGM_data DSP_pitchl1 $20
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_pitchh1 $08, BGM_data DSP_pitchl1 $00
   BGM_data DSP_kon $02, BGM_wait $08
   BGM_data DSP_pitchh1 $08, BGM_data DSP_pitchl1 $79
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_pitchh1 $0C, BGM_data DSP_pitchl1 $B2
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_pitchh1 $0B, BGM_data DSP_pitchl1 $50
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_pitchh1 $09, BGM_data DSP_pitchl1 $83
   BGM_data DSP_kon $02, BGM_wait $10
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_pitchh1 $0F, BGM_data DSP_pitchl1 $1A
   BGM_data DSP_kon $02, BGM_wait $04
   BGM_data DSP_pitchh1 $10, BGM_data DSP_pitchl1 $00
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_pitchh1 $0C, BGM_data DSP_pitchl1 $B2
   BGM_data DSP_kon $02, BGM_wait $08
   BGM_data DSP_pitchh1 $0F, BGM_data DSP_pitchl1 $1A
   BGM_data DSP_kon $02, BGM_wait $04
   BGM_data DSP_pitchh1 $0E, BGM_data DSP_pitchl1 $41
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_pitchh1 $0C, BGM_data DSP_pitchl1 $B2
   BGM_data DSP_kon $02, BGM_wait $08

   BGM_data DSP_pitchh1 $10, BGM_data DSP_pitchl1 $00
   BGM_data DSP_kon $02, BGM_wait $10
   BGM_data DSP_pitchh1 $0C, BGM_data DSP_pitchl1 $B2
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_kon $02, BGM_wait $04
   BGM_data DSP_pitchh1 $0E, BGM_data DSP_pitchl1 $41
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_pitchh1 $0B, BGM_data DSP_pitchl1 $50
   BGM_data DSP_kon $02, BGM_wait $08
   BGM_data DSP_pitchh1 $09, BGM_data DSP_pitchl1 $83
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_kon $02, BGM_wait $04
   BGM_data DSP_pitchh1 $0B, BGM_data DSP_pitchl1 $50
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_pitchh1 $0E, BGM_data DSP_pitchl1 $41
   BGM_data DSP_kon $02, BGM_wait $08
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_pitchh1 $0C, BGM_data DSP_pitchl1 $B2
   BGM_data DSP_kon $02, BGM_wait $30
   
   BGM_loop $01 $0AAE

    BGM_data DSP_voll1 $5F, BGM_data DSP_volr1 $5F
   BGM_data DSP_pitchh1 $05, BGM_data DSP_pitchl1 $FE
   BGM_data DSP_kon $02, BGM_wait $10
   BGM_data DSP_kon $02, BGM_wait $08
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_kon $02, BGM_wait $10
   BGM_data DSP_kon $02, BGM_wait $08
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_pitchh1 $06, BGM_data DSP_pitchl1 $59
   BGM_data DSP_kon $02, BGM_wait $10
   BGM_data DSP_kon $02, BGM_wait $08
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_kon $02, BGM_wait $10
   BGM_data DSP_kon $02, BGM_wait $08
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_kon $02, BGM_wait $10
   BGM_data DSP_kon $02, BGM_wait $08
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_kon $02, BGM_wait $10
   BGM_data DSP_kon $02, BGM_wait $08
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_pitchh1 $04, BGM_data DSP_pitchl1 $C1
   BGM_data DSP_kon $02, BGM_wait $10
   BGM_data DSP_kon $02, BGM_wait $08
   BGM_data DSP_kon $02, BGM_pass
   BGM_data DSP_kon $02, BGM_wait $10
   BGM_data DSP_kon $02, BGM_wait $08
   BGM_data DSP_kon $02, BGM_pass

   BGM_loop $01 $0BC6

   BGM_wait $80
   BGM_wait $80
   BGM_wait $80
   BGM_wait $80
   
   BGM_jump $096B
}

;# $0C5D Track 2, Stab, Pluck, Yo
;#Data l bgm.track2 {
    BGM_data DSP_srcn2   $0C
    BGM_data DSP_adsrl2  $D8, BGM_data DSP_adsrh2  $B8, BGM_data DSP_gain2 $00

    BGM_data DSP_voll2   $7F, BGM_data DSP_volr2   $7F
   BGM_data DSP_pitchh2 $09, BGM_data DSP_pitchl2 $83
   BGM_data DSP_kon $04, BGM_wait $18
   BGM_data DSP_kon $04, BGM_wait $68

    BGM_loop $03 $0C69

    BGM_data DSP_voll2   $7F, BGM_data DSP_volr2   $7F
   BGM_data DSP_pitchh2 $09, BGM_data DSP_pitchl2 $83
   BGM_data DSP_kon $04, BGM_wait $E0
    BGM_data DSP_voll2   $3F  BGM_data DSP_volr2   $3F
   BGM_data DSP_pitchh2 $0C, BGM_data DSP_pitchl2 $B2
   BGM_data DSP_kon $04, BGM_wait $10
   BGM_data DSP_kon $04, BGM_pass

   BGM_loop $01 $0C83

    BGM_data DSP_srcn2   $07
    BGM_data DSP_adsrl2  $D8, BGM_data DSP_adsrh2  $B8,  BGM_data DSP_gain2 $00

    BGM_data DSP_voll2   $5F  BGM_data DSP_volr2   $5F
   BGM_data DSP_pitchh2 $04, BGM_data DSP_pitchl2 $C1
   BGM_data DSP_kon $04, BGM_wait $10
   BGM_data DSP_kon $04, BGM_wait $08
   BGM_data DSP_kon $04, BGM_pass
   BGM_data DSP_kon $04, BGM_wait $10
   BGM_data DSP_kon $04, BGM_wait $08
   BGM_data DSP_kon $04, BGM_pass
   BGM_data DSP_pitchh2 $04, BGM_data DSP_pitchl2 $3C
   BGM_data DSP_kon $04, BGM_wait $10
   BGM_data DSP_kon $04, BGM_wait $08
   BGM_data DSP_kon $04, BGM_pass
   BGM_data DSP_kon $04, BGM_wait $10
   BGM_data DSP_kon $04, BGM_wait $08
   BGM_data DSP_kon $04, BGM_pass
   BGM_data DSP_pitchh2 $04, BGM_data DSP_pitchl2 $00
   BGM_data DSP_kon $04, BGM_wait $10
   BGM_data DSP_kon $04, BGM_wait $08
   BGM_data DSP_kon $04, BGM_pass
   BGM_data DSP_kon $04, BGM_wait $10
   BGM_data DSP_kon $04, BGM_wait $08
   BGM_data DSP_kon $04, BGM_pass
   BGM_data DSP_pitchh2 $03, BGM_data DSP_pitchl2 $90
   BGM_data DSP_kon $04, BGM_wait $10
   BGM_data DSP_kon $04, BGM_wait $08
   BGM_data DSP_kon $04, BGM_pass
   BGM_data DSP_kon $04, BGM_wait $10
   BGM_data DSP_kon $04, BGM_wait $08
   BGM_data DSP_kon $04, BGM_pass

    BGM_wait $18
    BGM_data DSP_voll2   $7F, BGM_data DSP_volr2   $7F
   BGM_data DSP_pitchh2 $04, BGM_data DSP_pitchl2 $C1
   BGM_data DSP_kon $04, BGM_wait $08
    BGM_data DSP_voll2   $5F, BGM_data DSP_volr2   $5F
   BGM_data DSP_pitchh2 $05, BGM_data DSP_pitchl2 $A8
   BGM_data DSP_kon $04, BGM_wait $04
   BGM_data DSP_kon $04, BGM_pass
    BGM_data DSP_voll2   $7F, BGM_data DSP_volr2   $7F
   BGM_data DSP_pitchh2 $05, BGM_data DSP_pitchl2 $56
   BGM_data DSP_kon $04, BGM_wait $08
   BGM_data DSP_kon $04, BGM_pass
    BGM_data DSP_voll2   $5F, BGM_data DSP_volr2   $5F
   BGM_data DSP_pitchh2 $04, BGM_data DSP_pitchl2 $3C
   BGM_data DSP_kon $04, BGM_wait $08

   BGM_loop $02 $0D47

    BGM_data DSP_voll2   $7F  BGM_data DSP_volr2   $7F
   BGM_data DSP_pitchh2 $05, BGM_data DSP_pitchl2 $A8
   BGM_data DSP_kon $04, BGM_wait $10
    BGM_data DSP_voll2   $5F  BGM_data DSP_volr2   $5F
   BGM_data DSP_pitchh2 $06, BGM_data DSP_pitchl2 $59
   BGM_data DSP_kon $04, BGM_pass
    BGM_data DSP_voll2   $7F  BGM_data DSP_volr2   $7F
   BGM_data DSP_kon $04, BGM_pass
   BGM_data DSP_pitchh2 $05, BGM_data DSP_pitchl2 $A8
   BGM_data DSP_kon $04, BGM_pass

    BGM_data DSP_srcn2   $0B
    BGM_data DSP_adsrl2  $D8, BGM_data DSP_adsrh2  $B8, BGM_data DSP_gain2 $00

    BGM_wait $08
    BGM_data DSP_voll2   $7F, BGM_data DSP_volr2   $7F
   BGM_data DSP_pitchh2 $07, BGM_data DSP_pitchl2 $20
   BGM_data DSP_kon $04, BGM_wait $18
   BGM_data DSP_kon $04, BGM_pass
    BGM_data DSP_voll2   $5F, BGM_data DSP_volr2   $5F
   BGM_data DSP_kon $04, BGM_wait $48
    
   BGM_loop $03 $0DDA

    BGM_jump $0C5D

}

;# $0E03 Track 3: Snare
;# Size 0x4A bytes
;#Data l bgm.track3 {
    BGM_data DSP_srcn3   $0A
    BGM_data DSP_adsrl3  $D8, BGM_data DSP_adsrh3  $B8, BGM_data DSP_gain3 $00

    BGM_data DSP_voll3   $1F, BGM_data DSP_volr3   $1F
    BGM_wait $10
    BGM_data DSP_pitchh3 $03, BGM_data DSP_pitchl3 $83
   BGM_data DSP_kon $08, BGM_wait $20
   BGM_data DSP_kon $08, BGM_wait $20
   BGM_data DSP_kon $08, BGM_wait $20
   BGM_data DSP_kon $08, BGM_wait $08
   BGM_data DSP_kon $08, BGM_wait $04
   BGM_data DSP_kon $08, BGM_wait $04

    BGM_loop $0B $0E15

    BGM_wait $10
   BGM_data DSP_kon $08,  BGM_wait $10

    BGM_loop $0F $0E3F

    BGM_jump $0E15
}

;# $0E4D $Track 4: Kick
;# Size 0x2A bytes
;#Data l bgm.track4 {
    BGM_data DSP_srcn4   $08
    BGM_data DSP_adsrl4  $D8, BGM_data DSP_adsrh4  $B8, BGM_data DSP_gain4 $00

    BGM_data DSP_voll4   $1F, BGM_data DSP_volr4   $1F
    BGM_data DSP_pitchh4 $04, BGM_data DSP_pitchl4 $C1
    BGM_data DSP_kon     $10, BGM_wait $20
   BGM_data DSP_kon     $10, BGM_wait $08
   BGM_data DSP_kon     $10, BGM_wait $18

    BGM_jump $0E59
}

;# $0E77 Track 5: Hat
;# Size 0x22 bytes
;#Data l bgm.track5 {
    BGM_data DSP_srcn5   $09
    BGM_data DSP_adsrl5  $00, BGM_data DSP_adsrh5  $00, BGM_data DSP_gain5 $7F

    BGM_wait $08
   BGM_data DSP_voll5   $1F, BGM_data DSP_volr5   $1F
   BGM_data DSP_pitchh5 $09, BGM_data DSP_pitchl5 $83
   BGM_data DSP_kon     $20, BGM_wait $08

    BGM_jump $0E83
}
;#}

            ;# ===============================================================//
            ;#                                                                //
            ;#                                                                //
            ;#                                                                //
            ;# ===============================================================//
