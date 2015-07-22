TableBit
    .byt 1,2,4,8,16,32,64,128

; common code
; loads the bit number to apply/test in X and the array offset in Y
calculXY
	; k is already in A lda tmp1 ; load k
	lsr ; divide A by 8
	lsr
	lsr
	tay ; offset in array
	lda tmp1 ; reload k
	and #%111 ; A mod 8
	tax ; transfers the result to x
	rts

; extern void  SetBit( unsigned char A[ ],  unsigned char k );
_SetBit
.(
	ldy #0
	lda (sp),y ; A lo
	sta tmp0
	iny
	lda (sp),y ; A hi
	sta tmp0+1
	iny
	lda (sp),y ; k
	sta tmp1
	jsr calculXY
	lda (tmp0),y
	ora TableBit,x
	sta (tmp0),y
	rts 
.)

; extern void  InvertBit( unsigned char A[ ],  unsigned char k );
_InvertBit
.(
	ldy #0
	lda (sp),y ; A lo
	sta tmp0
	iny
	lda (sp),y ; A hi
	sta tmp0+1
	iny
	lda (sp),y ; k
	sta tmp1
	jsr calculXY
	lda (tmp0),y
	eor TableBit,x
	sta (tmp0),y
	rts 
.)

; extern unsigned char TestBit( unsigned char A[ ],  unsigned char k );
_TestBit
.(
	ldy #0
	lda (sp),y ; A lo
	sta tmp0
	iny
	lda (sp),y ; A hi
	sta tmp0+1
	iny
	lda (sp),y ; k
	sta tmp1
	jsr calculXY
	lda (tmp0),y
	and TableBit,x
	tax ; result in x
	lda #0 ; high byte should be 0 ?
	rts 
.)

