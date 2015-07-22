; 	// adresse table decompressee  
;   doke(0,0x7000);                     
;   // adresse ecran               
;   doke(2,ac);
;
; void affimage()
_affimage
.(
        LDX #$00
affimage_begin
	    LDY #$00
affimage_loop1
        LDA ($00),Y
        STA ($02),Y
        INY 
        CPY #$12
        BNE affimage_loop1
        CLC 
        LDA $00
        ADC #$12
        STA $00
        BCC affimage_mid
        INC $01
        CLC 
affimage_mid
        LDA $02
        ADC #$28
        STA $02
        BCC affimage_last
        INC $03
affimage_last
        INX 
        CPX #$C8
        BNE affimage_begin
        RTS 
.)
