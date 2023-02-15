.data
	.include "sprites/Sprites_Scenes/cenario_ginasio/sand.data"
	.include "scenes/gym_battle.s"
	.include "scenes/black_screen.s"
	.include "sprites/black.data"							# 121
	.include "sprites/pokemons/Charmander.data"
	.include "sprites/pokemons/Bulbassauro.data"
	.include "sprites/pokemons/Squirtle.data"
	.include "sprites/pokemons/Fuleco.data"
	.include "sprites/pokemons/Xatu.data"
	.include "sprites/Sprites_Scenes/personagens/Neymar_Batalha.data"
	.include "sprites/Sprites_Scenes/personagens/Neymar_Ganhou.data"

	# chat
	.include "sprites/texts/chat.data"				# 49
	.include "sprites/texts/battle_inst.data"
	.include "sprites/texts/Alfabeto.s"
	.include "scenes/chat_box.s"
	.include "scenes/battle_menu.s"
	.include "scenes/player_win.s"
	# Bar Level
	.include "sprites/bar/damage0.s"
	.include "sprites/bar/damage1.s"
	.include "sprites/bar/damage2.s"
	.include "sprites/bar/damage3.s"
	.include "sprites/bar/damage4.s"
	.include "sprites/bar/damage5.s"
	.include "sprites/bar/damage6.s"
	.include "sprites/bar/damage7.s"
	.include "sprites/bar/damage8.s"
	.include "sprites/bar/damage9.s"
	.include "sprites/bar/damage10.s"
	
	# Fight Types

FIGHT_TYPES:
	# 1 => Fire
	# 2 => Grass
	# 3 => Water
	# 4 => Psycho
	# 5 => Futebol
	
	.byte 25			# Number of Special Fights
	# .byte PLAYER_POKEMON_TYPE, ENEMY_POKEMON_TYPE, VALUE_LOST 
	.byte 1, 1, -2		# Fire,  Fire,  -2
	.byte 1, 2, -4		# Fire,  Grass,  -4
	.byte 1, 3, -1		# Fire, Water, -1
	.byte 1, 4, -2		# Fire,  Psycho,  -2
	.byte 1, 5, -1		# Fire, Futebol, -1
	.byte 2, 1, -1		# Grass, Fire, -1
	.byte 2, 2, -2		# Grass, Grass, -2
	.byte 2, 3, -4		# Grass, Water, -4
	.byte 2, 4, -2		# Grass,  Psycho,  -2
	.byte 2, 5, -1		# Grass, Futebol, -1
	.byte 3, 1, -4		# Water, Fire, -1
	.byte 3, 2, -1		# Water, Grass, -1
	.byte 3, 3, -2		# Water, Water, -2
	.byte 3, 4, -2		# Water,  Psycho,  -2
	.byte 3, 5, -1		# Water, Futebol, -1
	.byte 4, 1, -2		# Psycho, Fire, -2
	.byte 4, 2, -2		# Psycho, Grass, -2
	.byte 4, 3, -2		# Psycho, Water, -2
	.byte 4, 4, -2		# Psycho,  Psycho,  -2
	.byte 4, 5, -1		# Psycho, Futebol, -1
	.byte 5, 1, -4		# Futebol, Fire, -4
	.byte 5, 2, -5		# Futebol, Grass, -5
	.byte 5, 3, -2		# Futebol, Water, -2
	.byte 5, 4, -4		# Futebol,  Psycho,  -4
	.byte 5, 5, -3		# Futebol, Futebol, -3


.text
MAIN_FIGHT:
	li s9, 1		# Pokemon Player Number
	la s10, Charmander	# Pokemon Address
# Para implementa��o tirar trecho acima e adicionar:
# 	li t0, 1
#	beq t0, s9, CHARMANDER_ADDRESS
# 	li t0, 2
#	beq t0, s9, BULBASSAURO_ADDRESS
# 	li t0, 3
#	beq t0, s9, SQUIRTLE_ADDRESS
# CHARMANDER_ADDRESS:
#	la s10, Charmander
#	ret
# BULBASSAURO_ADDRESS:
#	la s10, Bulbassauro
#	ret
# SQUIRTLE_ADDRESS:
#	la s10, Squirtle
#	ret
	
	li a0, 1		# Player should fight
	li a1, 119		# Enemy
	
	jal FIGHT_ENEMY
	
	li a7, 10
	ecall

#========================================+
#	FIGHT WITH ENEMY PROCEDURE       |
#========================================+

FIGHT_ENEMY:
	# a0 => Should fight (a0 == 0 ? Fight : Not Fight)
	# a1 => Enemy Value
	
	addi sp, sp, -24
	sw ra, 0(sp)		# Return address
	sw a0, 4(sp)		# a0 Value
	sw s0, 8(sp)		# Save s0
	sw s1, 12(sp)		# Save s1
	sw s2, 16(sp)		# Save s2
	sw s3, 20(sp)		# Save s3

	li t1, 119		# Charmander Enemy
	beq a1, t1, ENEMY_RANDOM

END_FIGHT_ENEMY:
	lw ra, 0(sp)
	lw a0, 4(sp)
	lw s0, 8(sp)
	lw s1, 12(sp)
	lw s2, 16(sp)
	lw s3, 20(sp)
	addi sp, sp, 24
	ret
	
ENEMY_RANDOM:
	li a0, 5
	csrr t0, time
	remu a0, t0, a0

	li t1, 0
	beq t1, a0, ENEMY_1

	li t1, 1
	beq t1, a0, ENEMY_2

	li t1, 2
	beq t1, a0, ENEMY_3

	li t1, 3
	beq t1, a0, ENEMY_4

	li t1, 4
	beq t1, a0, ENEMY_5

ENEMY_1:
	la s1, Charmander		# s1 = Charmander    => Original s1 is in stack
	li s3, 1				# s3 =  Pokemon Type => Original s3 is in stack
	j CURRENT_FIGHT
# [Here You can add other enemies]
ENEMY_2:
	la s1, Bulbassauro
	li s3, 2
	j CURRENT_FIGHT
ENEMY_3: 
	la s1, Squirtle
	li s3, 3
	j CURRENT_FIGHT
ENEMY_4: 
	la s1, Xatu
	li s3, 4
	j CURRENT_FIGHT
ENEMY_5: 
	la s1, Fuleco
	li s3, 5
	j CURRENT_FIGHT
#==========================+
#	CURRENT FIGHT      |
#==========================+
CURRENT_FIGHT:

	# RENDER FIGHT SCENE
	#|=========================================================|

	la a0, BATTLE_MENU
	jal PRINT_MAP
	
	la a0, Neymar_Batalha			# a0 = s0 = Enemy 
	li a1, 200			# Horizontal Shift to Right
	li a2, 20			# Vertical Shift to Down
	li a3, 0XFF000000		# Current Frame
	jal PRINT_SINGLE_IMAGE
	
	mv a0, s1			# a0 = s0 = Enemy Pokemon
	li a1, 170			# Horizontal Shift to Right
	li a2, 50			# Vertical Shift to Down
	li a3, 0XFF000000		# Current Frame
	jal PRINT_SINGLE_IMAGE
	
	mv a0, s10 			# a0 = s10 = Player Pokemon
	li a1, 70			# Horizontal Shift to Right		
	li a2, 100			# Vertical Shift to Dowm
	li a3, 0XFF000000		# Current Frame
	jal PRINT_SINGLE_IMAGE

	la a0, damage0			# Load Full Bar
	li a1, 130			# Horizontal Shift to Right
	li a2, 20			# Vertical Shift to Dowm
	li a3, 0XFF000001		# Other Frame
	jal PRINT_SINGLE_IMAGE
	
	la a0, damage0			# Load Full Bar
	li a1, 20			# Horizontal Shift to Right
	li a2, 80			# Vertical Shift to Dowm
	li a3, 0XFF000001		# Other Frame
	jal PRINT_SINGLE_IMAGE
	
	#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	# RENDERIZAR AQUI UMA CAIXA QUE INDICA A LETRA QUE DEVE
	# DEVE SER APERTADA PARA DAR UM ATAQUE
	#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	#|=========================================================|
	
	li s0, 10			# Player Life
	li s1, 10			# Enemy Life
	mv s2, s9			# Pokemon Type
	# s3 = Enemy Pokemon Type

LOOP_CURRENT_FIGHT:
	blez s0, MAIN_PLAYER_LOST_GAME	# Player Lost
	blez s1, AI_LOST_GAME		# A1 Lost

	# KEYBOARD_EVENT
	
	li t0, 0xFF200000
	lw t1, 0(t0)
	andi t1, t1, 0x00000001
	
	beqz t1, LOOP_CURRENT_FIGHT
	jal GAME_KEYBOARD
	
	# CHANGE ENEMY DAMAGE
	li a0, 10
	sub a0, a0, s1
	li a1, 130
	li a2, 20
	jal DAMAGE_BAR
	
	jal AI_ATTACK
	
	# CHANGE PLAYER DAMAGE
	li a0, 10
	sub a0, a0, s0
	li a1, 20
	li a2, 80
	jal DAMAGE_BAR
	
	j LOOP_CURRENT_FIGHT

MAIN_PLAYER_LOST_GAME:
	#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	# !!!!! CHANGE HERE !!!!!
	# PRINT IMAGE SHOWING THAT PLAYER LOST
	# STOP FOR SOME TIME
	#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	la a0, CHAT_BOX
	jal PRINT_MAP

	la a0, Neymar_Ganhou
	li a1, 104
	li a2, 90
	li a3, 0xFF000000
	jal PRINT_SINGLE_IMAGE

	j END_CURRENT_FIGHT
	
AI_LOST_GAME:
	#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	# !!!!! CHANGE HERE !!!!!
	# PRINT IMAGE SHOWING THAT AI LOST
	# STOP FOR SOME TIME
	#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	la a0, PLAYER_WIN
	jal PRINT_MAP

	la a0, Neymar_Ganhou
	li a1, 110
	li a2, 90
	li a3, 0xFF000000
	jal PRINT_SINGLE_IMAGE

	j END_CURRENT_FIGHT

END_CURRENT_FIGHT:
	j END_FIGHT_ENEMY


#=========================+
#	GAME KEYBOARD	  |
#=========================+
GAME_KEYBOARD:
	li t0, 0xFF200004
	lb t0, 0(t0)
	
	li t1, 'z'
	beq t0, t1, PRESS_SIMPLE_ATACK_Z

	li t1, 'x'
	beq t0, t1, PRESS_SPECIAL_ATACK_X

	li t1, 'c'					# Use item
	beq t0, t1, PRESS_POTION

	ret

PRESS_POTION:
	addi s0, s0, 2			# Total of HP restored
	li t0, 10
	bgt s0, t0, FULL_LIFE
	li t0, 9
	beq s0, t0, BAR9
	li t0, 8
	beq s0, t0, BAR8
	li t0, 7
	beq s0, t0, BAR7
	li t0, 6
	beq s0, t0, BAR6
	li t0, 5
	beq s0, t0, BAR5
	li t0, 4
	beq s0, t0, BAR4
	li t0, 3
	beq s0, t0, BAR3
	li t0, 2
	beq s0, t0, BAR2
	li t0, 1
	beq s0, t0, BAR1
	ret
FULL_LIFE:
	li a0, 0
	li s0, 10
	ret
BAR1:
	li a0, 9
	ret
BAR2:
	li a0, 8
	ret
BAR3:
	li a0, 7
	ret
BAR4:
	li a0, 6
	ret
BAR5:
	li a0, 5
	ret
BAR6:
	li a0, 4
	ret
BAR7:
	li a0, 3
	ret
BAR8:
	li a0, 2
	ret
BAR9:
	li a0, 1
	ret
#	PLAYER ATACKS
PRESS_SIMPLE_ATACK_Z:
	# When this function is running:
	#	s1 = Enemy Life
	addi s1, s1, -1
	ret

PRESS_SPECIAL_ATACK_X:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	mv a0, s2		# s2 = Player Pokemon Type
	mv a1, s3		# s3 = Enemy Pokemon Type
	jal FIGHT_MATCH
	
	add s1, s1, a0		# s1 += a0 => Apply damage on Enemy
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

#=======================+
#	AI ATTACK	|
#=======================+
AI_ATTACK:
	# li a7, 42
	# li a1, 2
	# ecall
	li a0, 2
	csrr t0, time
	remu a0, t0, a0

	bnez a0, AI_ATTACK_2

AI_ATTACK_1:
	addi s0, s0, -1
	ret
AI_ATTACK_2:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	mv a0, s3		# s3 = Enemy Pokemon Type
	mv a1, s2		# s2 = Player Pokemon Type

	jal FIGHT_MATCH
	
	add s0, s0, a0		# s1 += a0 => Apply damage on Enemy
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
#========================+
#	FIGHT MATCH	 |
#========================+
FIGHT_MATCH:
	# a0 => Who is attacking type
	# a1 => Who is getting attack
	# Return: a0 = Damage
	
	la t0, FIGHT_TYPES	# Match Fight Types
	li t1, 0		# Counter
	mv t2, t0		# t2 = Current Pokemon Battle Match
	addi t2, t2, 1		# t2 += 1 => First Match Address
	lb t0, 0(t0)		# t0 = Possible Matchs
	
LOOP_FIGHT_MATCH:
	beq t1, t0, END_LOOP_FIGHT_MATCH

	lb t3, 0(t2)					# t3 = Expected pokemon type from player
	lb t4, 1(t2)					# t2 = Expected pokemon type from enemy
	lb t5, 2(t2)					# How much of damage (is a negative number)
	
	bne a0, t3, NEXT_LOOP_FIGHT_MATCH		# if [player_pokemon_type != t3] =>  NEXT_POSSIBLE_MATCH
	bne a1, t4, NEXT_LOOP_FIGHT_MATCH		# if [enemy_pokemon_type != t2] => NEXT_POSSIBLE_MATCH

	mv a0, t5					# a0 = Damage
	j END_LOOP_FIGHT_MATCH
	
NEXT_LOOP_FIGHT_MATCH:
	addi t1, t1, 1					# t1 += 1
	addi t2, t2, 3					# t2 += 1 => Next Match
	j LOOP_FIGHT_MATCH

END_LOOP_FIGHT_MATCH:
	ret

#=======================+
#	DAMAGE BAR	|
#=======================+
DAMAGE_BAR:
	# a0 => Damage
	# a1 => Horizontal Shift
	# a2 => Vertical Shift
	
	addi sp, sp, -4
	sw ra, 0(sp)

DAMAGE_0:
	li t0, 0
	bne a0, t0, DAMAGE_1
	la a0, damage0
	j PRINT_DAMAGE
DAMAGE_1:
	li t0, 1
	bne a0, t0, DAMAGE_2
	la a0, damage1
	j PRINT_DAMAGE
DAMAGE_2:
	li t0, 2
	bne a0, t0, DAMAGE_3
	la a0, damage2
	j PRINT_DAMAGE
DAMAGE_3:
	li t0, 3
	bne a0, t0, DAMAGE_4
	la a0, damage3
	j PRINT_DAMAGE
DAMAGE_4:
	li t0, 4
	bne a0, t0, DAMAGE_5
	la a0, damage4
	j PRINT_DAMAGE
DAMAGE_5:
	li t0, 5
	bne a0, t0, DAMAGE_6
	la a0, damage5
	j PRINT_DAMAGE
DAMAGE_6:
	li t0, 6
	bne a0, t0, DAMAGE_7
	la a0, damage6
	j PRINT_DAMAGE
DAMAGE_7:
	li t0, 7
	bne a0, t0, DAMAGE_8
	la a0, damage7
	j PRINT_DAMAGE
DAMAGE_8:
	li t0, 8
	bne a0, t0, DAMAGE_9
	la a0, damage8
	j PRINT_DAMAGE
DAMAGE_9:
	li t0, 9
	bne a0, t0, DAMAGE_10
	la a0, damage9
	j PRINT_DAMAGE
DAMAGE_10:
	li t0, 10
	bne a0, t0, END_DAMAGE_BAR
	la a0, damage10
PRINT_DAMAGE:
	li a3, 0xFF000001
	jal PRINT_SINGLE_IMAGE
END_DAMAGE_BAR:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

#==================================+
#	PRINT SINGLE IMAGE	   |
#==================================+

PRINT_SINGLE_IMAGE:
	# a0 => Image
	# a1 => Horizontal Shift
	# a2 => Vertical Shift
	# a3 => Frame
	addi sp, sp, -4
	sw ra, 0(sp)
	
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
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

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
	li t0, 118
	beq a2, t0, GYM_SAND
	# Just Black
	li t0, 121
	beq a2, t0, JUST_BLACK
	# chat
	li t0, 41
	beq a2, t0, CCHAT_DOWN
	li t0, 42
	beq a2, t0, CCHAT_LEFT_DOWN
	li t0, 43
	beq a2, t0, CCHAT_LEFT_UP
	li t0, 44
	beq a2, t0, CCHAT_LEFT
	li t0, 45
	beq a2, t0, CCHAT_MID
	li t0, 46
	beq a2, t0, CCHAT_RIGHT_DOWN
	li t0, 47
	beq a2, t0, CCHAT_RIGHT_UP
	li t0, 48
	beq a2, t0, CCHAT_RIGHT
	li t0, 49
	beq a2, t0, CCHAT_UP

	# Alfabeto
	li t0, 50
	beq a2, t0, LETRA_A
	li t0, 51
	beq a2, t0, LETRA_B
	li t0, 52
	beq a2, t0, LETRA_C
	li t0, 53
	beq a2, t0, LETRA_D
	li t0, 54
	beq a2, t0, LETRA_E
	li t0, 74
	beq a2, t0, LETRA_F
	li t0, 55
	beq a2, t0, LETRA_G
	li t0, 56
	beq a2, t0, LETRA_H
	li t0, 57
	beq a2, t0, LETRA_I
	li t0, 58
	beq a2, t0, LETRA_J
	li t0, 59
	beq a2, t0, LETRA_K
	li t0, 60
	beq a2, t0, LETRA_L
	li t0, 61
	beq a2, t0, LETRA_M
	li t0, 62
	beq a2, t0, LETRA_N
	li t0, 63
	beq a2, t0, LETRA_O
	li t0, 64
	beq a2, t0, LETRA_P
	li t0, 65
	beq a2, t0, LETRA_Q
	li t0, 66
	beq a2, t0, LETRA_R
	li t0, 67
	beq a2, t0, LETRA_S
	li t0, 68
	beq a2, t0, LETRA_T
	li t0, 69
	beq a2, t0, LETRA_U
	li t0, 70
	beq a2, t0, LETRA_V
	li t0, 71
	beq a2, t0, LETRA_X
	li t0, 72
	beq a2, t0, LETRA_Y
	li t0, 73
	beq a2, t0, LETRA_Z
	ret

GYM_SAND:
	la a2, sand
	j PRINT_BLOCK_SELECTED
JUST_BLACK:
	la a2, black
	j PRINT_BLOCK_SELECTED
CCHAT_DOWN:
	la a2, chat_down
	j PRINT_BLOCK_SELECTED
CCHAT_LEFT_DOWN:
	la a2, chat_left_down
	j PRINT_BLOCK_SELECTED
CCHAT_LEFT_UP:
	la a2, chat_left_up
	j PRINT_BLOCK_SELECTED
CCHAT_LEFT:
	la a2, chat_left
	j PRINT_BLOCK_SELECTED
CCHAT_MID:
	la a2, chat_mid
	j PRINT_BLOCK_SELECTED
CCHAT_RIGHT_DOWN:
	la a2, chat_right_down
	j PRINT_BLOCK_SELECTED
CCHAT_RIGHT_UP:
	la a2, chat_right_up
	j PRINT_BLOCK_SELECTED
CCHAT_RIGHT:
	la a2, chat_right
	j PRINT_BLOCK_SELECTED
CCHAT_UP:
	la a2, chat_up
	j PRINT_BLOCK_SELECTED
# Alfabeto
LETRA_A:
	la a2, A
	j PRINT_BLOCK_SELECTED
LETRA_B:
	la a2, B
	j PRINT_BLOCK_SELECTED
LETRA_C:
	la a2, C
	j PRINT_BLOCK_SELECTED
LETRA_D:
	la a2, D
	j PRINT_BLOCK_SELECTED
LETRA_E:
	la a2, E
	j PRINT_BLOCK_SELECTED
LETRA_F:
	la a2, F
	j PRINT_BLOCK_SELECTED
LETRA_G:
	la a2, G
	j PRINT_BLOCK_SELECTED
LETRA_H:
	la a2, H
	j PRINT_BLOCK_SELECTED
LETRA_I:
	la a2, I
	j PRINT_BLOCK_SELECTED
LETRA_J:
	la a2, J
	j PRINT_BLOCK_SELECTED
LETRA_K:
	la a2, K
	j PRINT_BLOCK_SELECTED
LETRA_L:
	la a2, L
	j PRINT_BLOCK_SELECTED
LETRA_M:
	la a2, M
	j PRINT_BLOCK_SELECTED
LETRA_N:
	la a2, N
	j PRINT_BLOCK_SELECTED
LETRA_O:
	la a2, O
	j PRINT_BLOCK_SELECTED
LETRA_P:
	la a2, P
	j PRINT_BLOCK_SELECTED
LETRA_Q:
	la a2, Q
	j PRINT_BLOCK_SELECTED
LETRA_R:
	la a2, R
	j PRINT_BLOCK_SELECTED
LETRA_S:
	la a2, S
	j PRINT_BLOCK_SELECTED
LETRA_T:
	la a2, T
	j PRINT_BLOCK_SELECTED
LETRA_U:
	la a2, U
	j PRINT_BLOCK_SELECTED
LETRA_V:
	la a2, V
	j PRINT_BLOCK_SELECTED
LETRA_X:
	la a2, X
	j PRINT_BLOCK_SELECTED
LETRA_Y:
	la a2, Y
	j PRINT_BLOCK_SELECTED
LETRA_Z:
	la a2, Z
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

