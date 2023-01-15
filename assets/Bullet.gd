extends KinematicBody2D

var direction = Vector2()
var speed = 100.0
var velocity = Vector2()
var pierce = 0

func _ready():
	pass 

func _process(_delta):
	velocity.x = direction.x * (speed + CoinSingleton.extra_bullet_speed)
	velocity.y = direction.y * (speed + CoinSingleton.extra_bullet_speed)
	velocity = move_and_slide(velocity, velocity)




func _on_Area2D_body_entered(body):
	#----Bulet die when hit wall--------
	if body.is_in_group("map"):
		queue_free()
