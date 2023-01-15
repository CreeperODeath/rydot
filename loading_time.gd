extends Timer




func _on_Timer_timeout():
	get_parent().set_global_position(Vector2(229,171))
	get_node("/root/World/CanvasLayer2").set_visible(false) 
