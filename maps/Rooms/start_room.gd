extends TileMap

onready var room_var = room_variables.new()

export var debug = true







#----------left room var----------
onready var left_room = load(room_var.get_room("left", room_id))
onready var left_node = $room_connectors/left
var left_spawned = false


#---------right room var-----------
onready var right_room = load(room_var.get_room("right", room_id))
onready var right_node = $room_connectors/right
var right_spawned = false

#---------top room var-----------
onready var top_room = load(room_var.get_room("top", room_id))
onready var top_node = $room_connectors/top
var top_spawned = false

#---------bottom room var-----------
onready var bottom_room = load(room_var.get_room("bottom", room_id))
onready var bottom_node = $room_connectors/bottom
var bottom_spawned = false



#-------individual room stats--------
export var room_id = ""
export var left_opening = false
export var right_opening = false
export var top_opening = false
export var bottom_opening = false
var all_rooms_spawned = false
export var spawn_active = false


#---------Room colision variables----------\
onready var left_room_detected = false
onready var right_room_detected = false
onready var top_room_detected = false
onready var bottom_room_detected = false


func _physics_process(delta):
	if all_rooms_spawned != true and spawn_active == true:
		
		room_spawn_check()
	else:
		
		if debug and spawn_active == true:
			print(str(room_id) + " has finished generating")
			debug = false		
		
			
func room_spawn_check():
	if left_opening == true and left_room_detected == false:
		if left_spawned == false:
			if is_instance_valid(left_room):
				spawn_room_left()
	if right_opening == true and right_room_detected == false:
		if right_spawned == false:
			if is_instance_valid(right_room):
				spawn_room_right()
	if top_opening == true and top_room_detected == false:
		if top_spawned == false:
			if is_instance_valid(top_room):
				spawn_room_top()
	if bottom_opening == true and bottom_room_detected == false:
		if bottom_spawned == false:
			if is_instance_valid(bottom_room):
				spawn_room_bottom()
	if top_opening == top_spawned and bottom_opening == bottom_spawned and left_opening == left_spawned and right_opening == right_spawned:
		all_rooms_spawned = true

func spawn_room_left():
	var room_instence = left_room.instance()
	get_parent().add_child(room_instence)
	room_instence.global_position.x = left_node.global_position.x - 526
	room_instence.position.y = position.y
	left_spawned = true
	print (room_id + " left room generation")
	
	
	
func spawn_room_right():
	var room_instence = right_room.instance()
	get_parent().add_child(room_instence)
	room_instence.global_position.x = right_node.global_position.x - 9
	room_instence.global_position.y = global_position.y
	right_spawned = true
	
func spawn_room_top():
	var room_instence = top_room.instance()
	get_parent().add_child(room_instence)
	room_instence.global_position.y = top_node.global_position.y - 297
	room_instence.global_position.x = global_position.x
	top_spawned = true
	
	
func spawn_room_bottom():
	var room_instence = bottom_room.instance()
	get_parent().add_child(room_instence)
	room_instence.global_position.y = bottom_node.global_position.y + 8
	room_instence.global_position.x = global_position.x
	bottom_spawned = true





#----------Room collision detection----------
func _on_top_room_detector_area_entered(area):
	if area.is_in_group("room"):
		top_room_detected = true
		top_opening = false
		if debug:
			print ("detected room top")
	else:
		top_room_detected = false


func _on_right_room_detector_area_entered(area):
	if area.is_in_group("room"):
		right_room_detected = true
		right_opening = false
		if debug:
			print ("detected room right")
	else:
		right_room_detected = false

func _on_left_room_detector_area_entered(area):
	if area.is_in_group("room"):
		left_room_detected = true
		left_opening = false
		if debug:
			print ("detected room left")
	else:
		left_room_detected = false


func _on_bottom_room_detector_area_entered(area):
	if area.is_in_group("room"):
		bottom_room_detected = true
		bottom_opening = false
		if debug:
			print ("detected room bottom")
	else:
		bottom_room_detected = false
