init_text_mode:
;fills screen with black by seting background and foreground color of characters to black
    lda #1
    sta VERA_addrsL
    lda #$B0
    sta VERA_addrsM
    lda #$21
    sta VERA_addrsH
    ldx #0
    ldy #0
    lda #0
@filling_loop:
;fills loop with black
    ;{
    sta VERA_data0
    inx 
    cpx #89
    bne @filling_loop
    iny
    cpy #31
    bne @filling_loop
    ;}


    lda #$26
    sta VERA_addrsL
    lda #$B3
    sta VERA_addrsM
    lda #$11
    sta VERA_addrsH
    lda #$30
    sta VERA_data0
    lda #$01
    sta VERA_data0
    lda #$30
    sta VERA_data0
    lda #$01
    sta VERA_data0

    lda #$74
    sta VERA_addrsL
    lda #$B3
    sta VERA_addrsM
    lda #$11
    sta VERA_addrsH
    lda #$30
    sta VERA_data0
    lda #$01
    sta VERA_data0
    lda #$30    
    sta VERA_data0
    lda #$01
    sta VERA_data0    


    rts