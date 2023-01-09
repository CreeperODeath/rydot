extends KinematicBody2D

export var move_speed = 300.0
onready var BulletInstance = preload("res://Bullet.tscn")
onready var player_sprite = $AnimatedSprite
var velocity = Vector2()

var facing_left = true

func _ready():
	pass

func check_win():
	pass


func _process(_delta):
#-------------------Shooty code--------------------
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("fire_right"):
		var Bullet = BulletInstance.instance()
		Bullet.position = self.position
		Bullet.direction = Vector2(1, 0)
		get_parent().add_child(Bullet)
	if Input.is_action_just_pressed("fire_left"):
		var Bullet = BulletInstance.instance()
		Bullet.position = self.position
		Bullet.direction = Vector2(-1, 0)
		get_parent().add_child(Bullet)
	if Input.is_action_just_pressed("fire_up"):
		var Bullet = BulletInstance.instance()
		Bullet.position = self.position
		Bullet.direction = Vector2(0, -1)
		get_parent().add_child(Bullet)
	if Input.is_action_just_pressed("fire_down"):
		var Bullet = BulletInstance.instance()
		Bullet.position = self.position
		Bullet.direction = Vector2(0, 1)
		get_parent().add_child(Bullet)

func _physics_process(_delta):
	#----------------Movey Code-----------------
	var x_dir = 0
	var y_dir = 0
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
	if velocity == Vector2(0,0):
		player_sprite.set_animation("idle") 
	else:
		player_sprite.set_animation("run") 
	velocity = move_and_slide(velocity, velocity)
