extends KinematicBody2D

export var move_speed = 300.0
onready var BulletInstance = preload("res://Bullet.tscn")
onready var player_sprite = $AnimatedSprite
var velocity = Vector2()
var x_dir = 0
var y_dir = 0

var facing_left = true

func _ready():
	pass

func check_win():
	pass


func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("E"):
		var Bullet = BulletInstance.instance()
		Bullet.direction = Vector2(x_dir, y_dir)
		get_parent().add_child(Bullet)

func _physics_process(_delta):
	x_dir = 0
	y_dir = 0
	if Input.is_action_pressed("move_left"):
		x_dir -= 1
		facing_left = true
	if Input.is_action_pressed("move_right"):
		x_dir += 1
		facing_left = false
	if Input.is_action_pressed("move_up"):
		y_dir -= 1
	if Input.is_action_pressed("move_down"):
		y_dir += 1
	if facing_left == true:
		player_sprite.set_flip_h(false)
	else:
		player_sprite.set_flip_h(true)
	
		




	velocity.x = x_dir * move_speed
	velocity.y = y_dir * move_speed
	velocity = move_and_slide(velocity, velocity)
