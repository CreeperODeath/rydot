extends KinematicBody2D

onready var player = get_node("/root/World/Player")
onready var sprite = $AnimatedSprite
onready var time = $AttackTimer
onready var world = get_node("/root/World")
onready var AttackInstance = preload("res://assets/Enemys/Ball_Lightning.tscn")
var speed = 40
var health = 5
var dir = Vector2()
var chase = false
var stop = false
var velocity = Vector2()



func _on_hit_body_entered(body):
	if body.is_in_group("damage_enemy"):
		health -= 1

func _on_vision_body_entered(body):
	if body == (player):
		chase = true
		sprite.set_animation("Idle")

func _on_vision_body_exited(body):
	if body == (player):
		chase = false
		sprite.set_animation("Idle")
		dir = Vector2(0,0)
		
func _on_Minimum_Range_body_entered(body):
	if body == (player):
		stop = true
		sprite.set_animation("Attack")
		dir = Vector2(0,0)


func _on_Minimum_Range_body_exited(body):
	if body == (player):
		stop = false
		sprite.set_animation("Idle")
	
func _ready():
	pass

func _process(_delta):
	if health <= 0:
		CoinSingleton.halogen_jelly_coin()
		if is_instance_valid(world):
			world.time += CoinSingleton.extra_time
		queue_free()
	if stop == false:
		if chase == true:
			dir = (player.global_position - global_position).normalized()
			velocity = speed*dir
			velocity = move_and_slide(velocity)
			if dir.x < 0:
				sprite.set_flip_h(true)
			else:
				sprite.set_flip_h(false)
	elif stop == true:
		if time.is_stopped():
			time.start()
			var Ball_Lightning = AttackInstance.instance()
			Ball_Lightning.position = self.position
			Ball_Lightning.direction = (player.global_position - global_position).normalized()
			get_parent().add_child(Ball_Lightning)

