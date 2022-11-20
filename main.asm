.data
	.include "sprites/grass1.s"
	.include "sprites/ground1.s"
	
MAP_1:
	.byte 
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
	1,1,1,1,1,1,2,2,2,1,1,1,1,1,1,1,1,1,1,1,
	1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,
	1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,
	1,1,1,1,1,1,1,1,2,2,1,1,1,1,1,1,1,1,1,1,
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,

.text
	li a3, 0
	li a4, 0
	la a5, MAP_1

PRINT_MAP:
	mv a0, a4
	mv a1, a3
	lb a2, 0(a5)
	jal BLOCK_SELECTION
	
	addi a5, a5, 1
	addi a3, a3, 1
	li t0, 20
	bne t0, a3, PRINT_MAP
NEW_LINE_MAP:
	addi a4, a4, 1
	li a3, 0
	li t0, 15
	bne t0, a4, PRINT_MAP
	
EXIT:
	# Exit
	li a7, 10
	ecall

#=============================+
#	BLOCKS SELECTION      |
#=============================+
# This procedure allows you to select blocks that you define in some map

# a0 => Block Line, a1 => Block Col, a2 => Type of Block
BLOCK_SELECTION:
	li t0, 1		
	beq a2, t0, BLOCK_1	# if a2 == 1, then BLOCK_1
	li t0, 2		
	beq a2, t0, BLOCK_2	# if a2 == 2, then BLOCK_2
	ret
BLOCK_1:
	la a2, grass1
	j PRINT_BLOCK_SELECTED
BLOCK_2:
	la a2, ground1
	j PRINT_BLOCK_SELECTED
PRINT_BLOCK_SELECTED:
	addi a2, a2, 8
	j PRINT_BLOCK
END_BLOCK_SELECTION:
	ret

#=============================+
#         PRINT BLOCK	      |
#=============================+

PRINT_BLOCK: # (a0 => Block Line, a1 => Block Col, a2 => Color)
	# (Width = 16, Height = 16) => The screen has 320X240, so you will have a grid with 20x15
	mv t0, a2			# t0 = Color Address
	li t1, 0			# t1 = Line Counter
	
NEW_BLOCK_LINE:
	# Pixel_Cell_Address = Represents the start address(or pixel) where the block will be printed
	# Pixel_Cell_Address = 0XFF000000 + 320 * line_counter + block_col * width + 320 * block_line * height
	# Pixel_Cell_Address = 0XFF000000 + 320 * line_counter + block_col * 16 + 320 * block_line * 16
	# Pixel_Cell_Address = 0XFF000000 + 64 * 5 * (line_counter + block_line * 16) + 16 * block_Col

	slli t2, a0, 4			# t2 = a0 << 4 = a0 * 16 = pixel_line * 16
	add t2, t2, t1			# t2 = t2 + t1 =  pixel_line * 16 + line_counter
	li t3, 5			# t3 = 5
	mul t2, t2, t3			# t2 = t2 * t3 = t2 * 5 = (pixel_line * 16 + line_counter) * 5
	slli t2, t2, 6			# t2 = t2 << 6 = t2 * 64 = (pixel_line * 16 + line_counter) * 5 * 64
	slli t3, a1, 4			# t3 = a1 << 4 = block_col * 16
	add t2, t2, t3			# t2 = t2 + t3 = (pixel_line * 16 + line_counter) * 5 * 64 + block_col * 16
	li t3, 0xFF000000		# t3 = 0xFF000000
	add t2, t2, t3 			# t2 = (pixel_line * 16 + line_counter) * 5 * 64 + block_col * 16 + 0XFF000000
	
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
