.data
	# World
	.include "sprites/grass1.s"
	.include "sprites/ground1.s"
	
	# Objects
	.include "sprites/table_01.s"
	.include "sprites/table_02.s"
	
	# Player 
	.include "sprites/player_1.s"
	
	# Scenes	
	.include "scenes/scene01.s"
	.include "scenes/scene02.s"

.text
MAIN:
	li s0, 3			# Player row
	li s1, 2			# Player col
	la s2, MAP_1			# Current Map
	la s3, OBJECT_MAP_1		# Current Object Mapping
	la s4, LOCATION_CHANGE_1	# Location to change
	
GAME_SETTING: 
	mv a0, s2 
	jal PRINT_MAP
	
	mv a0, s3
	jal OBJECT_RENDERING
	
	mv a0, s0			# Lines to moves
	mv a1, s1			# Rows to move
	li a2, 3			# Player Image
	li a3, 0			# Player between image
	li a4, 0
	jal BLOCK_SELECTION
	
GAME_LOOP:
	# Keyboard Event
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
	
	j END_GAME_KEYBOARD
	
PRESS_MOVE_W:
	li a0, -1
	li a1, 0
	li a2, 3
	li a3, 3
	li a4, 0
	li a5, 8
	j MOVE_PLAYER
	
PRESS_MOVE_S:
	li a0, 1
	li a1, 0
	li a2, 3
	li a3, 3
	li a4, 0
	li a5, -8
	j MOVE_PLAYER

PRESS_MOVE_A:
	li a0, 0
	li a1, -1
	li a2, 3
	li a3, 3
	li a4, 0
	li a5, 0
	j MOVE_PLAYER

PRESS_MOVE_D:
	li a0, 0
	li a1, 1
	li a2, 3
	li a3, 3
	li a4, 0
	li a5, 0
	j MOVE_PLAYER

PRESS_EXIT:
	j EXIT
END_GAME_KEYBOARD:
	ret

#=====================================+
#	CHANGE CURRENT LOCATION	      |
#=====================================+
CHANGE_CURRENT_LOCATION: # a0 => player_row, a1 => player_col, a3 => scene
	mv s0, a0
	mv s1, a1
	
	mv a0, a3
	li a7, 1
	ecall

	li t0, 1
	beq t0, a3, SCENE_1
	
	li t0, 2
	beq t0, a3, SCENE_2

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
	# a6 => Current Map Address
	
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
	
	add a0, a0, s0			# New Row Player Position
	add a1, a1, s1			# New Col Player Position
	
	bltz a0, END_PLAYER_MOVE
	bltz a1, END_PLAYER_MOVE
	li t0, 15
	bgt a0, t0, END_PLAYER_MOVE
	li t0, 20
	bgt a1, t0, END_PLAYER_MOVE
	
	# Object Collision
	mv a3, s3			# Current Scene Objects
	jal PLAYER_COLLISION
	beqz a0, END_PLAYER_MOVE	# Player Collides
	
	# Location Collision
	lw a0, 4(sp)
	add a0, a0, s0
	
	lw a1, 8(sp)
	add a1, a1, s1
	
	mv a3, s4
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
	li a7, 32			# Sleep Action
	ecall				# Call Sleep

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
	
	mv a3, a1			# new scene
	lw a0, 4(sp)			# dr = Load row movement
	lw a1, 8(sp)			# dc = Load col movement
	add a0, a0, s0			# new_row = row + dr
	add a1, a1, s0			# new_col = col + dc
	
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

#=======================================+
#	PLAYER COLLIDES IN ACTION	|
#=======================================+
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
	li t0, 1		
	beq a2, t0, BLOCK_1	# if a2 == 1, then BLOCK_1
	li t0, 2		
	beq a2, t0, BLOCK_2	# if a2 == 2, then BLOCK_2
	li t0, 3
	beq a2, t0, BLOCK_3	# Temporary Character
	li t0, 4
	beq a2, t0, BLOCK_4	# Table Left
	li t0, 5
	beq a2, t0, BLOCK_5	# Table Right
	ret
BLOCK_1:
	la a2, grass1
	j PRINT_BLOCK_SELECTED
BLOCK_2:
	la a2, ground1
	j PRINT_BLOCK_SELECTED
BLOCK_3:	# Temporary Character
	la a2, player_1
	j PRINT_BLOCK_SELECTED
BLOCK_4:
	la a2, table_01
	j PRINT_BLOCK_SELECTED
BLOCK_5:
	la a2, table_02
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
