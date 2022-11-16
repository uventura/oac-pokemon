.data
	.include "sprites/grass1.s"
.text
	li a3, 0
	li a4, 0

PRINT_MAP:
	mv a0, a4
	mv a1, a3
	la a2, grass1 # Block Address
	addi a2, a2, 8
	jal PRINT_BLOCK
	
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
#         PRINT BLOCK	      |
#=============================+

PRINT_BLOCK: # (a0 => Block Line, a1 => Block Col, a2 => Color)
	# Width = 16, Height = 16
	mv t0, a2			# t0 = Color Address
	li t1, 0			# t1 = Current Line
	
NEW_BLOCK_LINE:
	# Next Line Address = 0XFF000000 + 320.LineCounter + Block_Col * width + 320 * Block_Line * height
	# Pixel_Cell_Address = 0XFF000000 + 320 * (line_counter + 16 * pixel_line)
	# Next Line Address = 0XFF000000 + 320.(lineCounter + Block_Line * height) + Block_Col * width
	
	# Pixel_Cell_Address = 0XFF000000 + 320.line_counter + Pixel_Col * 16 + 320 * Pixel_Line * 16
	# Pixel_Cell_Address = 0XFF000000 + 16*2*10*line_counter + Pixel_Col * 16 + 16 * 2 * 10 * Pixel_Line * 16
	# Pixel_Cell_Address = 0XFF000000 + 16 * (2 * 10 * line_counter + Pixel_Col + 2 * 10 * pixel_line)
	# Pixel_Cell_Address = 0XFF000000 + 64 * 5 * (line_counter + pixel_line * 16) + 16 * Pixel_Col

	slli t2, a0, 4
	add t2, t2, t1			# t2 = t1 + a0 = lineCounter + pixel_line
	li t3, 5			# t3 = 5
	mul t2, t2, t3			# t2 = t2 * t3 = t2 * 5
	slli t2, t2, 6			# t2 = t2 << 6 = t2 * 64
	slli t3, a1, 4			# t3 = a1 << 4 = block_col * 16
	add t2, t2, t3			# t2 = t2 + t3
	li t3, 0xFF000000
	add t2, t2, t3 			# t2 = t2 + 0XFF000000
	
	li t3, 0
	li t4, 4
STORE_BLOCK_COLOR:
	lw t5, 0(t0)			
	sw t5, 0(t2)
	addi t0, t0, 4
	addi t2, t2, 4
	addi t3, t3, 1
	bne t3, t4, STORE_BLOCK_COLOR
	
	addi t1, t1, 1
	li t2, 16
	
	bne t2, t1, NEW_BLOCK_LINE
	ret