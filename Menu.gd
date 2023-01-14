extends Control


func _on_StartButton_pressed():
	get_tree().change_scene("res://World.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _ready():
	$ButtonContainer/StartButton.grab_focus()

#func _process(delta):
#	pass
