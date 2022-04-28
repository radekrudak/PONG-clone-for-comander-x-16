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
    bcc @check_vertical_bounds
    lda ball_y
    cmp #$D0
    bcc @check_vertical_bounds
    lda #ball_default_velocity+$80 ;bump baLL
    sta ball_velocity+1
    jmp  @check_vertical_bounds
@lower_bound_hit:
    lda #ball_default_velocity ;bump baLL
    sta ball_velocity+1

@check_vertical_bounds:

    lda ball_x+1
    bpl @chceck_right_bound
    ; if ball x is negative add point and reset it's posytion 
    ;adding point for player 1
    lda player2_points
    clc
    sed
    adc #1
    sta player2_points
    cld
    ;reset ball
    jsr reset_ball


@chceck_right_bound:
    jsr check_right_bound

    jsr check_colysion_with_p2
    jsr check_colysion_with_p1

@end_of_update:
    rts
    ; jmp (Default_irq_handler)
@tmp_ball_y:
    .word 0

reset_ball:
    lda #.lobyte(ball_default_x)
    sta ball_x
    lda #.hibyte(ball_default_x)
    sta ball_x+1

    lda #.lobyte(ball_default_y)
    sta ball_y
    lda #.hibyte(ball_default_y)
    sta ball_y+1

    lda #ball_default_velocity
    sta ball_velocity
    sta ball_velocity+1
