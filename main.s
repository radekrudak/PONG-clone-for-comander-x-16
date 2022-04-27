
.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

.localchar '@'

    jmp start


layer0_cfg:
    .byte %00000100, $00, $00, $00, $00, $00, $00
layer0_cfg_addrs =  $9F34

VERA_addrsL = $9F20;
VERA_addrsM = $9F21;
VERA_addrsH = $9F22;

VERA_data0 = $9F23
r0 = $02

r1 = $04
player1_x = $10
player2_x = $0268
playersy:
player1y:
    .word $4
player2y:
    .word move_ratio*4
;ball's x,y posytion
player1_points:
    .byte $0
player2_points:
    .byte $0

ball_default_x = 320
ball_default_y = 230
ball_x_y:
ball_x:
    .word 320
ball_y:
    .word 240
;ball's velocity vector
ball_default_velocity = 3 

ball_velocity:
    .byte ball_default_velocity ;x 
    .byte ball_default_velocity;y
.include "ball_physics.s"
.include "init.s"
.include "./update_sub_routines/update_sprites.s"


start:
    jsr init
infinite_loop:
    jmp infinite_loop

;game loop called with interupt 
game_loop:

    jsr update_ball
    jsr update_sprites
    ; KEYBOARD INPUT  / JOYSTICK INPUT 
    ; rest of input handeling isn't comented since only masks for bit wise operations are different
    lda #0
    jsr $FF56 ; joystick_get ; see comander x16 docs for KERNAL sub routines
    eor #%00001000 ; get bits responsible for particular button thou mask
    and #%00001000 ;
    beq @move_player2_up_not_pressed ; if result is zero "skip one instruction",
    jsr move_player2_up  ;else jump to sub routine that is responsible for particular button
@move_player2_up_not_pressed:
    lda #0
    jsr $FF56
    eor #%00000100
    and #%00000100
    beq @move_player2_down_not_pressed
    jsr move_player2_down
@move_player2_down_not_pressed:
    lda #0
    jsr $FF56
    eor #%01000000
    and #%01000000
    beq @move_player1_up_not_pressed
    jsr  move_player1_up
@move_player1_up_not_pressed:
    lda #0
    jsr $FF56
    txa
    eor #%10000000
    and #%10000000
    beq @move_player1_down_not_pressed
    jsr  move_player1_down

@move_player1_down_not_pressed:   



    jmp (Default_irq_handler)
    ;end of game loop



y_pos_larger_than:
    .word $01A0
y_pos_smaller_than:
    .word $0301
;PLAYERS  MOVEMENTS "sub routines"
move_player1_up:
    ldx #0 ;loads 0 - so offest of player 1  so subroutine will move player 1
    jmp move_up;
move_player1_down:
    ldx #0 ;loads 0 - so offest of player 1  so subroutine will move player 1 
    jmp move_down
move_player2_up:
    ldx #2 ;loads 2 - so offest of player 2 so subroutine will move player 2 
    jmp move_up

move_player2_down:
    ldx #2  ;loads 2 - so offest of player 2 so subroutine will move player 2 
    jmp move_down  



move_ratio:
    .word   $4 ; value is added or subtracted to/from player y falue
    .word   $4
; moves player 1 or 2 up and down with player is selected depends on value of x register
check_passed:
    .byte 0
move_up:
;chek if player's y coordinate is larger than "y_pos_smaller_than" if so jump to move_down_no_check
 
    lda #0
    sta check_passed

    lda move_ratio,x

    cmp playersy,x
    lda #0
    adc #0
    sta check_passed
    inx

    lda move_ratio,x
    cmp playersy,x
    lda check_passed
    dex
    adc #0 
    cmp #2
    bcs set_y_to_default ;set_y_to_default

;subtract move_ratio from playery
move_up_no_check:
    lda playersy ,x
    sec
    sbc move_ratio
    sta playersy,x
    inx
    lda playersy,x
    sbc  #0
    sta playersy,x

    rts
set_y_to_default:
    lda #0
    sta playersy,x
    inx 
    sta playersy,x
    rts

low_barier:
    .word 416
    .word 416
move_down:

    lda #0
    sta check_passed

    lda playersy,x
    cmp low_barier,x
    lda #0
    adc #0
    sta check_passed
    inx

    lda playersy,x
    cmp low_barier,x
    lda check_passed
    dex
    adc #0

    cmp #2
    bcs set_y_to_max
    
move_down_no_check:
;add move_ratio to player's y coordinate
    
    lda playersy,x
    clc
    adc move_ratio
    sta playersy,x
    inx
    lda playersy,x
    adc #0
    sta playersy,x
    rts
set_y_to_max:
    lda low_barier,x
    sta playersy,x
    inx 
    lda low_barier,x
    sta playersy,x
    dex
    rts

