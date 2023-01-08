extends Node2D

onready var MapInstance = preload("res://maps/test map.tscn")
onready var PlayerInstance = preload("res://Player.tscn")


var time = 600

func _on_Timer_timeout():
	time -= 1
	print(time)


func _ready():
	var Player = PlayerInstance.instance()
	var Map = MapInstance.instance()


func _process(delta):
	pass
