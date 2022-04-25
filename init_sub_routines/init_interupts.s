low_ball_update_addrs: .lobytes game_loop;update_ball
hi_ball_update_addrs: .hibytes game_loop;update_ball ;
Default_irq_handler: 
    .word $0000


init_interupts:
    ;preserves default handler 
    lda $0314
    sta Default_irq_handler
    lda $0315
    sta Default_irq_handler+1

    ;sets new handler
    sei
    lda low_ball_update_addrs
    sta $0314
    lda hi_ball_update_addrs
    sta $0315
    cli
    rts