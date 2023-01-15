extends RichTextLabel

var coins
onready var world = get_node("/root/World")

func _process(_delta):
	if is_instance_valid(CoinSingleton):
		coins = CoinSingleton.coins
	if coins != null:
		set_text("Coins: " + str(coins))
