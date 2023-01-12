extends TileMap


var doors_closed = false
var player_entered = false
onready var bottom_door_node = $room_connectors/bottom
onready var left_node = $room_connectors/left
onready var right_node = $room_connectors/right





func close_doors():
	doors_closed = true
	#bottom
	set_cell(15,17,13)
	set_cell(16,17,13)
	set_cell(17,17,13)
	#left
	set_cell(1,8,7)
	set_cell(1,9,7)
	set_cell(1,10,7)
	#right
	set_cell(31,8,9)
	set_cell(31,9,9)
	set_cell(31,10,9)
	
	
	
	update_dirty_quadrants()









func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		var player_pos = body.get_global_position()
		if player_pos.y >= bottom_door_node.global_position.y:
			body.set_global_position(Vector2(player_pos.x, player_pos.y - 9))
		elif player_pos.x < left_node.global_position.x:
			body.set_global_position(Vector2(left_node.global_position.x + 6, player_pos.y))
		elif player_pos.x >= right_node.global_position.x:
			body.set_global_position(Vector2(right_node.global_position.x - 5, player_pos.y))
		close_doors()
