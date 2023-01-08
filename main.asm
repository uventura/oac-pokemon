.data
	# Sprites
	.include "sprites/grass1.s"
	.include "sprites/ground1.s"
	.include "sprites/player_1.s"
	
	# Scenes	
	.include "scenes/scene01.s"
	
#			            Lives      Type
# Monster bitset: 0000000000000000 00000000 00000000
PLAYER_MONSTERS: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	# Monsters Inventory

.text
MAIN:
	li s0, 3			# Player row
	li s1, 2			# Player col
	la s2, MAP_1			# Current Map
	
GAME_SETTING: 
	la a0, MAP_1
	jal PRINT_MAP
	
	la a0, OBJECT_MAP_1
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

	li a0, 100			# Wait 250ms
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
	
	lw ra, 0(sp)			# Recover return address
	addi sp, sp, 36			# Back stack
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
	li t0, 1		
	beq a2, t0, BLOCK_1	# if a2 == 1, then BLOCK_1
	li t0, 2		
	beq a2, t0, BLOCK_2	# if a2 == 2, then BLOCK_2
	li t0, 3
	beq a2, t0, BLOCK_3	# Temporary Character
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
