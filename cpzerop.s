#define CopyZeroPage  $b800
#define Text          $ec21
#define Cls           $ccce

.text

* = $600

entry
    jsr Text
    jsr Cls

    ldy #0
loop
    lda $00,y
    sta CopyZeroPage,y
    iny
    bne loop
    rts
