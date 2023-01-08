extends KinematicBody2D

var direction = Vector2(0.0,1.0)
var speed = 300.0


func _ready():
	pass 

func _process(delta):
  position = position + speed * direction * delta
