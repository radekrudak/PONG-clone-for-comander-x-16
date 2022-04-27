tmp_acumulator:
    .word 0
check_colysion_with_p2:
;converts origin of ball from left up to center 
    lda ball_x
    stc
    sbc #8
    sta tmp_acumulator
    lda ball_x+1
    sbc 
    sta tmp_acumulator+1
    
    lda tmp_acumulator
    cmp player1y
    lda #0
    adc #0
    tay
    lda tmp_acumulator+1
    cmp player1y+1
    tya 
    adc #0
    cmp #2
    bne @end_of_check_colysion_with_p2
    lda #ball_default_velocity+128
    sta ball_velocity
@end_of_check_colysion_with_p2: 
    rts 