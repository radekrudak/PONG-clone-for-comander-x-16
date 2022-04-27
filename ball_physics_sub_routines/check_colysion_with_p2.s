
check_colysion_with_p2:
    lda player2y
    sec 
    sbc #8
    sta @tmp_player_y
    lda player2y+1
    sbc #0
    sta @tmp_player_y+1
;check if ball's x is within range ofp layer 2 x
    ; if ball_y < @tmp_player_y go to @end_of_check_colysion_with_p2
    lda ball_y 
    cmp @tmp_player_y
    bcc @end_of_check_colysion_with_p2
    lda ball_y+1
    cmp @tmp_player_y+1
    bcs @end_of_check_colysion_with_p2 

    ; if ball_y > @tmp_player_y +16 @end_of_check_colysion_with_p2
    ;add to @tmp_player_y 16

    lda @tmp_player_y
    clc 
    adc #64+8
    sta @tmp_player_y
    lda @tmp_player_y+1
    adc #1
    sta @tmp_player_y+1

    lda @tmp_player_y
    cmp ball_y
    bcc @end_of_check_colysion_with_p2

    lda @tmp_player_y+1
    cmp ball_y+1
    bcc @end_of_check_colysion_with_p2


;check if ball x is higher than player2 x
    lda ball_x
    cmp #.lobyte(player2_x)-8
    bcc @end_of_check_colysion_with_p2
    lda ball_x+1
    cmp #.hibyte(player2_x)
    bcc @end_of_check_colysion_with_p2
    lda #.lobyte(ball_default_velocity)+$80
    sta ball_velocity

@end_of_check_colysion_with_p2: 
    rts 

@tmp_player_y:
    .word 0