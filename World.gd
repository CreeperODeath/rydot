extends Node2D

onready var player = $Player


export var time = (60 + CoinSingleton.extra_start_time)

func _on_Timer_timeout():
	time -= 1
	if time <= 0:
		get_tree().change_scene("res://Shop.tscn")


func _ready():
	if is_instance_valid(player):
		if player.debug == true:
			time = 999999999999
