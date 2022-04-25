;adds velocity vector to ball's y and x coordinates
update_ball:
; add x of vector to x posytion of ball
    
    lda ball_x ; load low side of x
    clc
    adc ball_velocity 
    sta ball_x 
    lda ball_x+1 ;load high side of x
    adc #0
    sta ball_x+1
; add y of vector to y posytion of ball    
    lda ball_velocity+1
    bmi @y_vector_is_negative ; if ball_velocity's y is negative go to  @y_vector_is_negative
    ;else just add vector's y to ball's y 
    lda ball_y
    clc
    adc ball_velocity+1
    sta ball_y
    lda ball_y+1
    adc #0
    sta ball_y+1
    jmp @check_upper_bound 
@temp_accumulator:
    .byte 0
@y_vector_is_negative: ; if velocity vector's y is negative, take first 4 bits of it and subtract them from ball'sy 
    and #$F
    sta @temp_accumulator
    lda ball_y
    sec
    sbc @temp_accumulator
    sta ball_y
    lda ball_y+1
    sbc #0
    sta ball_y+1

@check_upper_bound:

;collysion cheking 

; if ball_y > 0x01a0 : turn velocity_y's sign bit on 
    lda ball_y
    cmp #$d4 ; if ball's x lower bits are  > $d8
    lda #0 
    adc #0 
    tay ;store one at y
    lda ball_y+1
    cmp #1 ; if ball's x higher bits are  > $1
    tya ; transfer y to a
    adc #0 ; add one (caryy) to y
    cmp #2 ;if result < 2 
    bcc @check_lower_bound ; jump to end of subroutine
    lda #$80+ball_default_velocity ;else bump ball
    sta ball_velocity+1
    jmp @end_of_update
; if ball_y is smaller than lower bound
@low_bound =  8

@check_lower_bound:
    lda ball_y
    cmp #@low_bound
    bcs @end_of_update ; if ball_y > 8 go to @end_of_update or..
    lda ball_y
    cmp #0
    bne @end_of_update ; if ball_y != 0 go to @end_of_update else
    lda #ball_default_velocity ;bump baLL
    sta ball_velocity+1

@end_of_update:
    rts
    ; jmp (Default_irq_handler)
