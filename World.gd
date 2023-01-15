extends Node2D

onready var player = $Player
onready var loading_screen = $CanvasLayer2


export var time = (60 + CoinSingleton.extra_start_time)

func _on_Timer_timeout():
	time -= 1
	if time <= 0:
		$PlayerDeath.play()

func _on_PlayerDeath_finished():
	get_tree().change_scene("res://Shop.tscn")

func _ready():
	if is_instance_valid(player):
		if player.debug == true:
			time = 999999999999
