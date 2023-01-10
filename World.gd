extends Node2D

onready var MapInstance = preload("res://maps/test map.tscn")
onready var PlayerInstance = preload("res://Player.tscn")
onready var start_room = preload("res://maps/Rooms/start_room.tscn")
onready var left_node = $start_room/room_connectors/left


var time = 600

func _on_Timer_timeout():
	time -= 1


func _ready():
	var Player = PlayerInstance.instance()
	var Map = MapInstance.instance()


func _process(delta):
	pass

