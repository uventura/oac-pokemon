.data
	.include "sprites/Sprites_Scenes/cenario_aberto/rass.s"

	.include "scenes/wild_Tscreen.s"
	.include "sprites/pokemons/Charmander.data"

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
	# 1 => fire
	# 2 => Pycho
	# 3 => Water
	
	.byte 3			# Number of Special Fights	

	# .byte PLAYER_POKEMON_TYPE, ENEMY_POKEMON_TYPE, VALUE_LOST 
	.byte 1, 1, -5		# Fire,  Fire,  -1
	.byte 1, 2, -2		# Fire,  Leaf,  -2
	.byte 2, 3, -1		# Water, Water, -1

.text
MAIN_FIGHT:
	li s9, 1		# Pokemon Player Number
	la s10, Charmander	# Pokemon Address
	
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
	beq a1, t1, ENEMY_1

END_FIGHT_ENEMY:
	lw ra, 0(sp)
	lw a0, 4(sp)
	lw s0, 8(sp)
	lw s1, 12(sp)
	lw s2, 16(sp)
	lw s3, 20(sp)
	addi sp, sp, 24
	ret
	
ENEMY_1:
	la s1, Charmander		# s1 = Charmander    => Original s1 is in stack
	li s3, 1			# s3 =  Pokemon Type => Original s3 is in stack
	j CURRENT_FIGHT
# [Here You can add other enemies]

#==========================+
#	CURRENT FIGHT      |
#==========================+
CURRENT_FIGHT:

	# RENDER FIGHT SCENE
	#|=========================================================|

	la a0, WILD_TSCREEN
	jal PRINT_MAP
	
	mv a0, s1			# a0 = s0 = Enemy Pokemon
	li a1, 150			# Horizontal Shift to Right
	li a2, 30			# Vertical Shift to Down
	li a3, 0XFF000000		# Current Frame
	jal PRINT_SINGLE_IMAGE
	
	mv a0, s10 			# a0 = s10 = Player Pokemon
	li a1, 20			# Horizontal Shift to Right		
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
	j END_CURRENT_FIGHT
	
AI_LOST_GAME:
	#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	# !!!!! CHANGE HERE !!!!!
	# PRINT IMAGE SHOWING THAT AI LOST
	# STOP FOR SOME TIME
	#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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
	li a7, 42
	li a1, 2
	ecall

	bnez a0, AI_ATTACK_2

AI_ATTACK_1:
	addi s0, s0, -1
	ret
AI_ATTACK_2:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	mv a0, s3		# s2 = Player Pokemon Type
	mv a1, s2		# s3 = Enemy Pokemon Type
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
	addi t2, t1, 1					# t2 += 1 => Next Match
	j FIGHT_MATCH

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
	li t0, 16
	beq a2, t0, WILD_CUT_GRASS
	
	ret

WILD_CUT_GRASS:
	la a2, rass
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

