MAP_1:
	# Lab
	.byte 
	14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,
	13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,
	8,9,8,9,8,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,
	7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,
	7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,
	7,7,7,7,7,7,7,7,7,7,7,7,7,115,116,114,7,7,7,7,
	7,7,7,7,7,7,7,7,7,7,7,7,7,7,113,7,7,7,7,7,
	7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,
	5,6,5,6,5,6,7,7,7,7,7,7,7,7,7,7,5,6,5,6,
	3,4,3,4,3,4,7,7,7,7,7,7,7,7,7,7,3,4,3,4,
	7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,
	5,6,5,6,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,
	3,4,3,4,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,
	7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,
	7,7,7,7,7,7,7,7,7,1,2,7,7,7,7,7,7,7,7,7,
	
OBJECT_MAP_1:
	.byte 55				# Amount of objects
	# Estante direita 8
	.byte 8, 16, 5, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 9, 16, 3, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 8, 17, 6, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 9, 17, 4, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 8, 18, 5, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 9, 18, 3, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 8, 19, 6, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 9, 19, 4, 0, 0		# Character Map => row, col, object, off_x, off_y
	# Estante equerda cima 12
	.byte 8, 0, 5, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 9, 0, 3, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 8, 1, 6, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 9, 1, 4, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 8, 2, 5, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 9, 2, 3, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 8, 3, 6, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 9, 3, 4, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 8, 4, 5, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 9, 4, 3, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 8, 5, 6, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 9, 5, 4, 0, 0		# Character Map => row, col, object, off_x, off_y
	# Estante esquerda baixo 8
	.byte 11, 0, 5, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 12, 0, 3, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 11, 1, 6, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 12, 1, 4, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 11, 2, 5, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 12, 2, 3, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 11, 3, 6, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 12, 3, 4, 0, 0		# Character Map => row, col, object, off_x, off_y
	# Mesa Esquerda 7
	.byte 3, 0, 10, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 3, 1, 11, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 3, 2, 10, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 3, 3, 11, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 3, 4, 10, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 2, 5, 9, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 3, 5, 11, 0, 0		# Character Map => row, col, object, off_x, off_y
	# Wall 14
	.byte 1, 6, 13, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 1, 7, 13, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 1, 8, 13, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 1, 9, 13, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 1, 10, 13, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 1, 11, 13, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 1, 12, 13, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 1, 13, 13, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 1, 14, 13, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 1, 15, 13, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 1, 16, 13, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 1, 17, 13, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 1, 18, 13, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 1, 19, 13, 0, 0		# Character Map => row, col, object, off_x, off_y
	# Window 3
	.byte 0, 6, 15, 0, 8		# Character Map => row, col, object, off_x, off_y
	.byte 0, 7, 15, 0, 8		# Character Map => row, col, object, off_x, off_y
	.byte 0, 8, 15, 0, 8		# Character Map => row, col, object, off_x, off_y
	# Pokeball ('J', 'K, 'L')
	.byte 5, 13, 110, 0, -4		# Character Map => row, col, object, off_x, off_y
	.byte 5, 14, 110, 0, -4		# Character Map => row, col, object, off_x, off_y
	.byte 5, 15, 110, 0, -4		# Character Map => row, col, object, off_x, off_y

LOCATION_CHANGE_1:
	.byte 2							# Amount of locations
	.byte 14, 9, 2, 1, 11			# Location => row, col, scene, new_player_row, new_player_col
	.byte 14, 10, 2, 1, 12			# Location => row, col, scene, new_player_row, new_player_col
