extends RichTextLabel


onready var x = get_parent()

onready var text_debug 
	
func _process(_delta):
	if visible != true:
		set_process(false)
	text_debug = "room_id: " + str(x.room_id) +"\n" \
		+ "detected_possible_collision: " + str(x.detcted_possible_collision) +"\n"\
		+"collision: " + str(x.collision) +"\n"\
		+"left_spawned: " + str(x.left_spawned) +"\n"\
		+"left_opening_fix: " + str(x.left_opening_fix) +"\n"\
		+"left_opening_closed: " + str(x.left_opening_closed) + "\n"\
		+"right_spawned: " + str(x.right_spawned) +"\n"\
		+"right_opening: " + str(x.right_spawned) +"\n"\
		+"right_opening_fix: " + str(x.right_opening_fix) +"\n"\
		+"right_opening_closed: " + str(x.right_opening_closed) +"\n"\
		+"top_spawned: " + str(x.top_spawned) +"\n"\
		+"top_opening: " + str(x.top_spawned) +"\n"\
		+"top_opening_fix: " + str(x.top_opening_fix) +"\n"\
		+"top_opening_closed: " + str(x.top_opening_closed) +"\n"\
		+"bottom_spawned " + str(x.bottom_spawned) +"\n"\
		+"bottom_opening: " + str(x.bottom_spawned) +"\n"\
		+"bottom_opening_fix: " + str(x.bottom_opening_fix) +"\n"\
		+"bottom_opening_closed: " + str(x.bottom_opening_closed) +"\n"\
		+ "left_opening: " + str(x.left_opening) +"\n"\
		+ "right_opening: " + str(x.right_opening) +"\n"\
		+ "top_opening: " + str(x.top_opening) +"\n"\
		+ "bottom_opening:  " + str(x.bottom_opening) +"\n"\
		+ "all_rooms_spawned:  " + str(x.all_rooms_spawned) +"\n"\
		+ "spawn_active:  " + str(x.spawn_active) +"\n"\
		+ "local_spawn_active:  " + str(x.local_spawn_active) +"\n"\
		+ "left_room_detected:  " + str(x.left_room_detected) +"\n"\
		+ "right_room_detected:  " + str(x.right_room_detected) +"\n"\
		+ "top_room_detected:  " + str(x.top_room_detected) +"\n"\
		+ "bottom_room_detected:  " + str(x.bottom_room_detected) +"\n"\
		+ "spawned_self: " + str(x.spawned_self) +"\n"
	set_text(text_debug)
	
