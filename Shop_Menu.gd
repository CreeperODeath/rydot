extends Control


func _on_UpgradeButton1_pressed():
	print("Upgrade 1")
	CoinSingleton.extra_coins_upgrade()


func _on_UpgradeButton2_pressed():
	print("Upgrade 2")
	CoinSingleton.extra_time_upgrade()


func _on_ExitButton_pressed():
	get_tree().change_scene("res://Shop.tscn")

func _ready():
	$ButtonContainer/UpgradeButton1.grab_focus()
