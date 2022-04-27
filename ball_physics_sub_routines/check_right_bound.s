check_right_bound:
;check if ball x is higher than player2 x + 16
    lda ball_x
    cmp #.lobyte(player2_x)+16
    bcc @end_of_check_right_bound
    lda ball_x+1
    cmp #.hibyte(player2_x)
    bcc @end_of_check_right_bound
    ; if ball x is higher add point and reset it's posytion 
    lda #.lobyte(ball_default_x)
    sta ball_x
    lda #.hibyte(ball_default_x)
    sta ball_x+1

    lda #.lobyte(ball_default_y)
    sta ball_y
    lda #.hibyte(ball_default_y)
    sta ball_y+1

    lda #ball_default_velocity
    sta ball_velocity
    sta ball_velocity+1

@end_of_check_right_bound:
    rts