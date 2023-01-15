extends Node2D

func _on_BuyZone_body_entered(body):
	if body == get_node("Player"):
		get_tree().change_scene("res://Shop_Menu.tscn")

func _on_PortalZone_body_entered(body):
	if body == get_node("Player"):
		get_tree().change_scene("res://World.tscn")

func _ready():
	pass
