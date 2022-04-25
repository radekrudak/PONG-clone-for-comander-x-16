CC = cl65
ARGS =   -t  cx16 -g -Ln pong.sym
default: PONG.PRG
PONG.PRG: main.s  init.s update_sub_routines/update_sprites.s init_sub_routines/init_sprites.s init_sub_routines/init_bitmap_mode.s init_sub_routines/init_interupts.s ball_physics.s
	$(CC) $(ARGS)   $< -o $@ 
