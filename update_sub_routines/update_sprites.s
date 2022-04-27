update_sprites:
    ;update player 1 sprite 
    lda #.lobyte(player1_x)
    sta r0
    lda #.hibyte(player1_x)
    sta r0+1
    lda playersy
    sta r1
    lda playersy+1
    sta r1+1
    lda #0
    
    jsr $FEF3 ;sprite_set_position KERNAL call
    ldx playersy+2
    ldy playersy+3
    ; update player 2 sprite
    lda #.lobyte(player2_x) ; $68
    sta r0
    lda #.hibyte(player2_x); #$2
    sta r0+1
    lda playersy+2
    sta r1
    lda playersy+3
    sta r1+1
    lda #1
    
    jsr $FEF3 ;sprite_set_position KERNAL call

    ; update ball sprite
    lda ball_x_y
    sta r0
    lda ball_x_y+1
    sta r0+1
    lda ball_x_y+2
    sta r1
    lda ball_x_y+3
    sta r1+1
    lda #2
    
    jsr $FEF3 ;sprite_set_position KERNAL call


    rts