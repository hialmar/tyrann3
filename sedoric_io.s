
#define SwitchOutROM $04f2
#define SwitchInROM  $04f2

; the same as in cpzerop.s
#define CopyZeroPage  $b800

_SPStorage .dsb 1

_BackupSP
.(
	tsx
	stx _SPStorage
	rts
.)

_DiscSave
.(
  sei ; disable interrupts
  ldy #0
  lda (sp),y ; Filename lo
  sta $e9
  iny
  lda (sp),y ; Filename hi
  sta $ea

  jsr SwitchOutROM ; enable OverlayRAM
  lda #$00
  jsr $d454 ; verify filename and copy it to BUFNOM

  ;Setup Areas
  ldy #2
  lda (sp),y ;Start Address Lo
  sta $c052
  iny
  lda (sp),y ;Start Address Hi
  sta $c053
  iny
  lda (sp),y ;End Address Lo
  sta $c054
  iny
  lda (sp),y ;End Address Hi
  sta $c055

  lda #$c0
  sta $c04d ; #C0 here means SAVEU (use 0 for SAVEO) !
  lda #$00
  sta $c04e ; 0 here means no params
  lda #$40  ; file type - data and no auto
  sta $c051
  jsr $de0b ; set LGSAL0 and call XSAVEB
  jsr SwitchInROM ; disable Overlay RAM
  cli ; re-enable interrupts
  ldx $04fd ; Get result (low byte)
  lda #0   ; Get result (high byte)
  rts
.)


_DiscLoad
.(
  sei ; disable interrupts
  ldy #0
  lda (sp),y ; Filename lo
  sta $e9
  iny
  lda (sp),y ; Filename hi
  sta $ea
  ;
  jsr SwitchOutROM ; enable OverlayRAM

  lda #00
  jsr $dff9  ; verify filename and load file
  jsr SwitchInROM ; disable OverlayRAM
  cli ; re-enable interrupts
  ldx $04fd ; Get result (low byte)
  lda #0   ; Get result (high byte)
  rts
.)

_Sedoric    ; invoke a SEDORIC command using black magic
.(          ; Watch it! I have reasons to believe this is broken
  ldy #$0         ; grab string pointer
  lda (sp),y
  sta tmp
  iny
  lda (sp),y
  sta tmp+1
  dey

sedoricloop1            ; copy the string to #35..#84
  lda (tmp),y
  sta $35,y
  iny
  ora #$0
  bne sedoricloop1
  lda #$0       ; terminate with a 0
  sta $35,y

  sta $ea         ; update the line start pointer
  lda #$35;
  sta $e9

  jsr $00e2       ; get next token
  jmp ($02f5)     ; call the ! command handler
.)


_SwitchToCommand
.(
	ldy #$0         ; grab string pointer
	lda (sp),y
	sta tmp
	iny
	lda (sp),y
	sta tmp+1
	dey

sedoricloop2            ; copy the string to #35..#84
	lda (tmp),y
	sta $35,y
	iny
	ora #$0
	bne sedoricloop2
	lda #$0				; terminate with a 0
	sta $35,y
	
	ldx #$fe			; re-init stack
	;ldx _SPStorage		; restore the stack
	txs
	
	ldx #$34
	ldy #$00
	
	jmp $c4bd ; call the interpreter
.)

; _SwitchToCommand
; .(
;   ldy #$0         ; grab string pointer
;   lda (sp),y
;   sta sedoricloop2+1  ; patch low byte bellow ($1234)
;   iny
;   lda (sp),y
;   sta sedoricloop2+2 ; patch low byte bellow ($1234)
; 
; ;  ldy #0          ; restore zero page
; ;zploop
; ;  lda CopyZeroPage,y
; ;  sta $00,y
; ;  iny
; ;  bne zploop
;   
; sedoricloop2      ; copy the string to #35..#84
;   lda $1234,y     ; $1234 is fake - just placeholder, actually it is the str ptr
;   sta $35,y
;   iny
;   ora #$0
;   bne sedoricloop2
;   
;   ; it is already 0-terminated
;   ; lda #$0       ; terminate with a 0
;   ; sta $35,y
; 
;   ldx #$34
;   ldy #$00
; 
;   jsr $c4bd ; call the interpreter
;   rts  ; will never be called
; .)
