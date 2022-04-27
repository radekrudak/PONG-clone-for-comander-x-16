
check_colysion_with_p1:
    lda player1y
    sec 
    sbc #8
    sta @tmp_player_y
    lda player1y+1
    sbc #0
    sta @tmp_player_y+1
;check if ball's x is within range ofp layer 2 x
    ; if ball_y < @tmp_player_y go to @end_of_check_colysion_with_p1
    lda ball_y
    sec
    sbc @tmp_player_y
    sta @tmp_player_y
    lda ball_y+1
    sbc @tmp_player_y+1
    bne @end_of_check_colysion_with_p1
    bcc @end_of_check_colysion_with_p1
    lda @tmp_player_y
    cmp #64
    bcs @end_of_check_colysion_with_p1




    lda #.lobyte(player1_x) 
    cmp ball_x
    bcc @end_of_check_colysion_with_p1

    lda #.hibyte(player1_x)
    cmp ball_x+1
    bcc @end_of_check_colysion_with_p1
    lda #ball_default_velocity
    sta ball_velocity

@end_of_check_colysion_with_p1:
    rts
@tmp_player_y:
    .word $0