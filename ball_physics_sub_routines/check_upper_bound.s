; if ball_y > 0x01a0 : turn velocity_y's sign bit on 
; if upper bond is hit it returns 2 in acumulator
check_upper_bound:
    lda ball_y
    cmp #$d4 ; if ball's x lower bits are  > $d8
    lda #0 
    adc #0 
    tay ;store one at y
    lda ball_y+1
    cmp #1 ; if ball's x higher bits are  > $1
    tya ; transfer y to a
    adc #0 ; add one (caryy) to y
    rts