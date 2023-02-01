MAP_1:
	.byte 
	5,10,11,12,5,5,5,5,5,5,5,5,5,5,5,5,10,11,12,5,
	5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,
	5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,
	5,5,5,5,5,5,5,5,5,5,5,5,5,6,7,6,7,5,5,5,
	5,5,5,5,5,5,5,5,5,5,5,5,5,8,9,8,9,5,5,5,
	5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,
	2,3,2,3,5,5,5,5,5,5,5,5,2,3,2,3,2,3,2,3,
	4,1,4,1,5,5,5,5,5,5,5,5,4,1,4,1,4,1,4,1,
	5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,
	5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,
	5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,
	5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,
	5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,
	5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,
	5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,
	
OBJECT_MAP_1:
	.byte 32				# Amount of objects
	# Estantes esquerda	8
	.byte 6, 0, 2, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 7, 0, 4, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 6, 1, 3, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 7, 1, 1, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 6, 2, 2, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 7, 2, 4, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 6, 3, 3, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 7, 3, 1, 0, 0		# Character Map => row, col, object, off_x, off_y
	# Estante direita 16
	.byte 6, 12, 2, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 7, 12, 4, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 6, 13, 3, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 7, 13, 1, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 6, 14, 2, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 7, 14, 4, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 6, 15, 3, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 7, 15, 1, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 6, 16, 2, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 7, 16, 4, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 6, 17, 3, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 7, 17, 1, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 6, 18, 2, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 7, 18, 4, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 6, 19, 3, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 7, 19, 1, 0, 0		# Character Map => row, col, object, off_x, off_y
	# Mesa	8
	.byte 3, 13, 6, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 4, 13, 8, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 3, 14, 7, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 4, 14, 9, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 3, 15, 6, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 4, 15, 8, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 3, 16, 7, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 4, 16, 9, 0, 0		# Character Map => row, col, object, off_x, off_y

LOCATION_CHANGE_1:
	.byte 2							# Amount of locations
	.byte 14, 9, 2, 1, 11			# Location => row, col, scene, new_player_row, new_player_col
	.byte 14, 10, 2, 1, 12			# Location => row, col, scene, new_player_row, new_player_col
