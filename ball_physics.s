
.include "./ball_physics_sub_routines/check_lower_bound.s"
.include "./ball_physics_sub_routines/check_upper_bound.s"
.include "./ball_physics_sub_routines/check_colysion_with_p2.s"
.include "./ball_physics_sub_routines/check_colysion_with_p1.s"
.include "./ball_physics_sub_routines/check_right_bound.s"
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
    jmp @update_y
@x_vector_is_negative:
    and #$F
    sta @temp_accumulator 
    lda ball_x ; load low side of x
    sec
    sbc @temp_accumulator 
    sta ball_x 
    lda ball_x+1 ;load high side of x
    sbc #0
    sta ball_x+1 


@update_y:

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

    lda ball_y+1
    bmi @lower_bound_hit
    cmp #1
    bcc @check_lower_bound
    lda ball_y
    cmp #$D0
    bcc @check_lower_bound
    lda #ball_default_velocity+$80 ;bump baLL
    sta ball_velocity+1
    jmp  @check_lower_bound
@lower_bound_hit:
    lda #ball_default_velocity ;bump baLL
    sta ball_velocity+1

@check_lower_bound:
   ; jsr check_lower_bound
    jsr check_right_bound
    jsr check_colysion_with_p1
    jsr check_colysion_with_p2




@end_of_update:
    rts
    ; jmp (Default_irq_handler)


