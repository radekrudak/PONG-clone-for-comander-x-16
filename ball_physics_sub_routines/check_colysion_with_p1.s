
check_colysion_with_p1:
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
