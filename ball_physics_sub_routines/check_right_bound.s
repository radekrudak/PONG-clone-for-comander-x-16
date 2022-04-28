check_right_bound:
;check if ball x is higher than player2 x + 16
;boundry check
    lda ball_x
    cmp #.lobyte(player2_x)+16
    bcc @end_of_check_right_bound
    lda ball_x+1
    cmp #.hibyte(player2_x)
    bcc @end_of_check_right_bound
;adding point for player 1
    lda player1_points
    clc
    sed
    adc #1
    sta player1_points
    cld
;reseting ball

    jsr reset_ball
@end_of_check_right_bound:
    rts