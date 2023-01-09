extends TileMap

onready var room_var = room_variables.new()

onready var left_room = load(room_var.top_rooms[0])
onready var left_node = $room_connectors/left
var left_spawned = false
export var room_id = "start_room"

func _physics_process(delta):
	if left_spawned == false:
		if is_instance_valid(left_room):
			spawn_room_left()


func spawn_room_left():
	var room_instence = left_room.instance()
	get_parent().add_child(room_instence)
	room_instence.position.x = left_node.position.x - 526
	left_spawned = true
