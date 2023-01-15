extends Node

export var coins = 0
export var extra_coins = 0
export var extra_time = 0
export var extra_bullet_speed = 0
export var extra_bullet_damage = 0
export var extra_bullet_size = 0
export var extra_attack_speed = 0
export var extra_speed = 0
export var less_damage = 0

func _ready():
	pass

func saw_bot_coin():
	coins += (10 + extra_coins)

func boom_bot_coin():
	coins += (15 + extra_coins)

func halogen_jelly_coin():
	coins += (20 + extra_coins)

func laser_drone_coin():
	coins += (25 + extra_coins)

func extra_coins_upgrade():
	extra_coins += 1

func extra_time_upgrade():
	extra_time += 1

func extra_bullet_speed_upgrade():
	extra_bullet_speed += 1

func extra_bullet_damage_upgrade():
	extra_bullet_damage += 1

func extra_bullet_size_upgrade():
	extra_bullet_size += 1

func extra_attack_speed_upgrade():
	extra_attack_speed += 1

func extra_speed_upgrade():
	extra_speed += 1

func less_damage_upgrade():
	less_damage += 1
