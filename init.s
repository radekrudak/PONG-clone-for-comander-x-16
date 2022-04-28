.include "./init_sub_routines/init_bitmap_mode.s"
.include "./init_sub_routines/init_sprites.s"
.include "./init_sub_routines/init_text_mode.s"
.include "./init_sub_routines/init_interupts.s"

init:
;init interupt handler 

    jsr init_text_mode ; init text mode screen, fills it black 
    jsr init_sprites ; inits sprites "heather"/ meta data and them fills sprite with white
    jsr init_interupts
    rts