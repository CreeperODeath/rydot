extends KinematicBody2D

onready var slime_sprite = $AnimatedSprite
onready var player = get_parent().get_parent().get_node("Player")

onready var death_sound = $death_sound

export var health = 4
export var vision = []

var follow = false
export var movment_up_down = true
export var movment_flip = false
var velocity = Vector2()
export var speed = .5
var distance_to_player

func _process(delta):
	if health <= 0:
		if death_sound.playing == false:
			death_sound.play()



func _physics_process(delta):
	

	movement()
	
		

func movement():
	if follow == false:
		if movment_up_down == false && movment_flip == false:
			velocity.x = -speed
		elif movment_up_down == false && movment_flip == true:
			velocity.x = speed
		else:
			velocity.x = 0
			
			
		if movment_up_down == true && movment_flip == false:
			velocity.y = -speed
		elif movment_up_down == true && movment_flip == true:
			velocity.y = speed
		else:
			velocity.x = 0
			
		var collision = move_and_collide(velocity)
		
		if collision:
			if movment_flip == false:
				movment_flip = true
				slime_sprite.flip_h = true
			else:
				movment_flip = false
				slime_sprite.flip_h = false
			
	elif follow == true:
		if not player:
			return
		var dir = (player.global_position - global_position).normalized()
		move_and_collide(dir * speed)
			
		

		
	
	

func _on_vision_body_entered(body):
	if body.is_in_group("player"):
		follow = true


func _on_vision_body_exited(body):
	if body.is_in_group("player"):
		follow = false


func _on_AudioStreamPlayer_finished():
	queue_free()
