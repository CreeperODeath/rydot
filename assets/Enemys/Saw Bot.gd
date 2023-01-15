extends KinematicBody2D

onready var player = get_node("/root/World/Player")
onready var sprite = $AnimatedSprite
onready var LSparks = $Left_Sparks
onready var RSparks = $Right_Sparks
onready var DeathSound = preload("res://assets/Audio/EnemyDeathSound.tscn")
onready var world = get_node("/root/World")
var speed = 80
var health = 5
var dir = Vector2()
var chase = false
var velocity = Vector2()



func _on_hit_body_entered(body):
	if body.is_in_group("damage_enemy"):
		health -= (1 + CoinSingleton.extra_bullet_damage)

func _on_Vision_body_entered(body):
	if body == (player):
		chase = true
		sprite.set_animation("Moving")

func _on_Vision_body_exited(body):
	if body == (player):
		chase = false
		sprite.set_animation("Idle")
		dir = Vector2(0,0)
	
func _ready():
	pass

func _process(_delta):
	if health <= 0:
		CoinSingleton.saw_bot_coin()
		if is_instance_valid(world):
			world.time += CoinSingleton.extra_time
		var Death = DeathSound.instance()
		get_parent().add_child(Death)
		queue_free()
		
	if chase == true:
		dir = (player.global_position - global_position).normalized()
		velocity = speed*dir
		velocity = move_and_slide(velocity)
		if dir.x < 0:
			sprite.set_flip_h(true)
			LSparks.visible = false
			RSparks.visible = true
		else:
			sprite.set_flip_h(false)
			LSparks.visible = true
			RSparks.visible = false
