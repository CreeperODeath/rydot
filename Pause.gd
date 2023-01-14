extends Control


func _input(event):
	if event.is_action_pressed("exit"):
		var pause_state = not get_tree().paused
		get_tree().paused = pause_state
		visible = pause_state


func _on_Continue_pressed():
	var pause_state = not get_tree().paused
	get_tree().paused = pause_state
	visible = pause_state


func _on_Main_Menu_pressed():
	var pause_state = not get_tree().paused
	get_tree().paused = pause_state
	visible = pause_state
	get_tree().change_scene("res://Menu.tscn")
