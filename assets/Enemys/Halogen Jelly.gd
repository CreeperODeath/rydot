extends KinematicBody2D

onready var halogen_sprite = $AnimatedSprite
onready var player = get_parent().get_parent().get_node("Player")

export var health = 4
export var vision = []
var can_move = true

var follow = false
export var movment_up_down = true
export var movment_flip = false
var velocity = Vector2()
export var speed = 10
var distance_to_player

func _process(delta):
	if health <= 0:
		queue_free()


func _physics_process(delta):
	
	if can_move:
		movement()
	
		

func movement():
	var collision
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
		
		if velocity > Vector2(0,0):
			halogen_sprite.set_animation("run")
		else:
			halogen_sprite.set_animation("idle")
		move_and_slide(velocity)
		
		if collision:
			if movment_flip == false:
				movment_flip = true
				halogen_sprite.flip_h = true
			else:
				movment_flip = false
				halogen_sprite.flip_h = false
			
	elif follow == true:
		if not player:
			return
		var dir = (player.global_position - global_position).normalized()
		collision = move_and_slide(dir * speed)
		
		
		
func _on_hit_body_entered(body):
	if body.is_in_group("damage_enemy"):
		health -= 1
		

func _on_vision_body_entered(body):
	if body.is_in_group("player"):
		follow = true


func _on_vision_body_exited(body):
	if body.is_in_group("player"):
		follow = false
