key_up = keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up);
key_down = keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down);
key_left = keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left);
key_right = keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right);
board_change = false;

if (key_up || key_down || key_left || key_right) {
	obj_tile.just_created = false;
}

if (key_up) {
	// checks row (y)
	for (row = 512; row <= 768; row += 128) {
		// checks column (x)
		for (col = 128; col <= 512; col += 128) {
			var temp_id = instance_place(col, row, obj_tile);
			if (temp_id != noone) {
				with (temp_id) {
					// checks how much it can move up
					for (new_row = other.row - 128; new_row >= 384; new_row -= 128) {
						var id_of_collision = instance_place(other.col, new_row, obj_tile);
						collide = false;
						// checks collision
						if (id_of_collision != noone) {
							// if same block and none new, then combine
							if (num = id_of_collision.num and !temp_id.just_created and !id_of_collision.just_created) {
								var inst = instance_create_layer(id_of_collision.x, id_of_collision.y, "Tiles", obj_tile);
								inst.num = id_of_collision.num * 2;
								other.total_score += id_of_collision.num * 2;
								instance_destroy(id_of_collision.id);
								instance_destroy();
							}
							// if not same block, don't move
							else {
								collide = true;
								break;
							}
						}
						// move up if no block above
						if (!collide) {
							y = new_row;
							other.board_change = true;
						}
					}
				}
			}
		}
	}
}

if (key_down) {
	// checks row (y)
	for (row = 640; row >= 384; row -= 128) {
		// checks column (x)
		for (col = 128; col <= 512; col += 128) {
			var temp_id = instance_place(col, row, obj_tile)
			if (temp_id != noone) {
				with (temp_id) {
					// checks if it can move down
					for (new_row = other.row + 128; new_row <= 768; new_row += 128) {
						var id_of_collision = instance_place(other.col, new_row, obj_tile);
						collide = false;
						// checks collision
						if (id_of_collision != noone) {
							// if same block, then combine
							if (num = id_of_collision.num and !temp_id.just_created and !id_of_collision.just_created) {
								var inst = instance_create_layer(id_of_collision.x, id_of_collision.y, "Tiles", obj_tile);
								inst.num = id_of_collision.num * 2;
								other.total_score += id_of_collision.num * 2;
								instance_destroy(id_of_collision.id);
								instance_destroy();
							}
							// if not same block, don't move
							else {
								collide = true;
								break;
							}
						}
						// move up if no block above
						if (!collide) {
							y = new_row;
							other.board_change = true;
						}
					}
				}
			}
		}
	}
}

if (key_left) {
	// checks column (x)
	for (col = 256; col <= 512; col += 128) {
		// checks row (y)
		for (row = 384; row <= 768; row += 128) {
			var temp_id = instance_place(col, row, obj_tile)
			if (temp_id != noone) {
				with (temp_id) {
					// checks how much it can move left
					for (new_col = other.col - 128; new_col >= 128; new_col -= 128) {
						var id_of_collision = instance_place(new_col, other.row, obj_tile);
						collide = false;
						// checks collision
						if (id_of_collision != noone) {
							// if same block, then combine
							if (num = id_of_collision.num and !temp_id.just_created and !id_of_collision.just_created) {
								var inst = instance_create_layer(id_of_collision.x, id_of_collision.y, "Tiles", obj_tile);
								inst.num = id_of_collision.num * 2;
								other.total_score += id_of_collision.num * 2;
								instance_destroy(id_of_collision.id);
								instance_destroy();
							}
							// if not same block, don't move
							else {
								collide = true;
								break;
							}
						}
						// move up if no block above
						if (!collide) {
							x = new_col;
							other.board_change = true;
						}
					}
				}
			}
		}
	}
}

if (key_right) {
	// checks column (x)
	for (col = 384; col >= 128; col -= 128) {
		// checks row (y)
		for (row = 384; row <= 768; row += 128) {
			var temp_id = instance_place(col, row, obj_tile)
			if (temp_id != noone) {
				with (temp_id) {
					// checks how much it can move right
					for (new_col = other.col + 128; new_col <= 512; new_col += 128) {
						var id_of_collision = instance_place(new_col, other.row, obj_tile);
						collide = false;
						// checks collision
						if (id_of_collision != noone) {
							// if same block, then combine
							if (num = id_of_collision.num and !temp_id.just_created and !id_of_collision.just_created) {
								var inst = instance_create_layer(id_of_collision.x, id_of_collision.y, "Tiles", obj_tile);
								inst.num = id_of_collision.num * 2;
								other.total_score += id_of_collision.num * 2;
								instance_destroy(id_of_collision.id);
								instance_destroy();
							}
							// if not same block, don't move
							else {
								collide = true;
								break;
							}
						}
						// move up if no block above
						if (!collide) {
							x = new_col;
							other.board_change = true;
						}
					}
				}
			}
		}
	}
}

// spawns in a 2 or 4 after player move
if ((key_up || key_down || key_left || key_right) and board_change) {
	audio_stop_sound(sound_move);
	audio_play_sound(sound_move, 1, false);
	var spawn_x;
	var spawn_y;
	empty_tiles = [];
	
	// finds all empty tiles
	for (row = 384; row <= 768; row += 128) {
		for (col = 128; col <= 512; col += 128) {
			id_of_empty = instance_place(col, row, obj_tile);
			// if nothing is there, add to array
			if (id_of_empty == noone) {
				array_push(empty_tiles, [col, row]);
			}
		}
	}
	
	// if empty tiles, select random one to spawn
	if (array_length(empty_tiles) > 0) {
		random_spawn = irandom_range(0, array_length(empty_tiles) - 1);
		spawn_x = empty_tiles[random_spawn][0];
		spawn_y = empty_tiles[random_spawn][1];
		var new_tile_id = instance_create_layer(spawn_x, spawn_y, "Tiles", obj_tile);
		prob = irandom_range(1, 4);
		if (prob == 4) {
			new_tile_id.num = 4;
		}
		array_delete(empty_tiles, random_spawn, 1);
	}
	
	// if no empty tiles, see if player has lost
	if (array_length(empty_tiles) == 0) {
		var lost = true;
		
		// check if above tiles are the same
		for (row = 512; row <= 768; row += 128) {
			for (col = 128; col <= 512; col += 128) {
				var temp_tile_id = instance_place(col, row, obj_tile);
				var temp_above_tile_id = instance_place(col, row - 128, obj_tile);
				if (temp_tile_id.num == temp_above_tile_id.num) {
					lost = false;
					break;
				}
			}
		}
		
		// check if below tiles are the same
		if (lost) {
			for (row = 640; row >= 384; row -= 128) {
				for (col = 128; col <= 512; col += 128) {
					var temp_tile_id = instance_place(col, row, obj_tile);
					var temp_below_tile_id = instance_place(col, row + 128, obj_tile);
					if (temp_tile_id.num == temp_below_tile_id.num) {
						lost = false;
						break;
					}
				}
			}
		}
		
		// check if left tiles are the same
		if (lost) {
			for (col = 256; col <= 512; col += 128) {
				for (row = 384; row <= 768; row += 128) {
					var temp_tile_id = instance_place(col, row, obj_tile);
					var temp_left_tile_id = instance_place(col - 128, row, obj_tile);
					if (temp_tile_id.num == temp_left_tile_id.num) {
						lost = false;
						break;
					}
				}
			}
		}
		
		// check if right tiles are the same
		if (lost) {
			for (col = 384; col >= 128; col -= 128) {
				for (row = 384; row <= 768; row += 128) {
					var temp_tile_id = instance_place(col, row, obj_tile);
					var temp_right_tile_id = instance_place(col + 128, row, obj_tile);
					if (temp_tile_id.num == temp_right_tile_id.num) {
						lost = false;
						break;
					}
				}
			}
		}
		
		// if lose
		if (lost) {
			room = defeat_screen;
			audio_stop_all();
			audio_play_sound(sound_amongus, 1, 1);
		}
	}
}