extends KinematicBody2D

export var move_speed = 300.0
var velocity = Vector2()

func _ready():
	pass

func check_win():
	pass


func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("E"):
		pass

func _physics_process(_delta):
	var x_dir = 0
	var y_dir = 0
	if Input.is_action_pressed("move_left"):
		x_dir -= 1
		#self.rotation_degrees = 270
	if Input.is_action_pressed("move_right"):
		x_dir += 1
		#self.rotation_degrees = 90
	if Input.is_action_pressed("move_up"):
		y_dir -= 1
		#self.rotation_degrees = 0
	if Input.is_action_pressed("move_down"):
		y_dir += 1
		#self.rotation_degrees = 180
#	if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_left"):
#		self.rotation_degrees = 315
#	if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_right"):
#		self.rotation_degrees = 45
#	if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_left"):
#		self.rotation_degrees = 225
#	if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_right"):
#		self.rotation_degrees = 135

	velocity.x = x_dir * move_speed
	velocity.y = y_dir * move_speed
	velocity = move_and_slide(velocity, velocity)
