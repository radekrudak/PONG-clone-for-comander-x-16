init_sprites:
    ;init sprites
    lda #%01000000
    ora $9F29
    sta $9F29

    ;reset VERA 
    ; lda #$ff
    ; sta $9F25
    ; set ups VERA register for transver
    lda #0
    sta VERA_addrsL
    lda #$FC
    sta VERA_addrsM
    lda #$11
    sta VERA_addrsH
    ;set ups player 1 Sprite "heather"
    lda #$80;#$30
    sta VERA_data0 ; offset 0 addrs 12:5
    lda #$9;#$1
    sta VERA_data0 ; offset 1 mod and addrs 16:13
    lda #5
    sta VERA_data0 ; offset 2 x low
    lda #0
    sta VERA_data0 ; offset 3 x high
    lda #1
    sta VERA_data0 ; offset 4 y low
    sta VERA_data0 ; offset 5 y High
    lda #%00001100 ; offset6 Colision mask (to 3 i.e. Sprite in front of layer 1 ) z depth h vlip
    sta VERA_data0
    lda #$C0      ; PSrite height (= 64) width (= 8)
    sta VERA_data0

    ;set ups player 2 Sprite  "heather"
    lda #$80
    sta VERA_data0 ; offset 0 addrs 12:5
    lda #$9
    sta VERA_data0 ; offset 1 mod and addrs 16:13
    lda #5
    sta VERA_data0 ; offset 2 x low
    lda #$ff
    sta VERA_data0 ; offset 3 x high
    lda #0
    sta VERA_data0 ; offset 4 y low
    lda #0
    sta VERA_data0 ; offset 5 y High
    lda #%00001100 ; offset6 Colision mask (to 3 i.e. Sprite in front of layer 1 ) z depth h vlip
    sta VERA_data0
    lda #$C0      ; PSrite height (= 64) width (= 8)
    sta VERA_data0

    ;set ups ball Sprite  "heather"
    lda #$88
    sta VERA_data0 ; offset 0 addrs 12:5
    lda #$09
    sta VERA_data0 ; offset 1 mod 0 and addrs 16:13
    lda #5
    sta VERA_data0 ; offset 2 x low
    lda #$0
    sta VERA_data0 ; offset 3 x high
    lda #0
    sta VERA_data0 ; offset 4 y low
    lda #0
    sta VERA_data0 ; offset 5 y High
    lda #%00001100 ; offset6 Colision mask (to 3 i.e. Sprite in front of layer 1 ) z depth h vlip
    sta VERA_data0
    lda #$50      ; PSrite height (= 64) width (= 8)
    sta VERA_data0






    ;set up VERA adress to sprite data and to auto increment incement
    ; them fills sprite with white
    lda #$00
    sta VERA_addrsL
    lda #$30
    sta VERA_addrsM
    lda #$11
    sta VERA_addrsH

    lda #$11 ;loads $11 to write to sprite data, each byte holds 2 pixels by writing hex 11 it turns both of them into white
    ldx #0 ;load x with zero for loop
@player_sprite_filling:
    sta VERA_data0 ; write $11 to sprite pixel data
    
    cpx #255 ; if x register == 255
    beq @end_of_player_sprite_filling ; break the loop
    inx ; else increment x
    jmp @player_sprite_filling ; and continue loop 
 @end_of_player_sprite_filling:  


 ldx #0
@ball_sprite_filling_first_half:
    lda ball_data,x;
    sta VERA_data0 ; write  to sprite pixel data
    
    cpx #128 ; if x register == 128
    beq @end_of_ball_sprite_filling_first_half ; break the loop
    inx ; else increment x
    jmp @ball_sprite_filling_first_half ; and continue loop 
 @end_of_ball_sprite_filling_first_half:  





    
    rts
ball_data:
    ;line 1 
    .byte $00
    .byte $00
    .byte $00
    .byte $01
    .byte $10
    .byte $00
    .byte $00
    .byte $00
    ;line 2
    .byte $00
    .byte $00
    .byte $01
    .byte $11
    .byte $11
    .byte $10
    .byte $00
    .byte $00
    ;line 3
    .byte $00
    .byte $01
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $10
    .byte $00
    ;line 4
    .byte $00
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $00
    ;line 5
    .byte $00
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $00
    ;line 6
    .byte $01
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $10
    ;line 7
    .byte $01
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $10
    ;line 8
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11

    ;line 9
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11

    ;line 10
    .byte $01
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $10
    ;line 11
    .byte $01
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $10
    ;line 12
    .byte $00
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $00

    ;line 13
    .byte $00
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $00
    ;line 14
    .byte $00
    .byte $01
    .byte $11
    .byte $11
    .byte $11
    .byte $11
    .byte $10
    .byte $00

    ;line 15
    .byte $00
    .byte $00
    .byte $01
    .byte $11
    .byte $11
    .byte $10
    .byte $00
    .byte $00

    ;line 16 
    .byte $00
    .byte $00
    .byte $00
    .byte $01
    .byte $10
    .byte $00
    .byte $00
    .byte $00




end_of_ball_data: