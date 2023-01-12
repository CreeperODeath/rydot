extends TileMap


var doors_closed = false
var player_entered = false
onready var bottom_door_node = $room_connectors/bottom





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
	
	
	update_dirty_quadrants()









func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		var player_pos = body.get_global_position()
		if player_pos.y >= bottom_door_node.global_position.y:
			body.set_position(Vector2(player_pos.x, player_pos.y - 9))
		close_doors()
