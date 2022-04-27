
check_colysion_with_p2:
;converts origin of ball from left up to center 
    lda ball_x
    cmp #.lobyte(player2_x)
    bcc @end_of_check_colysion_with_p2
    lda ball_x+1
    cmp #.hibyte(player2_x)
    bcc @end_of_check_colysion_with_p2
    lda #.lobyte(ball_default_velocity)+$80
    sta ball_velocity

@end_of_check_colysion_with_p2: 
    rts 

@tmp_ball_x:
    .word 0