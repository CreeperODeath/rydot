extends Node2D

onready var room_var = get_node("/root/World/room_variables")

onready var rng = RandomNumberGenerator.new()

onready var timer = $Timer

var debug = false
var detcted_possible_collision = false
var collision = false

var room_colided

var room_reset = 0

#---area 2D--------
onready var left_detector = $left_room_detector
onready var right_detector = $right_room_detector
onready var top_detector = $top_room_detector
onready var bottom_detector = $bottom_room_detector
onready var self_detector = $room_indicator

#-----------room placeholder-----------
onready var room_placeholder = load("res://maps/Rooms/room_placeholder.tscn")
onready var room_self 


#----------left room var----------
#onready var left_room = load(room_var.get_room("left", room_id))
onready var left_room_id = "n/a"
onready var left_node = $room_connectors/left
var left_spawned = false
var left_opening_fix = false
var left_opening_closed = false


#---------right room var-----------
#onready var right_room = load(room_var.get_room("right", room_id))
onready var right_room_id = "n/a"
onready var right_node = $room_connectors/right
var right_spawned = false
var right_opening_fix = false
var right_opening_closed = false

#---------top room var-----------
#onready var top_room = load(room_var.get_room("top", room_id))
onready var top_room_id = "n/a"
onready var top_node = $room_connectors/top
var top_spawned = false
var top_opening_fix = false
var top_opening_closed = false

#---------bottom room var-----------
#onready var bottom_room = load(room_var.get_room("bottom", room_id))
onready var bottom_room_id = "n/a"
onready var bottom_node = $room_connectors/bottom
var bottom_spawned = false
var bottom_opening_fix = false
var bottom_opening_closed = false


#-------individual room stats--------
export var room_id = "n/a"
export var left_opening = false
export var right_opening = false
export var top_opening = false
export var bottom_opening = false
var all_rooms_spawned = false
export var spawn_active = false
export var local_spawn_active = false
var self_inst


#---------Room colision variables----------\
onready var left_room_detected = false
onready var right_room_detected = false
onready var top_room_detected = false
onready var bottom_room_detected = false
export var spawned_self = false

func _ready():
	room_var.room_count += 1


func _physics_process(_delta):
	
	
	
	
	scan_collision()
	get_neighbors()
	room_error_fix()
	close_room_openings()
	if detcted_possible_collision == true:
		
		collision_check()
		
	
				
			
			
	if collision == true:
		delete_self()
	
	if room_id != "n/a":
		left_opening = room_var.room_sides_dic[room_id]["left"]
		right_opening = room_var.room_sides_dic[room_id]["right"]
		top_opening = room_var.room_sides_dic[room_id]["top"]
		bottom_opening = room_var.room_sides_dic[room_id]["bottom"]
		room_self = load(room_var.room_dic[room_id])
		spawn_active = true
		check_if_can_access()

		
		
		if spawned_self == false and local_spawn_active == true:
			if is_instance_valid(room_self):
				spawn_self()
			else:
				print("invalid inst")
		if all_rooms_spawned != true and spawn_active == true:
			room_spawn_check()
		else:
			if debug and spawn_active == true and room_id != "n/a":
				print(str(room_id) + " has finished generating")
				debug = false		
			#set_process(false)
		
			
		
			
#----------------spawn funtions----------
func room_spawn_check():
	if is_instance_valid(room_placeholder):
		if left_opening == true and left_room_detected == false:
			if left_spawned == false:
				spawn_room_left()
		if right_opening == true and right_room_detected == false:
			if right_spawned == false:
				spawn_room_right()
		if top_opening == true and top_room_detected == false:
			if top_spawned == false:
				spawn_room_top()
		if bottom_opening == true and bottom_room_detected == false:
			if bottom_spawned == false:
				spawn_room_bottom()
	if top_opening == top_spawned and bottom_opening == bottom_spawned and left_opening == left_spawned and right_opening == right_spawned:
		all_rooms_spawned = true

func spawn_room_left():
	
	var room_source = room_var.get_random_room_id("left")
	var room_instence = room_placeholder.instance()
	get_parent().add_child(room_instence)
	room_instence.global_position.x = left_node.global_position.x - 526
	room_instence.global_position.y = global_position.y
	room_instence.room_id = room_source
	left_spawned = true
	
func spawn_room_right():
	var room_source = room_var.get_random_room_id("right")
	var room_instence = room_placeholder.instance()
	get_parent().add_child(room_instence)
	room_instence.global_position.x = right_node.global_position.x - 9
	room_instence.global_position.y = global_position.y
	room_instence.room_id = room_source
	right_spawned = true
	
func spawn_room_top():
	var room_source = room_var.get_random_room_id("top")
	var room_instence = room_placeholder.instance()
	get_parent().add_child(room_instence)
	room_instence.global_position.y = top_node.global_position.y - 297
	room_instence.global_position.x = global_position.x
	room_instence.room_id = room_source
	top_spawned = true
	
func spawn_room_bottom():
	var room_source = room_var.get_random_room_id("bottom")
	var room_instence = room_placeholder.instance()
	get_parent().add_child(room_instence)
	room_instence.global_position.y = bottom_node.global_position.y + 8
	room_instence.global_position.x = global_position.x
	room_instence.room_id = room_source
	bottom_spawned = true
	
func spawn_self():
	var room_instence = room_self.instance()
	get_parent().add_child(room_instence)
	self_inst = room_instence
	room_instence.global_position.y = global_position.y 
	room_instence.global_position.x = global_position.x
	spawned_self = true





#----------Room collision detection----------
func _on_top_room_detector_area_entered(area):
	if area.is_in_group("room"):
		top_room_id = area.get_parent().room_id
		top_room_detected = true
		top_opening = false
		if debug:
			print ("detected room top")
	elif area.is_in_group("player"):
		local_spawn_active = true


func _on_right_room_detector_area_entered(area):
	if area.is_in_group("room"):
		right_room_id = area.get_parent().room_id
	
		
		right_room_detected = true
		right_opening = false
		if debug:
			print ("detected room right")
	elif area.is_in_group("player"):
		local_spawn_active = true


func _on_left_room_detector_area_entered(area):
	if area.is_in_group("room"):
		left_room_id = area.get_parent().room_id
		left_room_detected = true
		left_opening = false
		if debug:
			print ("detected room left")
	elif area.is_in_group("player"):
		local_spawn_active = true


func _on_bottom_room_detector_area_entered(area):
	if area.is_in_group("room"):
		bottom_room_id = area.get_parent().room_id
		bottom_room_detected = true
		bottom_opening = false
		if debug:
			print ("detected room bottom")
	elif area.is_in_group("player"):
		local_spawn_active = true
			
			
func _on_room_indicator_area_entered(area):
	if area.is_in_group("player"):
		local_spawn_active = true
	if area.is_in_group("room"):
		detcted_possible_collision = true
		room_colided = area.get_parent()
		if area.get_parent().collision == false:
			local_spawn_active = false
			collision = true
			room_var.room_count -= 1
			if debug:
				print("room collision")
		else:
			if debug:
				print ("collision resolved")
			else:
				pass


func _on_player_detector_area_entered(area):
	if area.is_in_group("player"):
		local_spawn_active = true
		
		
		
		
#----------closing openings---------
func close_room_openings():
	#patch left openings
	get_neighbors()
	if left_room_id != "n/a":
		if room_var.room_sides_dic[left_room_id]["right"] != true and left_opening_fix != true:
			if spawned_self == true:
				if left_opening_closed == true:
					room_reset()
				elif  room_var.room_sides_dic[room_id]["left"] != false:
					self_inst.set_cell(1,7,7)
					self_inst.set_cell(1,8,7)
					self_inst.set_cell(1,9,7)
					self_inst.set_cell(1,10,7)
					self_inst.set_cell(1,11,7)
					if debug == true:
						self_inst.set_cell(0,7,7)
						self_inst.set_cell(0,8,7)
						self_inst.set_cell(0,9,7)
						self_inst.set_cell(0,10,7)
						self_inst.set_cell(0,11,7)
						print("closed left opening " + room_id)
					else:
						self_inst.set_cell(0,7,-1)
						self_inst.set_cell(0,8,-1)
						self_inst.set_cell(0,9,-1)
						self_inst.set_cell(0,10,-1)
						self_inst.set_cell(0,11,-1)
					self_inst.update_dirty_quadrants()
					
					left_opening_fix = true
					left_opening_closed = true
	#patch right opening
	if right_room_id != "n/a":
		if room_var.room_sides_dic[right_room_id]["left"] != true and right_opening_fix != true:
			if spawned_self == true:
				if right_opening_closed == true:
					room_reset()
				elif  room_var.room_sides_dic[room_id]["right"] != false:
					self_inst.set_cell(31,7,9)
					self_inst.set_cell(31,8,9)
					self_inst.set_cell(31,9,9)
					self_inst.set_cell(31,10,9)
					self_inst.set_cell(31,11,9)
					if debug == true:
						self_inst.set_cell(32,7,9)
						self_inst.set_cell(32,8,9)
						self_inst.set_cell(32,9,9)
						self_inst.set_cell(32,10,9)
						self_inst.set_cell(32,11,9)
						print("closed right opening " + room_id)
					else:
						self_inst.set_cell(32,7,-1)
						self_inst.set_cell(32,8,-1)
						self_inst.set_cell(32,9,-1)
						self_inst.set_cell(32,10,-1)
						self_inst.set_cell(32,11,-1)
					self_inst.update_dirty_quadrants()
					
					right_opening_fix = true
					right_opening_closed = true
		#patch bottom opening
	if bottom_room_id != "n/a":
		if room_var.room_sides_dic[bottom_room_id]["top"] != true and bottom_opening_fix != true:
			if spawned_self == true:
				if bottom_opening_closed == true:
					room_reset()
				elif  room_var.room_sides_dic[room_id]["bottom"] != false:
					self_inst.set_cell(14,17,13)
					self_inst.set_cell(15,17,13)
					self_inst.set_cell(16,17,13)
					self_inst.set_cell(17,17,13)
					self_inst.set_cell(18,17,13)
					if debug == true:
						self_inst.set_cell(14,18,13)
						self_inst.set_cell(15,18,13)
						self_inst.set_cell(16,18,13)
						self_inst.set_cell(17,18,13)
						self_inst.set_cell(18,18,13)
						print("closed bottom opening " + room_id)
					else:
						self_inst.set_cell(14,18,-1)
						self_inst.set_cell(15,18,-1)
						self_inst.set_cell(16,18,-1)
						self_inst.set_cell(17,18,-1)
						self_inst.set_cell(18,18,-1)

					self_inst.update_dirty_quadrants()
					bottom_opening_fix = true
					bottom_opening_closed = true
	#top_room_patch
	if top_room_id != "n/a":
		if room_var.room_sides_dic[top_room_id]["bottom"] != true and top_opening_fix != true:
			if spawned_self == true:
				if top_opening_closed == true:
					room_reset()
				elif  room_var.room_sides_dic[room_id]["top"] != false:
					self_inst.set_cell(14,1,13)
					self_inst.set_cell(15,1,13)
					self_inst.set_cell(16,1,13)
					self_inst.set_cell(17,1,13)
					self_inst.set_cell(18,1,13)
					if debug == true:
						self_inst.set_cell(14,0,13)
						self_inst.set_cell(15,0,13)
						self_inst.set_cell(16,0,13)
						self_inst.set_cell(17,0,13)
						self_inst.set_cell(18,0,13)
						print("closed top opening " + room_id)
					else:
						self_inst.set_cell(14,0,-1)
						self_inst.set_cell(15,0,-1)
						self_inst.set_cell(16,0,-1)
						self_inst.set_cell(17,0,-1)
						self_inst.set_cell(18,0,-1)
					self_inst.update_dirty_quadrants()
					
					top_opening_fix = true
					top_opening_closed = true

func get_neighbors():
	var left_areas = left_detector.get_overlapping_areas()
	for area in left_areas:
		if area.is_in_group("room"):
			if left_room_id != area.get_parent().room_id:
				left_room_id = area.get_parent().room_id
				left_opening_fix = false
				print(left_room_id)
			
			
	var right_areas = right_detector.get_overlapping_areas()
	for area in right_areas:
		if area.is_in_group("room"):
			if right_room_id != area.get_parent().room_id:
				right_room_id = area.get_parent().room_id
				right_opening_fix = false
				#print(right_room_id)
				
	var top_areas = top_detector.get_overlapping_areas()
	for area in top_areas:
		if area.is_in_group("room"):
			if top_room_id != area.get_parent().room_id:
				top_room_id = area.get_parent().room_id
				top_opening_fix = false
				#print(top_room_id)
				
	var bottom_areas = bottom_detector.get_overlapping_areas()
	for area in bottom_areas:
		if area.is_in_group("room"):
			if bottom_room_id != area.get_parent().room_id:
				bottom_room_id = area.get_parent().room_id
				bottom_opening_fix = false
				#print(bottom_room_id)
			
func _on_Timer_timeout():
	if is_instance_valid(room_colided):
		print("collison")
		delete_self()
func scan_collision():
	var self_areas = self_detector.get_overlapping_areas()
	for area in self_areas:
		if area.is_in_group("room"):
			detcted_possible_collision = true
			room_colided = area.get_parent()
			collision_check()
			print("detected self")
			

func collision_check():
	
	if is_instance_valid(room_colided):
		if room_colided.collision == false:
			collision = true
		else:
			rng.randomize()
			timer.set_wait_time(rng.randf_range(.0001,.01))

func check_if_can_access():
	var left_open
	var right_open
	var top_open
	var bottom_open
	if room_var.room_sides_dic[room_id]["left"] != true:
		left_open = false
	
	elif left_opening == false or left_opening_closed == true:
		left_open = false
	else:
		left_open = true

	if room_var.room_sides_dic[room_id]["right"] != true:
		right_open = false
	
	elif right_opening == false or right_opening_closed == true:
		right_open = false
	else:
		right_open = true

	if room_var.room_sides_dic[room_id]["top"] != true:
		top_open = false
	
	elif top_opening == false or top_opening_closed == true:
		top_open = false
	else:
		top_open = true

	if room_var.room_sides_dic[room_id]["bottom"] != true:
		bottom_open = false
	
	elif bottom_opening == false or bottom_opening_closed == true:
		bottom_open = false
	else:
		bottom_open = true

	if left_open == false and right_open == false and top_open == false and bottom_open == false:
		print("in accsessible")
		delete_self()

	
func delete_self():
	if debug:
		print("deleteing self")
	room_var.room_count -= 1
	if spawned_self == true:
		self_inst.queue_free()
	queue_free()

func room_reset():
	left_opening_fix = false
	left_opening_closed = false
	right_opening_fix = false
	right_opening_closed = false
	top_opening_fix = false
	top_opening_closed = false
	bottom_opening_fix = false
	bottom_opening_closed = false

	left_room_id = "n/a"
	right_room_id = "n/a"
	top_room_id = "n/a"
	bottom_room_id = "n/a"



	print("room_reset" + str(room_reset))
	self_inst.queue_free()
	spawned_self = false
	room_reset += 1
	spawn_self()	

func room_error_fix():
	if spawned_self == true:
		if left_opening_fix == false and left_opening_closed == true:
			
			room_reset()
		if right_opening_fix == false and right_opening_closed == true:
			
			room_reset()
		if top_opening_fix == false and top_opening_closed == true:
			
			room_reset()
		if bottom_opening_fix == false and bottom_opening_closed == true:
			
			room_reset()

