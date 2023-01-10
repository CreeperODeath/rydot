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

#---------top room var-----------
onready var top_room = load(room_var.top_rooms[0])
onready var top_node = $room_connectors/top
var top_spawned = false

#---------bottom room var-----------
onready var bottom_room = load(room_var.top_rooms[0])
onready var bottom_node = $room_connectors/bottom
var bottom_spawned = false



#-------individual room stats--------
export var room_id = ""
export var left_opening = false
export var right_opening = false
export var top_opening = false
export var bottom_opening = false

func _physics_process(delta):
	if top_spawned == false:
		if is_instance_valid(top_room):
			spawn_room_top()
	
			
func room_spawn_check():
	pass

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
	
func spawn_room_top():
	var room_instence = bottom_room.instance()
	get_parent().add_child(room_instence)
	room_instence.position.y = top_node.position.y - 297
	room_instence.position.x = position.x
	top_spawned = true
	
	
func spawn_room_bottom():
	var room_instence = bottom_room.instance()
	get_parent().add_child(room_instence)
	room_instence.position.y = bottom_node.position.y + 8
	room_instence.position.x = position.x
	bottom_spawned = true

