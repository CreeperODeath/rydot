extends RichTextLabel

var coins
onready var world = get_node("/root/World")

func _process(delta):
	if is_instance_valid(world):
		coins = world.coins
	if coins != null:
		set_text("Coins: " + str(coins))
