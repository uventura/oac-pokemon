MAP_3:
	.byte 
	34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,
	33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,
	38,36,36,36,36,36,36,36,38,36,36,38,36,36,36,36,36,36,36,38,
	37,36,36,36,36,36,36,36,37,36,36,37,36,36,36,36,36,36,36,37,
	36,36,36,38,36,36,36,36,36,36,36,36,36,36,36,36,38,36,36,36,
	36,36,36,37,38,36,36,36,36,36,36,36,36,36,36,38,37,36,36,36,
	36,36,36,36,37,38,36,36,36,36,36,36,36,36,38,37,36,36,36,36,
	36,36,36,36,36,37,36,36,36,36,36,36,36,36,37,36,36,36,36,36,
	34,34,34,34,36,34,34,34,34,34,34,34,34,34,34,36,34,34,34,34,
	33,33,33,33,36,33,33,33,33,33,33,33,33,33,33,36,33,33,33,33,
	36,36,36,38,36,36,36,36,36,36,36,36,36,36,36,36,38,36,36,36,
	36,36,36,37,36,36,36,36,36,36,36,36,36,36,36,36,37,36,36,36,
	36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,
	36,36,36,36,36,36,36,36,38,36,36,38,36,36,36,36,36,36,36,36,
	36,36,36,36,36,36,36,36,37,35,35,37,36,36,36,36,36,36,36,36,
	
OBJECT_MAP_3:
	.byte 14			        # Amount of objects
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

LOCATION_CHANGE_3:
	.byte 2				    		# Amount of locations
	.byte 14, 9, 2, 7, 18			# Location => row, col, scene, new_player_row, new_player_col
    .byte 14, 10, 2, 8, 18			# Location => row, col, scene, new_player_row, new_player_col