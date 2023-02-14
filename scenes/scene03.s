MAP_3:
	.byte 
	34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,
	33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,
	38,118,118,118,36,36,36,36,36,36,36,36,36,36,36,36,118,118,118,38,
	37,118,118,118,36,36,36,36,36,36,36,36,36,36,36,36,118,118,118,37,
	118,118,118,118,118,118,36,36,36,36,36,36,36,36,118,118,118,118,118,118,
	118,118,118,118,118,118,118,118,36,36,36,36,118,118,118,118,118,118,118,118,
	118,118,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,118,118,
	118,118,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,118,118,
	118,118,118,118,118,118,118,118,118,36,36,118,118,118,118,118,118,118,118,118,
	118,118,118,118,118,118,118,118,118,36,36,118,118,118,118,118,118,118,118,118,
	118,118,118,118,118,118,36,36,36,36,36,36,36,36,118,118,118,118,118,118,
	36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,
	36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,
	36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,
	36,36,36,36,36,36,36,36,36,35,35,36,36,36,36,36,36,36,36,36,
	
OBJECT_MAP_3:
	.byte 34			        # Amount of objects
	# Bounderies
	
	# Windows 14
	.byte 0, 1, 40, 0, 8		# Character Map => row, col, object, off_x, off_y
	.byte 0, 2, 40, 0, 8		# Character Map => row, col, object, off_x, off_y
	.byte 0, 3, 39, 0, 8		# Character Map => row, col, object, off_x, off_y
	.byte 0, 4, 40, 0, 8		# Character Map => row, col, object, off_x, off_y
	.byte 0, 5, 39, 0, 8		# Character Map => row, col, object, off_x, off_y
	.byte 0, 6, 40, 0, 8		# Character Map => row, col, object, off_x, off_y
	.byte 0, 7, 39, 0, 8		# Character Map => row, col, object, off_x, off_y
	.byte 0, 12, 40, 0, 8		# Character Map => row, col, object, off_x, off_y
	.byte 0, 13, 39, 0, 8		# Character Map => row, col, object, off_x, off_y
	.byte 0, 14, 40, 0, 8		# Character Map => row, col, object, off_x, off_y
	.byte 0, 15, 39, 0, 8		# Character Map => row, col, object, off_x, off_y
	.byte 0, 16, 40, 0, 8		# Character Map => row, col, object, off_x, off_y
	.byte 0, 17, 39, 0, 8		# Character Map => row, col, object, off_x, off_y
	.byte 0, 18, 40, 0, 8		# Character Map => row, col, object, off_x, off_y
	# Statues 4  4  4  4  4
	.byte 14, 8, 37, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 13, 8, 38, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 14, 11, 37, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 13, 11, 38, 0, 0		# Character Map => row, col, object, off_x, off_y

	.byte 11, 0, 37, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 10, 0, 38, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 11, 19, 37, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 10, 19, 38, 0, 0		# Character Map => row, col, object, off_x, off_y

	.byte 10, 6, 37, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 9, 6, 38, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 10, 13, 37, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 9, 13, 38, 0, 0		# Character Map => row, col, object, off_x, off_y

	.byte 6, 2, 37, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 5, 2, 38, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 6, 17, 37, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 5, 17, 38, 0, 0		# Character Map => row, col, object, off_x, off_y

	.byte 3, 8, 37, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 2, 8, 38, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 3, 11, 37, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 2, 11, 38, 0, 0		# Character Map => row, col, object, off_x, off_y

LOCATION_CHANGE_3:
	.byte 2				    		# Amount of locations
	.byte 14, 9, 2, 7, 18			# Location => row, col, scene, new_player_row, new_player_col
    .byte 14, 10, 2, 8, 18			# Location => row, col, scene, new_player_row, new_player_col