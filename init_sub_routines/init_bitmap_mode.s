init_bitmap_mode:
    ;set bit map mode
    ldx #0 ;set index to zero 

@VERA_load_loop:
    lda layer0_cfg,x ; load a with byte from layer0_cfg "array" with x reg as index/offset
    sta layer0_cfg_addrs,x ;store a to VERA regs with x as offset
    cpx #7  ;if x ie. index is equal to seve
    beq end_of_VERA_load_loop ; jump to end_of_VERA_load_loop label
    inx  ; else increment x
    jmp @VERA_load_loop ; and jump to VERA_load_loop
end_of_VERA_load_loop:

    ;fill screen with black 
    ;set ups VERA registers to save into VRAM with auto increment 
    lda #$0
    sta VERA_addrsL
    sta VERA_addrsM
    lda #$10
    sta VERA_addrsH
    
    lda #00
    ldx #75 
@screen_fill_loop:
    sta VERA_data0 
    cpx VERA_addrsM
    beq @end_of_screen_fill_loop
    jmp @screen_fill_loop
@end_of_screen_fill_loop:
    rts