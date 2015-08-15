;#{ PITCH for A440Hz instruments sampled at 32kHz

  A-5  A#5  B-5  C-5  C#5  D-5  D#5  E-5  F-5  F#5  G-5  G#5
  2000 21E7 23EB 260D 2851 2AB7 2D41 2FF2 32CB 35D1 3904 3C68

  A-4  A#4  B-4  C-4  C#4  D-4  D#4  E-4  F-4  F#4  G-4  G#4
  1000 10F3 11F5 1306 1428 155B 16A0 17F9 1965 1AE8 1C82 1E34

  A-3  A#3  B-3  C-3  C#3  D-3  D#3  E-3  F-3  F#3  G-3  G#3
  0800 0879 08FA 0983 0A14 0AAD 0B50 0BFC 0CB2 0D74 0E41 0F1A

  A-2  A#2  B-2  C-2  C#2  D-2  D#2  E-2  F-2  F#2  G-2  G#2
  0400 043C 047D 04C1 050A 0556 05A8 05FE 0659 06BA 0720 078D

  A-1  A#1  B-1  C-1  C#1  D-1  D#1  E-1  F-1  F#1  G-1  G#1
  0200 021E 023E 0260 0285 02AB 02D4 02FF 032C 035D 0390 03C6

;#}

;# $0400
;#Data l audio.dir0 { $0434 $0434 } // Silence
;#Data l audio.dir1 { $0458 $0458 } // A440Hz Sine
;#Data l audio.dir2 { $04A9 $04A9 } // A440Hz Triangle
;#Data l audio.dir3 { $04FA $04FA } // A440Hz Square
;#Data l audio.dir4 { $05AB $054B } // A440Hz Saw
;#Data l audio.dir5 { $0000 $0000 } // Bass
;#Data l audio.dir6 { $0000 $0000 } // Horn
;#Data l audio.dir7 { $0000 $0000 } // Pluck
;#Data l audio.dir8 { $0000 $0000 } // Kick
;#Data l audio.dir9 { $0000 $0000 } // Hat
;#Data l audio.dirA { $0000 $0000 } // Snare
;#Data l audio.dirB { $0000 $0000 } // Yo
;#Data l audio.dirC { $0000 $0000 } // Stab

;# $0434
;#Data l brr.silence { 
    $02 $00 $00 $00 $00 $00 $00 $00 $00
    $02 $00 $00 $00 $00 $00 $00 $00 $00
    $02 $00 $00 $00 $00 $00 $00 $00 $00
    $03 $00 $00 $00 $00 $00 $00 $00 $00
}

;# $0458
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

;# $04A9
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

;# $04FA
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

;# $054B
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

;# $059C
;#Data l bgm.track3 {
    BGM_time $FA $00
    
	BGM_data DSP_mvoll   $7F, BGM_data DSP_mvolr   $7F
    BGM_data DSP_flg     $20
    BGM_data DSP_pmon    $00
    BGM_data DSP_non     $00
    BGM_data DSP_eon     $00
    BGM_data DSP_dir     $04

    BGM_data DSP_voll3   $7F, BGM_data DSP_volr3   $7F
    BGM_data DSP_srcn3   $03
    BGM_data DSP_adsrl3  $DF, BGM_data DSP_adsrh3  $BC, BGM_data DSP_gain3 $00

    BGM_wait $10
    BGM_data DSP_pitchh3 $07, BGM_data DSP_pitchl3 $00
	BGM_data DSP_kon $08, BGM_wait $20
	BGM_data DSP_kon $08, BGM_wait $20
	BGM_data DSP_kon $08, BGM_wait $20
	BGM_data DSP_kon $08, BGM_wait $08
	BGM_data DSP_kon $08, BGM_wait $04
	BGM_data DSP_kon $08, BGM_wait $04

    BGM_loop $0B $05C6

    BGM_wait $10
	BGM_data DSP_kon $08,  BGM_wait $10

    BGM_loop $0F $05F0

    BGM_jump $05C6
}

;# $05FE
;# Size 0x2A bytes
;#Data l bgm.track4 {
    BGM_data DSP_voll4   $7F, BGM_data DSP_volr4   $7F
    BGM_data DSP_srcn4   $01
    BGM_data DSP_adsrl4  $DB, BGM_data DSP_adsrh4  $99, BGM_data DSP_gain4 $00

    BGM_data DSP_pitchh4 $04, BGM_data DSP_pitchl4 $00
    BGM_data DSP_kon     $10, BGM_wait $20
	BGM_data DSP_kon     $10, BGM_wait $08
	BGM_data DSP_kon     $10, BGM_wait $18

    BGM_jump $0616
}

;# $0628
;# Size 0x22 bytes
;#Data l bgm.track5 {
	BGM_data DSP_voll5   $6F, BGM_data DSP_volr5   $6F
    BGM_data DSP_srcn5   $01
    BGM_data DSP_adsrl5  $FF, BGM_data DSP_adsrh5  $3F, BGM_data DSP_gain5 $00

    BGM_wait $08
	BGM_data DSP_pitchh5 $2F, BGM_data DSP_pitchl5 $00
	BGM_data DSP_kon     $20, BGM_wait $08

    BGM_jump $063A
}








;#{
// $0600
;#Data bgm.track0 {
    BGM_time $FA $00
	

    BGM_data DSP_mvoll   $7F
    BGM_data DSP_mvolr   $7F
    BGM_data DSP_flg     $20
    BGM_data DSP_pmon    $00
    BGM_data DSP_non     $00
    BGM_data DSP_eon     $00
    BGM_data DSP_dir     $04

    BGM_data DSP_pitchl0 $00
    BGM_data DSP_scrn0   $05
    BGM_data DSP_adsrl0  $00
    BGM_data DSP_adsrh0  $00
    BGM_data DSP_gain0   $7F

    BGM_data DSP_voll0   $3F, BGM_data DSP_volr0   $3F
	BGM_data DSP_pitchl0 $??, BGM_data DSP_pitchh0 $??
	BGM_data DSP_kon     $01, BGM_wait $02
	BGM_data DSP_pitchl0 $??, BGM_data DSP_pitchh0 $??
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_pitchl0 $??, BGM_data DSP_pitchh0 $??
	BGM_data DSP_kon     $01, BGM_wait $04
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_pitchl0 $??, BGM_data DSP_pitchh0 $??
	BGM_data DSP_kon     $01, BGM_wait $02
	BGM_data DSP_pitchl0 $??, BGM_data DSP_pitchh0 $??
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_pitchl0 $??, BGM_data DSP_pitchh0 $??
	BGM_data DSP_kon     $01, BGM_wait $04
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_kon     $01, BGM_wait $08
	BGM_data DSP_pitchl0 $??, BGM_data DSP_pitchh0 $??
	BGM_data DSP_kon     $01, BGM_wait $02
	BGM_data DSP_pitchl0 $??, BGM_data DSP_pitchh0 $??
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_pitchl0 $??, BGM_data DSP_pitchh0 $??
	BGM_data DSP_kon     $01, BGM_wait $04
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_pitchl0 $??, BGM_data DSP_pitchh0 $??
	BGM_data DSP_kon     $01, BGM_wait $02
	BGM_data DSP_pitchl0 $??, BGM_data DSP_pitchh0 $??
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_pitchl0 $??, BGM_data DSP_pitchh0 $??
	BGM_data DSP_kon     $01, BGM_wait $04
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_pitchl0 $??, BGM_data DSP_pitchh0 $??
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_pitchl0 $??, BGM_data DSP_pitchh0 $??
	BGM_data DSP_kon     $01, BGM_pass

	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $02
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	BGM_data DSP_kon     $01, BGM_wait $04
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $02
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	BGM_data DSP_kon     $01, BGM_wait $04
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $08
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $02
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $04
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0 $5F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0 $7F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0 $5F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0 $7F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass

	BGM_loop $01 $????

    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0 $7F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $08
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0 $5F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $02
	BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0 $7F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $04
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
    BGM_data DSP_voll0   $3F, BGM_data DSP_volr0 $3F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $08
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0 $5F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $02
    BGM_data DSP_voll0   $3F, BGM_data DSP_volr0 $3F
	BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0 $5F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $04
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass

	BGM_loop $03 $????
	
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $08
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_kon     $01, BGM_wait $04
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $08
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_kon     $01, BGM_wait $04
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass

	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $08
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_kon     $01, BGM_wait $04
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $08
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_kon     $01, BGM_wait $04
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	
	BGM_loop $01 $????

    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0 $7F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $04
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0 $5F
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $02
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0 $7F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $06
	BGM_data DSP_kon     $01, BGM_wait $04
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0 $5F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $02
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
    BGM_data DSP_voll0   $3F, BGM_data DSP_volr0 $3F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_wait $04
    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0 $7F
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_kon     $01, BGM_pass
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0 $5F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0 $7F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
    BGM_data DSP_voll0   $5F, BGM_data DSP_volr0 $5F
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
    BGM_data DSP_voll0   $7F, BGM_data DSP_volr0 $7F
	BGM_data DSP_kon     $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	BGM_data DSP_pitchh0 $??, BGM_data DSP_kon   $01, BGM_pass
	
	BGM_loop $03 $????
	
	BGM_jump $????
}

;#Data bgm.track1 {
	BGM_data DSP_pitchl1 $00
    BGM_data DSP_scrn1   $?? // Pluck
    BGM_data DSP_adsrl1  $00
    BGM_data DSP_adsrh1  $00
    BGM_data DSP_gain1   $7F

    BGM_data DSP_voll1 $7F  BGM_data DSP_volr1 $7F
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $08
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $08
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $08
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $08
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass

	BGM_loop $01 $????

	BGM_data DSP_pitchl1 $00
    BGM_data DSP_scrn1   $?? // Horn
    BGM_data DSP_adsrl1  $00
    BGM_data DSP_adsrh1  $00
    BGM_data DSP_gain1   $7F

	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $08
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $02
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $08
	BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $02
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $02
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $04

	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $08
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $02
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $02
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $18
	
	BGM_loop $01 $????

    BGM_data DSP_voll1 $5F  BGM_data DSP_volr1 $5F
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $08
	BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_kon $02  BGM_wait $08
	BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $08
	BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_kon $02  BGM_wait $08
	BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_kon $02  BGM_pass
	
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $08
	BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_kon $02  BGM_wait $08
	BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_pitchh1 $??  BGM_data DSP_kon $02  BGM_wait $08
	BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_kon $02  BGM_pass
	BGM_data DSP_kon $02  BGM_wait $08
	BGM_data DSP_kon $02  BGM_wait $04
	BGM_data DSP_kon $02  BGM_pass

	BGM_loop $01 $????

	BGM_jump $????

} Track 5/7

;#Data bgm.track2 {
    BGM_data DSP_pitchl2 $00
    BGM_data DSP_scrn2   $?? // Stab
    BGM_data DSP_adsrl2  $00
    BGM_data DSP_adsrh2  $00
    BGM_data DSP_gain2   $7F

    BGM_data DSP_voll2   $7F  BGM_data DSP_volr2   $7F
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_wait $0C
	BGM_data DSP_kon $04  BGM_wait $34

    BGM_loop $03 $????

    BGM_data DSP_voll2   $7F  BGM_data DSP_volr2   $7F
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_wait $70
    BGM_data DSP_voll2   $3F  BGM_data DSP_volr2   $3F
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_wait $08
	BGM_data DSP_kon $04  BGM_pass

	BGM_loop $01 $????

    BGM_data DSP_pitchl2 $00
    BGM_data DSP_scrn2   $?? // Pluck
    BGM_data DSP_adsrl2  $00
    BGM_data DSP_adsrh2  $00
    BGM_data DSP_gain2   $7F

    BGM_data DSP_voll2   $5F  BGM_data DSP_volr2   $5F
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_wait $08
	BGM_data DSP_kon $04  BGM_wait $04
	BGM_data DSP_kon $04  BGM_pass
	BGM_data DSP_kon $04  BGM_wait $08
	BGM_data DSP_kon $04  BGM_wait $04
	BGM_data DSP_kon $04  BGM_pass
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_wait $08
	BGM_data DSP_kon $04  BGM_wait $04
	BGM_data DSP_kon $04  BGM_pass
	BGM_data DSP_kon $04  BGM_wait $08
	BGM_data DSP_kon $04  BGM_wait $04
	BGM_data DSP_kon $04  BGM_pass
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_wait $08
	BGM_data DSP_kon $04  BGM_wait $04
	BGM_data DSP_kon $04  BGM_pass
	BGM_data DSP_kon $04  BGM_wait $08
	BGM_data DSP_kon $04  BGM_wait $04
	BGM_data DSP_kon $04  BGM_pass
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_wait $08
	BGM_data DSP_kon $04  BGM_wait $04
	BGM_data DSP_kon $04  BGM_pass
	BGM_data DSP_kon $04  BGM_wait $08
	BGM_data DSP_kon $04  BGM_wait $04
	BGM_data DSP_kon $04  BGM_pass

    BGM_wait $0C
    BGM_data DSP_voll2   $7F  BGM_data DSP_volr2   $7F
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_wait $04
    BGM_data DSP_voll2   $5F  BGM_data DSP_volr2   $5F
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_wait $02
	BGM_data DSP_kon $04  BGM_pass
    BGM_data DSP_voll2   $7F  BGM_data DSP_volr2   $7F
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_wait $04
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_pass
    BGM_data DSP_voll2   $5F  BGM_data DSP_volr2   $5F
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_wait $04

	BGM_loop $02 $????

    BGM_data DSP_voll2   $7F  BGM_data DSP_volr2   $7F
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_wait $08
    BGM_data DSP_voll2   $5F  BGM_data DSP_volr2   $5F
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_pass
    BGM_data DSP_voll2   $7F  BGM_data DSP_volr2   $7F
	BGM_data DSP_kon $04  BGM_pass
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_pass

    BGM_data DSP_pitchl2 $00
    BGM_data DSP_scrn2   $?? // Yo
    BGM_data DSP_adsrl2  $00
    BGM_data DSP_adsrh2  $00
    BGM_data DSP_gain2   $7F

    BGM_wait $04
    BGM_data DSP_voll2   $7F  BGM_data DSP_volr2   $7F
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_wait $0C
	BGM_data DSP_kon $04  BGM_pass
    BGM_data DSP_voll2   $5F  BGM_data DSP_volr2   $5F
	BGM_data DSP_pitchh2 $??  BGM_data DSP_kon $04  BGM_wait $24
    
	BGM_loop $03 $????

    BGM_jump $????

}

;# Track 3: Snare
;# Size 0x4A bytes
;#Data bgm.track3 {
    BGM_data DSP_voll3   $7F, BGM_data DSP_volr3   $7F
    BGM_data DSP_srcn3   $0A
    BGM_data DSP_adsrl3  $??, BGM_data DSP_adsrh3  $??, BGM_data DSP_gain3 $??

    BGM_wait $10
    BGM_data DSP_pitchh3 $13, BGM_data DSP_pitchl3 $06
	BGM_data DSP_kon $08, BGM_wait $20
	BGM_data DSP_kon $08, BGM_wait $20
	BGM_data DSP_kon $08, BGM_wait $20
	BGM_data DSP_kon $08, BGM_wait $08
	BGM_data DSP_kon $08, BGM_wait $04
	BGM_data DSP_kon $08, BGM_wait $04

    BGM_loop $0B $base+0x12

    BGM_wait $10
	BGM_data DSP_kon $08,  BGM_wait $10

    BGM_loop $0F $base+0x3C

    BGM_jump $base+0x12
}

;# Track 4: Kick
;# Size 0x2A bytes
;#Data l bgm.track4 {
    BGM_data DSP_voll4   $7F, BGM_data DSP_volr4   $7F
    BGM_data DSP_srcn4   $08
    BGM_data DSP_adsrl4  $??, BGM_data DSP_adsrh4  $??, BGM_data DSP_gain4 $00

    BGM_data DSP_pitchh4 $09, BGM_data DSP_pitchl4 $83
    BGM_data DSP_kon     $10, BGM_wait $20
	BGM_data DSP_kon     $10, BGM_wait $08
	BGM_data DSP_kon     $10, BGM_wait $18

    BGM_jump $base+0x18
}

;# Track 5: Hat
;# Size 0x22 bytes
;#Data l bgm.track5 {
	BGM_data DSP_voll5   $7F, BGM_data DSP_volr5   $7F
    BGM_data DSP_srcn5   $09
    BGM_data DSP_adsrl5  $??, BGM_data DSP_adsrh5  $??, BGM_data DSP_gain5 $??

    BGM_wait $08
	BGM_data DSP_pitchh5 $13, BGM_data DSP_pitchl5 $06
	BGM_data DSP_kon     $20, BGM_wait $08

    BGM_jump $base+0x12
}

;#}
