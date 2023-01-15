extends Control


func _on_UpgradeButton1_pressed():
	if CoinSingleton.coins >= 100:
		print("Upgrade 1")
		CoinSingleton.extra_coins_upgrade()
		CoinSingleton.coins -= 100


func _on_UpgradeButton2_pressed():
	if CoinSingleton.coins >= 200:
		print("Upgrade 2")
		CoinSingleton.extra_time_upgrade()
		CoinSingleton.coins -= 200

func _on_UpgradeButton3_pressed():
	if CoinSingleton.coins >= 150:
		print("Upgrade 3")
		CoinSingleton.less_damage_upgrade()
		CoinSingleton.coins -= 100


func _on_UpgradeButton4_pressed():
	if CoinSingleton.coins >= 75:
		print("Upgrade 4")
		CoinSingleton.extra_bullet_speed_upgrade()
		CoinSingleton.coins -= 75


func _on_UpgradeButton5_pressed():
	if CoinSingleton.coins >= 500:
		print("Upgrade 5")
		CoinSingleton.extra_bullet_damage_upgrade()
		CoinSingleton.coins -= 500


func _on_UpgradeButton6_pressed():
	if CoinSingleton.coins >= 100:
		if CoinSingleton.extra_attack_speed < 0.49:
			print("Upgrade 6")
			CoinSingleton.extra_attack_speed_upgrade()
			CoinSingleton.coins -= 100

func _on_UpgradeButton7_pressed():
	if CoinSingleton.coins >= 50:
		print("Upgrade 7")
		CoinSingleton.extra_start_time_upgrade()
		CoinSingleton.coins -= 50

func _on_ExitButton_pressed():
	get_tree().change_scene("res://Shop.tscn")

func _ready():
	$ButtonContainer/UpgradeButton1.grab_focus()
