extends KinematicBody2D

export var debug = false
export var move_speed = 0.0
export var max_speed = 200.0
onready var BulletInstance = preload("res://assets/Bullet.tscn")
onready var player_sprite = $AnimatedSprite
onready var WeaponTimer1 = $WeaponTimer1
onready var Invin = $Invincibility
onready var player_camera = $Camera2D
onready var world = get_node("/root/World")
onready var AttackSound = $AttackSound
onready var HitSound = $HitSound
var velocity = Vector2()
var facing_left = true
var firing = false
var x_dir = 0
var y_dir = 0

func _ready():
	print("player ready")
	WeaponTimer1.wait_time = (0.5 - CoinSingleton.extra_attack_speed)
	if debug:
		max_speed = 500
		get_node("CollisionShape2D").set_disabled(true)
		player_camera.set_zoom(Vector2(.5,.5))

func check_win():
	pass


func _process(_delta):
#-------------------Shooty code--------------------
	if Input.is_action_just_pressed("exit"):
		pass
	if Input.is_action_pressed("fire_right") or Input.is_action_pressed("fire_left") or Input.is_action_pressed("fire_up") or Input.is_action_pressed("fire_down"):
		firing = true
	else:
		firing = false
	if firing == true and WeaponTimer1.is_stopped():
		WeaponTimer1.start()
		AttackSound.play()
		var Bullet = BulletInstance.instance()
		if Input.is_action_pressed("fire_right"):
			Bullet.position = self.position
			Bullet.direction = Vector2(1, 0)
			Bullet.rotation_degrees = 90
			get_parent().add_child(Bullet)
		if Input.is_action_pressed("fire_left"):
			Bullet.position = self.position
			Bullet.direction = Vector2(-1, 0)
			Bullet.rotation_degrees = 270
			get_parent().add_child(Bullet)
		if Input.is_action_pressed("fire_up"):
			Bullet.position = self.position
			Bullet.direction = Vector2(0, -1)
			Bullet.rotation_degrees = 0
			get_parent().add_child(Bullet)
		if Input.is_action_pressed("fire_down"):
			Bullet.position = self.position
			Bullet.direction = Vector2(0, 1)
			Bullet.rotation_degrees = 180
			get_parent().add_child(Bullet)

func _physics_process(_delta):
	#----------------Movey Code-----------------
	if x_dir != 0:
		if x_dir > 0:
			x_dir -= 0.1
		if x_dir < 0:
			x_dir += 0.1
		if x_dir < 0.1 and x_dir > -0.1:
			x_dir = 0
	if Input.is_action_pressed("move_left"):
		x_dir = -1
		facing_left = true
	elif Input.is_action_pressed("move_right"):
		x_dir = 1
		facing_left = false
	if y_dir != 0:
		if y_dir > 0:
			y_dir -= 0.1
		if y_dir < 0:
			y_dir += 0.1
		if y_dir < 0.1 and y_dir > -0.1:
			y_dir = 0
	if Input.is_action_pressed("move_up"):
		y_dir = -1
	elif Input.is_action_pressed("move_down"):
		y_dir = 1
	if facing_left == true:
		player_sprite.set_flip_h(false)
	else:
		player_sprite.set_flip_h(true)
	
	if x_dir == 0 and y_dir == 0:
		player_sprite.set_animation("idle")
		if move_speed > 0:
			move_speed -= 100
		if move_speed < 0:
			move_speed = 0
	else:
		player_sprite.set_animation("run") 
		if move_speed < max_speed:
			if x_dir != 0 or y_dir != 0:
				move_speed += 20
		if move_speed > max_speed:
			move_speed = max_speed
	
	velocity.x =  x_dir * move_speed
	velocity.y =  y_dir * move_speed
	velocity = move_and_slide(velocity, velocity)


func _on_hit_body_entered(body):
	if Invin.is_stopped():
		if body.is_in_group("damage_player"):
			Invin.start()
			world.time -= (10 - CoinSingleton.less_damage)
			HitSound.play()


func _on_hit_area_entered(area):
	if Invin.is_stopped():
		if area.is_in_group("damage_player"):
			Invin.start()
			world.time -= (10 - CoinSingleton.less_damage)
			HitSound.play()
