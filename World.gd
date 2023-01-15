extends Node2D




export var time = (60 + CoinSingleton.extra_start_time)

func _on_Timer_timeout():
	time -= 1
	if time <= 0:
		get_tree().change_scene("res://Shop.tscn")


func _ready():
	pass
