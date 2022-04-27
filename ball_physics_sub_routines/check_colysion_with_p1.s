
check_colysion_with_p1:
;     lda player1y
;     sec 
;     sbc #8
;     sta @tmp_player_y
;     lda player1y+1
;     sbc #1
;     sta @tmp_player_y+1
; ;check if ball's x is within range ofp layer 2 x
;     ; if ball_y < @tmp_player_y go to @end_of_check_colysion_with_p1
;     lda ball_y 
;     cmp @tmp_player_y
;     bcc @end_of_check_colysion_with_p1
;     lda ball_y+1
;     cmp @tmp_player_y+1
;     bcs @end_of_check_colysion_with_p1 

;     ; if ball_y > @tmp_player_y +16 @end_of_check_colysion_with_p1
;     ;add to @tmp_player_y 16

;     lda @tmp_player_y
;     clc 
;     adc #64+8
;     sta @tmp_player_y
;     lda @tmp_player_y+1
;     adc #1
;     sta @tmp_player_y+1

;     lda @tmp_player_y
;     cmp ball_y
;     bcc @end_of_check_colysion_with_p1

;     lda @tmp_player_y+1
;     cmp ball_y+1
;     bcc @end_of_check_colysion_with_p1



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