extends KinematicBody2D

onready var player = get_node("/root/World/Player")
onready var sprite = $AnimatedSprite
onready var time = $WeaponTimer
onready var world = get_node("/root/World")
onready var LaserInstance = preload("res://assets/Enemys/Drone Laser.tscn")
var speed = 50
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
		sprite.set_animation("Firing")

func _on_vision_body_exited(body):
	if body == (player):
		chase = false
		sprite.set_animation("Idle")
		dir = Vector2(0,0)
		
func _on_Minimum_Range_body_entered(body):
	if body == (player):
		stop = true
		sprite.set_animation("Firing")
		dir = Vector2(0,0)


func _on_Minimum_Range_body_exited(body):
	if body == (player):
		stop = false
		
func _on_Stop_Range_body_entered(body):
	pass # Replace with function body.


func _on_Stop_Range_body_exited(body):
	pass # Replace with function body.
	
func _on_AnimatedSprite_animation_finished():
	if sprite.animation == "Firing":
		var Laser = LaserInstance.instance()
		Laser.position = self.position
		Laser.position.y -= 2.4
		if player.global_position.x < self.global_position.x:
				Laser.direction = Vector2(-1, 0)
		elif player.global_position.x > self.global_position.x:
				Laser.direction = Vector2(1, 0)
		get_parent().add_child(Laser)

func _ready():
	pass

func _process(delta):
	if health <= 0:
		if is_instance_valid(world):
			world.coins
			if world.coins != null:
				world.coins += 25
		queue_free()
	if player.global_position.x < self.global_position.x:
		sprite.set_flip_h(true)
	else:
		sprite.set_flip_h(false)
	if chase == true:
		if player.global_position.y < self.global_position.y:
			dir.y = -1
		elif player.global_position.y > self.global_position.y:
			dir.y = 1
		else:
			dir.y = 0
		if stop == false:
			if player.global_position.x < self.global_position.x:
				dir.x = -1
			elif player.global_position.x > self.global_position.x:
				dir.x = 1
		else:
			if player.global_position.x < self.global_position.x:
				dir.x = 1
			elif player.global_position.x > self.global_position.x:
				dir.x = -1
		dir.y = dir.y * 2
		velocity = speed*dir
		velocity = move_and_slide(velocity)
