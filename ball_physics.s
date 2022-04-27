
.include "./ball_physics_sub_routines/check_lower_bound.s"
.include "./ball_physics_sub_routines/check_upper_bound.s"
;adds velocity vector to ball's y and x coordinates
update_ball:
; add x of vector to x posytion of ball
    
    lda ball_velocity
    bmi @x_vector_is_negative; if ball'x x velocity is negative jumpt to @x_vector_is_negative
    lda ball_x ; load low side of x
    clc
    adc ball_velocity 
    sta ball_x 
    lda ball_x+1 ;load high side of x
    adc #0
    sta ball_x+1
@x_vector_is_negative:
    




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

    jsr check_upper_bound ; if ball hits upper boud this sub rt. returns 2 in A reg 
    cmp #2 ;if result < 2 
    bcc @check_lower_bound ; check lower bond
    lda #$80+ball_default_velocity ;else bump ball
    sta ball_velocity+1
    jmp @end_of_update


@check_lower_bound:
    jsr check_lower_bound
    jsr check_colysion_with_p1


@end_of_update:
    rts
    ; jmp (Default_irq_handler)


