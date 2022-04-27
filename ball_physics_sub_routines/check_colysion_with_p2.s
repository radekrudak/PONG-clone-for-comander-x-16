
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
    sec
    sbc @tmp_player_y
    sta @tmp_player_y
    lda ball_y+1
    sbc @tmp_player_y+1
    bne @end_of_check_colysion_with_p2
    bcc @end_of_check_colysion_with_p2
    lda @tmp_player_y
    cmp #64
    bcs @end_of_check_colysion_with_p2

    



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