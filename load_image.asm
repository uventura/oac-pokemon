.data
	.include "sprites/template.s"
	.include "sprites/pokemons/chat.data"
	.include "sprites/pokemons/Bulbassauro.data"
.text
MAIN:
	la a0, chat
	li a1, 0
	li a2, 12
	li a3, 0xFF000000
	jal PRINT_IMAGE
	
	li a7, 10
	ecall

PRINT_IMAGE:
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
	
	li t6, 320
	mul t5, a2, t6
	add t5, t5, a1
	add t5, t5, a3
	mv t6, t5
	
	addi a0, a0, 8

LOOP_PRINT_IMAGE:
	beq t1, t3, LOOP_END_PRINT_IMAGE	# [if t3 == t1 <> row_counter == height] => End_Print_Image
	
IMAGE_LOOP_COL:
	beq t2, t4, END_IMAGE_LOOP_COL		# [if t4 == t2 <> col_counter == width] => End_Print_Col
	lw t0, 0(a0)				# t6 = current_pixel
	addi a0, a0, 4				# t0 += t1 => Next Pixel
	sw t0, 0(t5)				# R[t5] = Current_Pixel
	addi t5, t5, 4				# t5 += 1 => Next Place to Store Pixel
	addi t4, t4, 4				# t4 += 1 => Next Col
	j IMAGE_LOOP_COL
END_IMAGE_LOOP_COL:
	addi t3, t3, 1				# t3 += 1 => Next Line
	#ebreak
	li t4, 320				# t4 = 320
	mul t4, t3, t4				# t5 = t3 * t4 = current_line * 320
	add t5, t6, t4
	li t4, 0				# t4 = 0 => Reset col_counter
	j LOOP_PRINT_IMAGE
LOOP_END_PRINT_IMAGE:
	ret
	
