.data	
	# Pokemon Choose Scenario
	.include "scenes/display_pokemon.s"
	.include "sprites/brick.s"								# 112
	.include "sprites/pokemons/Charmander.data"
	.include "sprites/pokemons/Squirtle.data"
	.include "sprites/pokemons/Bulbassauro.data"
	.include "sprites/pokemons/chat.data" #					
	
	# Lab_Scenario
	.include "sprites/Sprites_Scenes/cenario_laboratorio/door1.data"			# 1
	.include "sprites/Sprites_Scenes/cenario_laboratorio/door2.data"			# 2
	.include "sprites/Sprites_Scenes/cenario_laboratorio/estante_bot1.data"			# 3
	.include "sprites/Sprites_Scenes/cenario_laboratorio/estante_bot2.data"			# 4
	.include "sprites/Sprites_Scenes/cenario_laboratorio/estante_top1.data"			# 5
	.include "sprites/Sprites_Scenes/cenario_laboratorio/estante_top2.data"			# 6
	.include "sprites/Sprites_Scenes/cenario_laboratorio/floor_lab.data"			# 7
	.include "sprites/Sprites_Scenes/cenario_laboratorio/sprite_table10.data"		# 8
	.include "sprites/Sprites_Scenes/cenario_laboratorio/sprite_table11.data"		# 9
	.include "sprites/Sprites_Scenes/cenario_laboratorio/sprite_table20.data"		# 10
	.include "sprites/Sprites_Scenes/cenario_laboratorio/sprite_table21.data"		# 11
	.include "sprites/Sprites_Scenes/cenario_laboratorio/sprite_table22.data"		# 12
	.include "sprites/Sprites_Scenes/cenario_laboratorio/wall_bottom_lab.data"		# 13
	.include "sprites/Sprites_Scenes/cenario_laboratorio/wall_top_lab.data"			# 14
	.include "sprites/Sprites_Scenes/cenario_laboratorio/windows_new_lab.data"		# 15

	.include "sprites/pokeball.s"								# 110 			
	.include "sprites/pokeball_open.s"							# 111
	.include "sprites/select_zone.s"							# 113
	
	.include "sprites/table_lab01.s"							# 114
	.include "sprites/table_lab02.s"							# 115
	.include "sprites/table_lab03.s"							# 116
	
	# Wild_Scenario
	.include "sprites/Sprites_Scenes/cenario_aberto/rass.s"				# 16	
	.include "sprites/Sprites_Scenes/cenario_aberto/river_edge1.data"			# 17
	.include "sprites/Sprites_Scenes/cenario_aberto/river_edge2.data"			# 18
	.include "sprites/Sprites_Scenes/cenario_aberto/river_mid.data"				# 19
	.include "sprites/Sprites_Scenes/cenario_aberto/river_new_side1.data"			# 20
	.include "sprites/Sprites_Scenes/cenario_aberto/river_new_side2.data"			# 21
	.include "sprites/Sprites_Scenes/cenario_aberto/road_edge.data"				# 22
	.include "sprites/Sprites_Scenes/cenario_aberto/road_edge1.data"			# 23
	.include "sprites/Sprites_Scenes/cenario_aberto/road_edge2.data"			# 24
	.include "sprites/Sprites_Scenes/cenario_aberto/road_edge3.data"			# 25
	.include "sprites/Sprites_Scenes/cenario_aberto/road_edge4.data"			# 26
	.include "sprites/Sprites_Scenes/cenario_aberto/road_mid.data"				# 27
	.include "sprites/Sprites_Scenes/cenario_aberto/roadside_bottom.data"			# 28
	.include "sprites/Sprites_Scenes/cenario_aberto/roadside_left.data"			# 29
	.include "sprites/Sprites_Scenes/cenario_aberto/roadside_right.data"			# 30
	.include "sprites/Sprites_Scenes/cenario_aberto/roadside_to.data"			# 31
	.include "sprites/Sprites_Scenes/cenario_aberto/sprite_brush.data"			# 32
	.include "sprites/Sprites_Scenes/cenario_aberto/river_top_side.data"		# 117

	# Gym_Scenario
	.include "sprites/Sprites_Scenes/cenario_ginasio/colunabot.data"			# 33
	.include "sprites/Sprites_Scenes/cenario_ginasio/colunato.data"				# 34
	.include "sprites/Sprites_Scenes/cenario_ginasio/door.data"				# 35
	.include "sprites/Sprites_Scenes/cenario_ginasio/floor.data"				# 36
	.include "sprites/Sprites_Scenes/cenario_ginasio/statue_bot.data"			# 37
	.include "sprites/Sprites_Scenes/cenario_ginasio/statue_to.data"			# 38
	.include "sprites/Sprites_Scenes/cenario_ginasio/windows1.data"				# 39
	.include "sprites/Sprites_Scenes/cenario_ginasio/windows2.data"				# 40
	.include "sprites/Sprites_Scenes/cenario_ginasio/sand.data"				# 118

	# Player 
	.include "sprites/Sprites_Scenes/personagens/trainer/layer_back.data"			# 100
	.include "sprites/Sprites_Scenes/personagens/trainer/layer_front.data"			# 101
	.include "sprites/Sprites_Scenes/personagens/trainer/layer_left.data"			# 102
	.include "sprites/Sprites_Scenes/personagens/trainer/layer_right.data"			# 103
	.include "sprites/Sprites_Scenes/personagens/trainer/layer_walk_a1.data"		# 104
	.include "sprites/Sprites_Scenes/personagens/trainer/layer_walk_a2.data"		# 105
	.include "sprites/Sprites_Scenes/personagens/trainer/layer_walk_d1.data"		# 106
	.include "sprites/Sprites_Scenes/personagens/trainer/layer_walk_d2.data"		# 107
	.include "sprites/Sprites_Scenes/personagens/trainer/layer_walk_w1.data"		# 108
	.include "sprites/Sprites_Scenes/personagens/trainer/layer_walk_w2.data"		# 109
	
	# Scenes	
	.include "scenes/scene01.s"
	.include "scenes/scene02.s"
	.include "scenes/scene03.s"

	# Audio
	.include "audio/oak-s-lab.data"
	
	
	# Game Status => Saves Which Pokeball Was Selected
	PREVIOUS_POKEBALL: .byte 13
	
.text
FIRST_SETUP:
	li s9, 0			# Current Pokemon
	li s0, 12			# Player row
	li s1, 9			# Player col
	mv a0, s0
	mv a1, s1
MAIN:
	mv s0, a0			# Player row
	mv s1, a1
	la s2, MAP_1			# Current Map
	la s3, OBJECT_MAP_1		# Current Object Mapping
	la s4, LOCATION_CHANGE_1	# Location to change
	
	la s5, oak_s_lab_track1		# Music Address
	addi t0, s5, 4			# Get Music Address
	mv s6, t0			# Music Playing
	lw s5, 0(s5)			# Music Size

	mv s6, t0			# Music Playing
	li s7, 0			# Music Step
	li s8, 0			# Elapsed Time
	
GAME_SETTING:
	mv a0, s2 
	jal PRINT_MAP
	
	mv a0, s3
	jal OBJECT_RENDERING
	
	mv a0, s0			# Lines to moves
	mv a1, s1			# Rows to move
	li a2, 101			# Player Image
	li a3, 0			# Player between image
	li a4, 0
	jal BLOCK_SELECTION
	
GAME_LOOP:
	# li a7, 30
	# ecall
	csrr a0, time 		# Alternative way for syscalls time

	# Audio Event
	sub t0, a0, s8
	add t1, s6, s7
	lw t1, 4(t1)
	ble t0, t1, KEYBOARD_EVENT
	
	jal AUDIO_GAME
	# li a7, 30
	# ecall
	csrr a0, time		# Alternative way for syscalls time

	mv s8, a0
KEYBOARD_EVENT:
	li t0, 0xFF200000
	lw t1, 0(t0)
	andi t1, t1, 0x00000001
	
	beqz t1, GAME_LOOP
	jal GAME_KEYBOARD
	
	j GAME_LOOP

END_GAME_LOOP:

EXIT:
	li a7, 10
	ecall

############################################################################
############################################################################

#==================================+
#	PRINT SINGLE IMAGE	   |
#==================================+

PRINT_SINGLE_IMAGE:
	# a0 => Image
	# a1 => Horizontal Shift
	# a2 => Vertical Shift
	# a3 => Frame

	mv t0, a0
	lw t1, 4(t0)				# Width
	lw t2, 0(t0)				# Height
	addi t0, t0, 4				# Pixels
	li t3, 0				# Row counter
	li t4, 0				# Co1 counter
	
	# Starting address
	li t6, 320
	mul t5, a2, t6
	add t5, t5, a1
	add t5, t5, a3
	mv t6, t5
	
	addi a0, a0, 8


LOOP_PRINT_IMAGE:
	beq t3, t1, LOOP_END_PRINT_IMAGE	# [if t3 == t1 <> row_counter == height] => End_Print_Image
	
IMAGE_LOOP_COL:
	beq t4, t2, END_IMAGE_LOOP_COL		# [if t4 == t2 <> col_counter == width] => End_Print_Col
	lb t0, 0(a0)				# t6 = current_pixel
	addi a0, a0, 1				# t0 += t1 => Next Pixel
	sb t0, 0(t5)				# R[t5] = Current_Pixel
	addi t5, t5, 1				# t5 += 1 => Next Place to Store Pixel
	addi t4, t4, 1				# t4 += 1 => Next Col
	j IMAGE_LOOP_COL
END_IMAGE_LOOP_COL:
	addi t3, t3, 1				# t3 += 1 => Next Line
	li t4, 320				# t4 = 320
	mul t4, t3, t4				# t5 = t3 * t4 = current_line * 320
	add t5, t6, t4
	li t4, 0				# t4 = 0 => Reset col_counter
	j LOOP_PRINT_IMAGE
LOOP_END_PRINT_IMAGE:
	ret

#=======================+
#	GAME AUDIO	|
#=======================+

AUDIO_GAME: # Uses the saved registers
	# |Note|Duration|Note|Duration|... => (|Note|Duration|)(|Note|Duration|)... => 0, 8, 16, 24, ...
	# When you are working with a note you use a step size with 8 as size.	
	# ebreak
	li t0, -1
	beq s7, t0, RESET_AUDIO

	slli t0, s5, 3			# s6 << 3 = (audio_size) * 8
	bge s7, t0, RESET_AUDIO		# s7 >= (audio_size) * 8
	
	add t0, s6, s7			# s6 + s7 = Current_Audio + Current_Step => Current Note

	lw a0, 0(t0)			# Load Note
	lw a1, 4(t0)			# Load Duration
	li a2, 28			# Instrument
	li a3, 120			# Volume

	li a7, 31			# Play note
	ecall

	addi s7, s7, 8			# Next Note

	ret
RESET_AUDIO:
	li s7, 0
	ret
#=========================+
#	GAME KEYBOARD	  |
#=========================+
GAME_KEYBOARD:
	li t0, 0xFF200004
	lb t0, 0(t0)
	
	li t1, 'w'
	beq t0, t1, PRESS_MOVE_W
	
	li t1, 's'
	beq t0, t1, PRESS_MOVE_S

	li t1, 'a'
	beq t0, t1, PRESS_MOVE_A
	
	li t1, 'd'
	beq t0, t1, PRESS_MOVE_D
	
	li t1, 'e'
	beq t0, t1, PRESS_EXIT
	
	# Verify if is in right position to select pokemon
	li t1, 6
	bne s0, t1, END_GAME_KEYBOARD
	li t1, 14
	bne s1, t1, END_GAME_KEYBOARD
	
	li t1, 'j'
	beq t0, t1, SELECT_FIRST_POKEBALL
	
	li t1, 'k'
	beq t0, t1, SELECT_SECOND_POKEBALL
	
	li t1, 'l'
	beq t0, t1, SELECT_THIRD_POKEBALL
	
	li t1, 'i'
	beq t0, t1, SELECTED_POKEMON

	j END_GAME_KEYBOARD
	
PRESS_MOVE_W:
	li a0, -1
	li a1, 0
	li a2, 100
	li a3, 108
	li a4, 0
	li a5, 8
	j MOVE_PLAYER
	
PRESS_MOVE_S:
	li a0, 1
	li a1, 0
	li a2, 101
	li a3, 101
	li a4, 0
	li a5, -8
	j MOVE_PLAYER

PRESS_MOVE_A:
	li a0, 0
	li a1, -1
	li a2, 102
	li a3, 104
	li a4, 0
	li a5, 0
	j MOVE_PLAYER

PRESS_MOVE_D:
	li a0, 0
	li a1, 1
	li a2, 103
	li a3, 106
	li a4, 0
	li a5, 0
	j MOVE_PLAYER
	
SELECT_FIRST_POKEBALL:
	li a0, 13
	j SELECT_POKEBALL
SELECT_SECOND_POKEBALL:
	li a0, 14
	j SELECT_POKEBALL
SELECT_THIRD_POKEBALL:
	li a0, 15
	j SELECT_POKEBALL
SELECTED_POKEMON:
	j DISPLAY_SELECTED_POKEMON

PRESS_RIGHT_POKEBALL:
	ret

PRESS_EXIT:
	j EXIT

END_GAME_KEYBOARD:
	ret

#=====================================+
#	CHANGE CURRENT LOCATION	      |
#=====================================+
CHANGE_CURRENT_LOCATION: # a0 => player_row, a1 => player_col, a2 => scene
	mv s0, a0
	mv s1, a1

	mv a0, a2

	li t0, 1
	beq t0, a0, SCENE_1
	
	li t0, 2
	beq t0, a0, SCENE_2

	li t0, 3
	beq t0, a0, SCENE_3

SCENE_1:
	la s2, MAP_1		
	la s3, OBJECT_MAP_1	
	la s4, LOCATION_CHANGE_1
	j END_CHANGE_CURRENT_LOCATION
SCENE_2:
	la s2, MAP_2
	la s3, OBJECT_MAP_2
	la s4, LOCATION_CHANGE_2
	j END_CHANGE_CURRENT_LOCATION
SCENE_3:
	la s2, MAP_3
	la s3, OBJECT_MAP_3
	la s4, LOCATION_CHANGE_3
	j END_CHANGE_CURRENT_LOCATION

END_CHANGE_CURRENT_LOCATION:
	la ra, GAME_SETTING
	ret

#===========================+
#	MOVE CHARACTER	    |
#===========================+
MOVE_PLAYER:
	# a0 => Row movement
	# a1 => Col movement
	# a2 => Player image
	# a3 => Player image between
	# a4 => Player X offset
	# a5 => Player Y offset
	
	add t0, s0, a0				# t0 = New Player Row
	add t1, s1, a1				# t1 = New Player Col
	li t2, 15				# t2 = 15 = Row's number
	li t3, 20				# t3 = 20 = Col's number
	blt t0, zero, END_GAME_KEYBOARD		# t0 < 0 	=> No movement
	blt t1, zero, END_GAME_KEYBOARD		# t1 < 0 	=> No movement
	bge t0, t2, END_GAME_KEYBOARD		# t0 >= 15 	=> No movement
	bge t1, t3, END_GAME_KEYBOARD		# t1 >= 20 	=> No movement

	addi sp, sp, -36
	sw ra, 0(sp)
	sw a0, 4(sp)
	sw a1, 8(sp)
	sw a2, 12(sp)
	sw a3, 16(sp)
	sw a4, 20(sp)
	sw a5, 24(sp)
	
	# Object Collision
	add a0, a0, s0			# New Row Player Position
	add a1, a1, s1			# New Col Player Position
	mv a3, s3			# Current Scene Objects
	jal PLAYER_COLLISION

	beqz a0, END_PLAYER_MOVE	# Player Collides
	
	# Location Collision
	lw a0, 4(sp)			# a0 = delta_row
	add a0, a0, s0			# a0 = a0 + current_position = new_row_position
	lw a1, 8(sp)			# a1 = delta_col
	add a1, a1, s1			# a1 = new_col_position
	mv a3, s4			# a3 = location_to_change
	jal PLAYER_COLLISION
	
	beqz a0, MOVE_CHANGE_CURRENT_LOCATION

	# Get Block in previous position
	li a2, 20			# a2 = 20
	mul a2, a2, s0			# a2 = a2 * s0 = 20 * Row
	add a2, a2, s1			# a2 = a2 * s0 + s1 = 20 * Row + Col
	add a2, a2, s2			# a2 = a2 * s0 + s1 + Address = 20 * Row + Col + Address
	
	lb a2, 0(a2)			# Load Block Value
	sw a2, 28(sp)			# Store Block Value
	
	mv a0, s0			# Previous Row
	mv a1, s1			# Preivous Col
	li a3, 0			# Offset X
	li a4, 0			# Offset Y
	jal BLOCK_SELECTION
	
	lw a0, 4(sp)			# Movement in Row
	lw a1, 8(sp)			# Movement in Col
	
	add a0, s0, a0			# a0 = s0 + delta_row
	add a1, s1, a1			# a1 = s1 + delta_col

	lw a2, 16(sp)			# Load Between Image
	lw a3, 20(sp)			# Load X offset
	lw a4, 24(sp)			# Load Y offset
	jal BLOCK_SELECTION

	li a0, 100			# Wait 100ms
	# li a7, 32			# Sleep Action
	# ecall				# Call Sleep
	# Alternative ways for SysCall Sleep
SLEEP:
	csrr t6, time
	add a0, a0, t6
SLEEP_LOOP:
	csrr t6, time
	blt t6, a0, SLEEP_LOOP

	mv a0, s0			# Previous Player Row
	mv a1, s1			# Previous Player Col
	lw a2, 28(sp)			# Get Ground
	li a3, 0			# X Offset
	li a4, 0			# Y Offset
	jal BLOCK_SELECTION
	
	lw a0, 4(sp)			# Load X Offset
	lw a1, 8(sp)			# Load Y Offset

	add s0, s0, a0			# Change Player Row
	add s1, s1, a1			# Change Player Col
	
	mv a0, s0			# Load Final Player Row
	mv a1, s1			# Load Final Player Col
	lw a2, 12(sp)			# Load Player Final Image Value
	li a3, 0			# X Offset
	li a4, 0			# Y Offset
	jal BLOCK_SELECTION

END_PLAYER_MOVE:
	lw ra, 0(sp)			# Recover return address
	addi sp, sp, 36			# Back stack
	ret
MOVE_CHANGE_CURRENT_LOCATION:
	la ra, CHANGE_CURRENT_LOCATION	# Change Current Location
	 
	mv a2, a1				# new scene
	mv a0, a3				# new row player location
	mv a1, a4				# new col player location

	addi sp, sp, 36			# Free Stack Pointer
	ret

#==============================+
#	PLAYER COLISION	       |
#==============================+
# Verify if Player collides in a place, object, person, ...

PLAYER_COLLISION: # a0 => Row, a1 => Col; a3 => Element address, Return: a0 = 0 if collides with target, a1 = value_colided
	addi sp, sp, -4
	sw ra, 0(sp)
	
	mv t0, a3		# t0 = Objects Address
	lb t1, 0(t0)		# t1 = Number of Objects
	addi t0, t0, 1		# t0 += 1 => First Object
	li t2, 0		# t2 = Object Counter
	mv t3, a0		# t3 = Row
	mv t4, a1		# t4 = Col
	
	li a0, 1		# Not collide

PLAYER_COLLISION_LOOP:
	beq t1, t2, PLAYER_NOT_COLLIDES
	addi t2, t2, 1
	
	lb t5, 0(t0)		# Element Row
	lb t6, 1(t0)		# Element Col
	lb a1, 2(t0)		# Get current element value
	lb a3, 3(t0)		# Get new row for player
	lb a4, 4(t0)		# Get new col for player

	# Verify if there is an object in a row(t3) and col(t4)
	bne t3, t5, PLAYER_COLLISION_OTHER_ELEMENT	# if row != current_row => Verify other Element
	bne t4, t6, PLAYER_COLLISION_OTHER_ELEMENT	# if col != current_col => Verify other Element
	j PLAYER_COLLIDES
	
PLAYER_COLLISION_OTHER_ELEMENT:
	addi t0, t0, 5
	j PLAYER_COLLISION_LOOP
	
PLAYER_COLLIDES:
	li a0, 0
PLAYER_NOT_COLLIDES:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

#============================+
#	SELECT POKEBALL	     |
#============================+
SELECT_POKEBALL: # SELECT POKEBALL
	# a0 => Current Col
	
	addi sp, sp, -8
	sw ra, 0(sp)
	sb a0, 4(sp)
	
	la a1, PREVIOUS_POKEBALL
	lb a1, 0(a1)

CHANGE_POKEBALL_STATE:
	li a0, 5
	li a2, 110
	li a3, 0
	li a4, -4
	jal BLOCK_SELECTION
	
	li a0, 5
	lw a1, 4(sp)
	li a2, 111
	li a3, 0
	li a4, -4
	jal BLOCK_SELECTION
	
	la t0, PREVIOUS_POKEBALL
	lb t1, 4(sp)	
	sb t1, 0(t0)
	
	lw ra, 0(sp)
	addi sp, sp, 8
	j END_GAME_KEYBOARD
	
#====================================+
#	DISPLAY SELECTED POKEMON     |
#====================================+
DISPLAY_SELECTED_POKEMON:
	addi sp, sp, -4
	sw ra, 0(sp)

	bnez s9, RESTART_LAB_SCENE
	
	la s9, PREVIOUS_POKEBALL
	lb s9, 0(s9)
	addi s9, s9, -12

	la a0, DISPLAY_POKEMON_SCENE
	jal PRINT_MAP
	
	li t0, 1
	beq s9, t0, DISPLAY_BUBASSAURO
	li t0, 2
	beq s9, t0, DISPLAY_CHARMANDER
	li t0, 3
	beq s9, t0, DISPLAY_SQUIRTLE

DISPLAY_BUBASSAURO:
	la a0, Bulbassauro
	j DISPLAY_POKEMON_IMAGE
DISPLAY_CHARMANDER:
	la a0, Charmander
	j DISPLAY_POKEMON_IMAGE
DISPLAY_SQUIRTLE:
	la a0, Squirtle
	j DISPLAY_POKEMON_IMAGE
DISPLAY_POKEMON_IMAGE:
	li a1, 30
	li a2, 30
	li a3, 0XFF000000
	jal PRINT_SINGLE_IMAGE
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
RESTART_LAB_SCENE:
	li a0, 6
	li a1, 13
	j MAIN

#==============================+
#	OBJECT RENDERING       |
#==============================+

OBJECT_RENDERING: # a0 => Object Map Address
	addi sp, sp, -16
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	
	mv s0, a0	# Object Map Address and the number of objects
	lb s1, 0(s0)	# Amount of objects
	addi s0, s0, 1	# First Object
	li s2, 0	# Counter

LOOP_OBJECT:
	beq s1, s2, END_OBJECT_RENDERING
	addi s2, s2, 1
	
	lb a0, 0(s0)
	lb a1, 1(s0)
	lb a2, 2(s0)
	lb a3, 3(s0)
	lb a4, 4(s0)
	
	jal BLOCK_SELECTION		# Jump to BLOCK_SELECTION
	addi s0, s0, 5
	j LOOP_OBJECT

END_OBJECT_RENDERING:
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	ret

#=======================+
#	PRINT MAP	|
#=======================+

PRINT_MAP: # a0 = Map Selected

	addi sp, sp, -16		# sp -= 16
	sw ra, 0(sp)			# Store return address
	sw s0, 4(sp)			# Store s0
	sw s1, 8(sp)			# Store s1
	sw s2, 12(sp)			# Store s2
	
	li s0, 0			# Current Line
	li s1, 0			# Current Col
	mv s2, a0			# Current Map

LOOP_PRINT_MAP:
	mv a0, s1			# a0 = a4 = Current Block Line
	mv a1, s0			# a1 = a3 = Current Block Col
	lb a2, 0(s2)			# a2 = R[a5] = Current Block Type
	li a3, 0			# a3 = 0 = Offset_x
	li a4, 0			# a4 = 0 = Offset_y
	jal BLOCK_SELECTION		# Jump to BLOCK_SELECTION
	
	addi s2, s2, 1			# a5 += 1 => New Block Selected
	addi s0, s0, 1			# a3 += 1 => New Col
	li t0, 20			# t0 = 20
	bne t0, s0, LOOP_PRINT_MAP	# if t0 == a3, then NEW_LINE_MAP
NEW_LINE_MAP:
	addi s1, s1, 1			# a4 += 1 => New Line
	li s0, 0			# a3 = 0 => Reset Col
	li t0, 15			# t0 = 15
	bne t0, s1, LOOP_PRINT_MAP	# if t0 == a4, then PRINT_MAP

END_PRINT_MAP:
	lw ra, 0(sp)			# Load return address
	lw s0, 4(sp)			# Load s0
	lw s1, 8(sp)			# Load s1
	lw s2, 12(sp)			# Load s2
	addi sp, sp, 16			# sp += 16
	ret

#=============================+
#	BLOCKS SELECTION      |
#=============================+
# This procedure allows you to select blocks that you define in some map

# a0 => Block Line, a1 => Block Col, a2 => Type of Block, a3 => Offset_x, a4 => Offset_y
BLOCK_SELECTION:
	# Player
	li t0, 100		
	beq a2, t0, PLAYER_BACK
	li t0, 101		
	beq a2, t0, PLAYER_FRONT
	li t0, 102		
	beq a2, t0, PLAYER_LEFT
	li t0, 103		
	beq a2, t0, PLAYER_RIGHT
	li t0, 104		
	beq a2, t0, PLAYER_WALK_A1
	li t0, 105		
	beq a2, t0, PLAYER_WALK_A2
	li t0, 106		
	beq a2, t0, PLAYER_WALK_D1
	li t0, 107		
	beq a2, t0, PLAYER_WALK_D2
	li t0, 108		
	beq a2, t0, PLAYER_WALK_W1
	li t0, 109		
	beq a2, t0, PLAYER_WALK_W2
	
	# Pokemon Choose Scenario
	li t0, 112		
	beq a2, t0, BRICK
	
	# Lab_Scenario
	li t0, 1
	beq a2, t0, LAB_DOOR1
	li t0, 2
	beq a2, t0, LAB_DOOR2
	li t0, 3		
	beq a2, t0, LAB_ESTANTE_BOT1	
	li t0, 4		
	beq a2, t0, LAB_ESTANTE_BOT2	
	li t0, 5
	beq a2, t0, LAB_ESTANTE_TOP1	
	li t0, 6
	beq a2, t0, LAB_ESTANTE_TOP2	
	li t0, 7
	beq a2, t0, LAB_FLOOR	
	li t0, 8
	beq a2, t0, LAB_TABLE10	
	li t0, 9
	beq a2, t0, LAB_TABLE11	
	li t0, 10
	beq a2, t0, LAB_TABLE20	
	li t0, 11
	beq a2, t0, LAB_TABLE21	
	li t0, 12
	beq a2, t0, LAB_TABLE22	
	li t0, 13
	beq a2, t0, LAB_WALL_BOTTOM	
	li t0, 14
	beq a2, t0, LAB_WALL_TOP
	li t0, 15
	beq a2, t0, LAB_WINDOWS_NEW
	
	li t0, 110
	beq a2, t0, POKEBALL
	li t0, 111
	beq a2, t0, POKEBALL_OPEN
	li t0, 113
	beq a2, t0, SELECT_ZONE
	li t0, 114
	beq a2, t0, TABLE_LAB01
	li t0, 115
	beq a2, t0, TABLE_LAB02
	li t0, 116
	beq a2, t0, TABLE_LAB03

	# Wild_Scenario
	li t0, 16
	beq a2, t0, WILD_CUT_GRASS
	li t0, 17
	beq a2, t0, WILD_RIVER_EDGE1
	li t0, 18
	beq a2, t0, WILD_RIVER_EDGE2
	li t0, 19
	beq a2, t0, WILD_RIVER_MID
	li t0, 20
	beq a2, t0, WILD_RIVER_NEW_SIDE1
	li t0, 21
	beq a2, t0, WILD_RIVER_NEW_SIDE2
	li t0, 22
	beq a2, t0, WILD_ROAD_EDGE
	li t0, 23
	beq a2, t0, WILD_ROAD_EDGE1
	li t0, 24
	beq a2, t0, WILD_ROAD_EDGE2
	li t0, 25
	beq a2, t0, WILD_ROAD_EDGE3
	li t0, 26
	beq a2, t0, WILD_ROAD_EDGE4
	li t0, 27
	beq a2, t0, WILD_ROAD_MID
	li t0, 28
	beq a2, t0, WILD_ROADSIDE_BOTTOM
	li t0, 29
	beq a2, t0, WILD_ROADSIDE_LEFT
	li t0, 30
	beq a2, t0, WILD_ROADSIDE_RIGHT
	li t0, 31
	beq a2, t0, WILD_ROADSIDE_TO
	li t0, 32
	beq a2, t0, WILD_BRUSH
	li t0, 117
	beq a2, t0, WILD_RIVER_TOP_SIDE

	# Gym_Scenario
	li t0, 33
	beq a2, t0, GYM_COLUNABOT
	li t0, 34
	beq a2, t0, GYM_COLUNATO
	li t0, 35
	beq a2, t0, GYM_DOOR
	li t0, 36
	beq a2, t0, GYM_FLOOR	
	li t0, 37
	beq a2, t0, GYM_STATUE_BOT
	li t0, 38
	beq a2, t0, GYM_STATUE_TO
	li t0, 39
	beq a2, t0, GYM_WINDOWS1
	li t0, 40
	beq a2, t0, GYM_WINDOWS2		
	li t0, 118
	beq a2, t0, GYM_SAND

	ret
# Player
PLAYER_BACK:
	la a2, layer_back
	j PRINT_BLOCK_SELECTED
PLAYER_FRONT:
	la a2, layer_front
	j PRINT_BLOCK_SELECTED
PLAYER_LEFT:
	la a2, layer_left
	j PRINT_BLOCK_SELECTED
PLAYER_RIGHT:
	la a2, layer_right
	j PRINT_BLOCK_SELECTED
PLAYER_WALK_A1:
	la a2, layer_walk_a1
	j PRINT_BLOCK_SELECTED
PLAYER_WALK_A2:
	la a2, layer_walk_a2
	j PRINT_BLOCK_SELECTED
PLAYER_WALK_D1:
	la a2, layer_walk_d1
	j PRINT_BLOCK_SELECTED
PLAYER_WALK_D2:
	la a2, layer_walk_d2
	j PRINT_BLOCK_SELECTED
PLAYER_WALK_W1:
	la a2, layer_walk_w1
	j PRINT_BLOCK_SELECTED
PLAYER_WALK_W2:
	la a2, layer_walk_w2
	j PRINT_BLOCK_SELECTED

# Pokemon Choose
BRICK:
	la a2, brick
	j PRINT_BLOCK_SELECTED

# Lab_Scenario
LAB_DOOR1:
	la a2, door1_lab
	j PRINT_BLOCK_SELECTED
LAB_DOOR2:
	la a2, door2_lab
	j PRINT_BLOCK_SELECTED
LAB_ESTANTE_BOT1:
	la a2, estante_bot1
	j PRINT_BLOCK_SELECTED
LAB_ESTANTE_BOT2:
	la a2, estante_bot2
	j PRINT_BLOCK_SELECTED
LAB_ESTANTE_TOP1:	
	la a2, estante_top1
	j PRINT_BLOCK_SELECTED
LAB_ESTANTE_TOP2:
	la a2, estante_top2
	j PRINT_BLOCK_SELECTED
LAB_FLOOR:
	la a2, floor_lab
	j PRINT_BLOCK_SELECTED
LAB_TABLE10:
	la a2, sprite_table10
	j PRINT_BLOCK_SELECTED
LAB_TABLE11:
	la a2, sprite_table11
	j PRINT_BLOCK_SELECTED
LAB_TABLE20:
	la a2, sprite_table20
	j PRINT_BLOCK_SELECTED
LAB_TABLE21:
	la a2, sprite_table21
	j PRINT_BLOCK_SELECTED
LAB_TABLE22:
	la a2, sprite_table22
	j PRINT_BLOCK_SELECTED
LAB_WALL_BOTTOM:
	la a2, wall_bottom_lab
	j PRINT_BLOCK_SELECTED
LAB_WALL_TOP:
	la a2, wall_top_lab
	j PRINT_BLOCK_SELECTED
LAB_WINDOWS_NEW:
	la a2, windows_new_lab
	j PRINT_BLOCK_SELECTED
POKEBALL:
	la a2, pokeball
	j PRINT_BLOCK_SELECTED
POKEBALL_OPEN:
	la a2, pokeball_open
	j PRINT_BLOCK_SELECTED
SELECT_ZONE:
	la a2, select_zone
	j PRINT_BLOCK_SELECTED
TABLE_LAB01:
	la a2, table_lab01
	j PRINT_BLOCK_SELECTED
TABLE_LAB02:
	la a2, table_lab02
	j PRINT_BLOCK_SELECTED
TABLE_LAB03:
	la a2, table_lab03
	j PRINT_BLOCK_SELECTED

# Wild_Scenario
WILD_CUT_GRASS:
	la a2, rass
	j PRINT_BLOCK_SELECTED
WILD_RIVER_EDGE1:
	la a2, river_edge1
	j PRINT_BLOCK_SELECTED
WILD_RIVER_EDGE2:
	la a2, river_edge2
	j PRINT_BLOCK_SELECTED
WILD_RIVER_MID:
	la a2, river_mid
	j PRINT_BLOCK_SELECTED
WILD_RIVER_NEW_SIDE1:
	la a2, river_new_side1
	j PRINT_BLOCK_SELECTED
WILD_RIVER_NEW_SIDE2:
	la a2, river_new_side2
	j PRINT_BLOCK_SELECTED
WILD_ROAD_EDGE:
	la a2, road_edge
	j PRINT_BLOCK_SELECTED
WILD_ROAD_EDGE1:
	la a2, road_edge1
	j PRINT_BLOCK_SELECTED
WILD_ROAD_EDGE2:
	la a2, road_edge2
	j PRINT_BLOCK_SELECTED
WILD_ROAD_EDGE3:
	la a2, road_edge3
	j PRINT_BLOCK_SELECTED
WILD_ROAD_EDGE4:
	la a2, road_edge4
	j PRINT_BLOCK_SELECTED
WILD_ROAD_MID:
	la a2, road_mid
	j PRINT_BLOCK_SELECTED
WILD_ROADSIDE_BOTTOM:
	la a2, roadside_bottom
	j PRINT_BLOCK_SELECTED
WILD_ROADSIDE_LEFT:
	la a2, roadside_left
	j PRINT_BLOCK_SELECTED
WILD_ROADSIDE_RIGHT:
	la a2, roadside_right
	j PRINT_BLOCK_SELECTED
WILD_ROADSIDE_TO:
	la a2, roadside_to
	j PRINT_BLOCK_SELECTED
WILD_BRUSH:
	la a2, sprite_brush
	j PRINT_BLOCK_SELECTED
WILD_RIVER_TOP_SIDE:
	la a2, river_top_side
	j PRINT_BLOCK_SELECTED

# Gym_Scenario
GYM_COLUNABOT:
	la a2, colunabot
	j PRINT_BLOCK_SELECTED
GYM_COLUNATO:
	la a2, colunato
	j PRINT_BLOCK_SELECTED
GYM_DOOR:
	la a2, door
	j PRINT_BLOCK_SELECTED
GYM_FLOOR:
	la a2, floor
	j PRINT_BLOCK_SELECTED
GYM_STATUE_BOT:
	la a2, statue_bot
	j PRINT_BLOCK_SELECTED
GYM_STATUE_TO:
	la a2, statue_to
	j PRINT_BLOCK_SELECTED
GYM_WINDOWS1:
	la a2, windows1
	j PRINT_BLOCK_SELECTED	
GYM_WINDOWS2:
	la a2, windows2
	j PRINT_BLOCK_SELECTED
GYM_SAND:
	la a2, sand
	j PRINT_BLOCK_SELECTED

PRINT_BLOCK_SELECTED:
	addi a2, a2, 8
	j PRINT_BLOCK
END_BLOCK_SELECTION:
	ret

#=============================+
#         PRINT BLOCK	      |
#=============================+

PRINT_BLOCK: # (a0 => Block Line, a1 => Block Col, a2 => Color, a3 => offset_x, a4 => offset_y)
	# (Width = 16, Height = 16) => The screen has 320X240, so you will have a grid with 20x15
	mv t0, a2			# t0 = Color Address
	li t1, 0			# t1 = Line Counter
	
NEW_BLOCK_LINE:
	# Pixel_Cell_Address = Represents the start address(or pixel) where the block will be printed
	# Pixel_Cell_Address = 0XFF000000 + 320 * line_counter + block_col * width + 320 * block_line * height
	# Pixel_Cell_Address = 0XFF000000 + 320 * line_counter + block_col * 16 + 320 * block_line * 16
	# Pixel_Cell_Address = 0XFF000000 + 64 * 5 * (line_counter + block_line * 16) + 16 * block_Col
	
	# Pixel_Cell_Address = 0XFF000000 + 64 * 5 * (line_counter + block_line * 16) + 16 * block_Col + offset_x + offset_y

	slli t2, a0, 4			# t2 = a0 << 4 = a0 * 16 = pixel_line * 16
	add t2, t2, t1			# t2 = t2 + t1 =  pixel_line * 16 + line_counter
	li t3, 5			# t3 = 5
	mul t2, t2, t3			# t2 = t2 * t3 = t2 * 5 = (pixel_line * 16 + line_counter) * 5
	slli t2, t2, 6			# t2 = t2 << 6 = t2 * 64 = (pixel_line * 16 + line_counter) * 5 * 64
	slli t3, a1, 4			# t3 = a1 << 4 = block_col * 16
	add t2, t2, t3			# t2 = t2 + t3 = (pixel_line * 16 + line_counter) * 5 * 64 + block_col * 16
	li t3, 0xFF000000		# t3 = 0xFF000000
	add t2, t2, t3 			# t2 = (pixel_line * 16 + line_counter) * 5 * 64 + block_col * 16 + 0XFF000000
	add t2, t2, a3			# t2 += a3 = Offset_x => Allows you to create an horizontal shift
	mv t3, a4			# t3 = a4 = Offset_y  => Allows you to create a vertical shift
	slli t3, t3, 6			# t3 << 6 = t3 * 64
	li t4, 5			# t4 = 5
	mul t3, t3, t4			# t3 *= 5 = Offset_y * 320
	add t2, t2, t3			# t2 += t3 = Offset_y
	
	li t3, 0			# temporary column counter
	li t4, 4			# maximum from column counter
STORE_BLOCK_COLOR:			# Store the colors from a single line
	lw t5, 0(t0)			# t5 = R[t0] = Load a word from the color 'block address'
	sw t5, 0(t2)			# t2 = R[t5] = Store the loaded color in Pixel_Cell_Address[0], ..., Pixel_Cell_Address[3]
	addi t0, t0, 4			# t0 += 4 = Next colors from 'block address'
	addi t2, t2, 4			# t2 += 4 = Next Address to store the colors
	addi t3, t3, 1			# t3 += 1 = Increase counter
	bne t3, t4, STORE_BLOCK_COLOR	# if t3 != t4, then new storage  
	
	addi t1, t1, 1			# t1 += 1 = Next line
	li t2, 16			# t2 = 16 = Maximum of lines
	
	bne t2, t1, NEW_BLOCK_LINE	# if t1 != t2, then NEW_BLOCK_LINE
	j END_BLOCK_SELECTION
