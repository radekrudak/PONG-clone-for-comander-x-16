
low_bound =  16
check_lower_bound:
    lda ball_y
    BPL @end_of_check

    ; cmp #low_bound
    ; bcs @end_of_check ; if ball_y > 8 go to @end_of_update or..
    ; lda ball_y
    ; cmp #0
    ; bne @end_of_check ; if ball_y != 0 go to @end_of_update else
    lda #ball_default_velocity ;bump baLL
    sta ball_velocity+1
@end_of_check:
    rts