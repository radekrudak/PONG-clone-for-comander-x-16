
check_colysion_with_p1:
    lda ball_x
    cmp #.lobyte(player1_x)
    bcs @end_of_check_colysion_with_p1

    lda ball_x+1
    cmp #.hibyte(player1_x)
    bcs @end_of_check_colysion_with_p1
    lda #ball_default_velocity
    sta ball_velocity

@end_of_check_colysion_with_p1:
    rts
