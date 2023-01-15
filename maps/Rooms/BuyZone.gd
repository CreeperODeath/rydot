extends Area2D

onready var ShopMenu = get_node("/root/Shop_Menu")

func _on_BuyZone_body_entered(body):
	print("BUY SOMETHING")
	ShopMenu. = false

func _ready():
	pass
