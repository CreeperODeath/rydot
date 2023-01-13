extends KinematicBody2D

onready var player = get_parent().get_node("Player")
onready var sprite = $AnimatedSprite
var speed = 80
var health = 5
var dir = Vector2()
var chase = false
var velocity = Vector2()



func _on_hit_body_entered(body):
	if body.is_in_group("damage_enemy"):
		health -= 1

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

func _process(delta):
	if health <= 0:
		queue_free()
	if chase == true:
		dir = (player.global_position - global_position).normalized()
		velocity = speed*dir
		velocity = move_and_slide(velocity)
		if dir.x < 0:
			sprite.set_flip_h(true)
		else:
			sprite.set_flip_h(false)