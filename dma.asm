	;# DMA =============================================================
	
	;#Code l {Immediate_DMA}
	;PHP
	;PHB
	;SEP #$20
	;LDA $05,S
	;PHA
	;PLB
	;REP #$20
	;LDA $03,S
	;INC A
	;TAX
	;LDA $0000,X
	;STA DMAP
	;LDA $0002,X
	;STA DMAA.l
	;LDA $0004,X
	;STA DMAA.b
	;SEP #$20
	;LDA $0006,X
	;STA DMAD.h
	;LDA #$01
	;STA MDMAEN
	;REP #$20
	;TXA
	;CLC
	;ADC #$0006
	;STA $03,S
	;PLB
	;PLP
	;RTL
	
