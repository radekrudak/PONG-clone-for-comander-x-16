CC = cl65
ARGS =   -t  cx16 -g -Ln pong.sym
FILES = init.s update_sub_routines/update_sprites.s init_sub_routines/init_sprites.s init_sub_routines/init_bitmap_mode.s init_sub_routines/init_interupts.s ball_physics.s  ball_physics_sub_routines/check_colysion_with_p2.s ball_physics_sub_routines/check_colysion_with_p1.s ball_physics_sub_routines/check_right_bound.s

default: PONG.PRG
PONG.PRG: main.s $(FILES) 
	$(CC) $(ARGS)   $< -o $@
	run 
start:
	box16 -prg PONG.PRG -sym pong.sym 
run: 
	box16 -prg PONG.PRG -sym pong.sym -run
