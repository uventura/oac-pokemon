MAP_2:
	.byte 
	16,16,32,32,32,32,32,32,16,16,29,27,27,30,16,16,16,32,32,32,
	16,16,16,32,32,32,32,16,16,16,29,27,27,30,16,16,16,16,32,32,
	16,16,16,16,16,16,16,16,16,16,29,27,27,30,16,16,16,16,32,32,
	16,16,16,16,16,16,16,16,16,16,29,27,27,30,16,16,16,16,16,32,
	16,16,16,16,16,16,16,16,16,16,29,27,27,27,25,16,16,16,16,16,
	32,16,16,16,16,16,16,16,16,16,23,27,27,27,27,31,25,16,16,16,
	32,32,16,16,16,16,16,16,16,16,16,29,27,27,27,27,27,31,31,31,
	32,32,32,32,16,16,16,16,16,16,16,29,27,27,27,27,27,27,27,27,
	117,117,117,117,117,16,31,31,31,31,31,27,27,27,27,27,27,27,27,27,
	19,19,19,19,19,21,27,27,27,27,27,27,27,27,27,28,28,28,28,28,
	19,19,19,19,19,21,28,28,28,28,28,28,28,28,24,16,16,16,16,16,
	19,19,19,19,19,21,32,16,16,16,16,16,16,16,16,16,16,32,32,32,
	19,19,19,19,19,21,32,32,16,16,16,16,16,16,16,16,32,32,32,32,
	19,19,19,19,19,21,32,32,16,16,16,16,32,32,32,32,32,32,32,32,
	19,19,19,19,19,21,32,32,16,16,16,32,32,32,32,32,32,32,32,32,
	
OBJECT_MAP_2:
	.byte 12				# Amount of objects
	# lake 12
	.byte 14, 5, 21, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 13, 5, 21, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 12, 5, 21, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 11, 5, 21, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 10, 5, 21, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 9, 5, 21, 0, 0		# Character Map => row, col, object, off_x, off_y

	.byte 8, 5, 17, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 8, 4, 117, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 8, 3, 117, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 8, 2, 117, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 8, 1, 117, 0, 0		# Character Map => row, col, object, off_x, off_y
	.byte 8, 0, 117, 0, 0		# Character Map => row, col, object, off_x, off_y

LOCATION_CHANGE_2:
	.byte 4							# Amount of locations
	.byte 0, 11, 1, 13, 9			# Location => row, col, scene, new_player_row, new_player_col
	.byte 0, 12, 1, 13, 10			# Location => row, col, scene, new_player_row, new_player_col
	.byte 7, 19, 3, 13, 9			# Location => row, col, scene, new_player_row, new_player_col
	.byte 8, 19, 3, 13, 10			# Location => row, col, scene, new_player_row, new_player_col
