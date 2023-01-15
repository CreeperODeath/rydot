extends KinematicBody2D

onready var player = get_node("/root/World/Player")
onready var sprite = $AnimatedSprite
onready var world = get_node("/root/World")
onready var BombInstance = preload("res://assets/Enemys/BoomBot Explosion.tscn")
var speed = 130
var health = 5
var boom = false
var dir = Vector2()
var chase = false
var velocity = Vector2()



func _on_hit_body_entered(body):
	if body.is_in_group("damage_enemy"):
		health -= 1

func _on_vision_body_entered(body):
	if body == (player):
		chase = true
		sprite.set_animation("run")

func _on_vision_body_exited(body):
	if body == (player):
		if boom == false:
			chase = false
			sprite.set_animation("idle")
			dir = Vector2(0,0)
		

func _on_AnimatedSprite_animation_finished():
	if sprite.animation == "boom":
		var bomb = BombInstance.instance()
		bomb.position = self.position
		get_parent().add_child(bomb)
		CoinSingleton.boom_bot_coin()
		queue_free()

func _on_explode_radius_body_entered(body):
	if body == (player):
		boom = true
		sprite.set_animation("boom")

	
func _ready():
	pass

func _process(_delta):
	if health <= 0:
		CoinSingleton.boom_bot_coin()
		if is_instance_valid(world):
			world.time += CoinSingleton.extra_time
		queue_free()
	if boom == false:
		if chase == true:
			dir = (player.global_position - global_position).normalized()
			velocity = speed*dir
			velocity = move_and_slide(velocity)
			if dir.x < 0:
				sprite.set_flip_h(true)
			else:
				sprite.set_flip_h(false)
	else:
		dir = Vector2(0,0)
		velocity = speed*dir
		velocity = move_and_slide(velocity)
