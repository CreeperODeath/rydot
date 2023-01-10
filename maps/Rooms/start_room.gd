extends TileMap

onready var room_var = room_variables.new()



#----------left room var----------
onready var left_room = load(room_var.top_rooms[0])
onready var left_node = $room_connectors/left
var left_spawned = false


#---------right room var-----------
onready var right_room = load(room_var.top_rooms[0])
onready var right_node = $room_connectors/right
var right_spawned = false

export var room_id = ""

func _physics_process(delta):
	if left_spawned == false:
		if is_instance_valid(left_room):
			spawn_room_left()
	if right_spawned == false:
		if is_instance_valid(right_room):
			spawn_room_right()

func spawn_room_left():
	var room_instence = left_room.instance()
	get_parent().add_child(room_instence)
	room_instence.position.x = left_node.position.x - 526
	room_instence.position.y = position.y
	left_spawned = true
	
func spawn_room_right():
	var room_instence = right_room.instance()
	get_parent().add_child(room_instence)
	room_instence.position.x = right_node.position.x - 9
	room_instence.position.y = position.y
	right_spawned = true
