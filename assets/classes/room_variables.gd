extends Node

var rng = RandomNumberGenerator.new()

export var debug = false
export var room_count = 0
export var room_slowdown = 10


class_name room_variables
var basic_room = "res://maps/Rooms/room_template.tscn"
var left_opening = "res://maps/Rooms/left_opening.tscn"
var right_opening = "res://maps/Rooms/right_opening.tscn"
var top_opening = "res://maps/Rooms/top_opening.tscn"
var bottom_opening = "res://maps/Rooms/bottom_opening.tscn"
var t_room = "res://maps/Rooms/t_room.tscn"
var top_left = "res://maps/Rooms/top_left.tscn"
var right_bottom = "res://maps/Rooms/right_bottom.tscn"

var room_dic = {
	"basic_room" : "res://maps/Rooms/room_template.tscn",
	"left_opening" : "res://maps/Rooms/left_opening.tscn",
	"right_opening" : "res://maps/Rooms/right_opening.tscn",
	"top_opening" : "res://maps/Rooms/top_opening.tscn",
	"bottom_opening" : "res://maps/Rooms/bottom_opening.tscn",
	"t_room" : "res://maps/Rooms/t_room.tscn",
	"top_left" : "res://maps/Rooms/top_left.tscn",
	"right_bottom" : "res://maps/Rooms/right_bottom.tscn",
	"start_room" : "res://maps/Rooms/start_room.tscn",
	"2-H Pit 4-way" : "res://maps/Rooms/2-H Pit 4-way.tscn",
	"2-H Pit up-down" : "res://maps/Rooms/2-H Pit up-down.tscn",
	"2-H Pit left-right" : "res://maps/Rooms/2-H Pit left-right.tscn",
	"2-V Pit 4-way" : "res://maps/Rooms/2-V Pit 4-way.tscn",
	"2-V Pit up-down" : "res://maps/Rooms/2-V Pit up-down.tscn",
	"2-V Pit left-right" : "res://maps/Rooms/2-V Pit left-right.tscn",
	"Pillar 4-way" : "res://maps/Rooms/Pillar 4-way.tscn",
	"Pillar down-left" : "res://maps/Rooms/Pillar down-left.tscn",
	"Pillar down-right" : "res://maps/Rooms/Pillar down-right.tscn",
	"Pillar down" : "res://maps/Rooms/Pillar down.tscn",
	"Pillar left-right" : "res://maps/Rooms/Pillar left-right.tscn",
	"Pillar left" : "res://maps/Rooms/Pillar left.tscn",
	"Pillar right" : "res://maps/Rooms/Pillar right.tscn",
	"Pillar up-down" : "res://maps/Rooms/Pillar up-down.tscn",
	"Pillar up-left" : "res://maps/Rooms/Pillar up-left.tscn",
	"Pillar up-right" : "res://maps/Rooms/Pillar up-right.tscn",
	"Pillar up" : "res://maps/Rooms/Pillar up.tscn"}

export var room_sides_dic = {
	"basic_room": {"left": true, "right" : true, "top" : true, "bottom": true},
	"left_opening" : {"left": true, "right" : false, "top" : false, "bottom": false},
	"right_opening" : {"left": false, "right" : true, "top" : false, "bottom": false},
	"top_opening" : {"left": false, "right" : false, "top" : true, "bottom": false},
	"bottom_opening" : {"left": false, "right" : false, "top" : false, "bottom": true},
	"t_room" : {"left": true, "right" : true, "top" : false, "bottom": true},
	"top_left" : {"left": true, "right" : false, "top" : true, "bottom": false},
	"right_bottom" : {"left": false, "right" : true, "top" : false, "bottom": true},
	"start_room" : {"left": true, "right" : true, "top" : true, "bottom": true},
	"2-H Pit 4-way" : {"left": true, "right" : true, "top" : true, "bottom": true},
	"2-H Pit up-down" : {"left": false, "right" : false, "top" : true, "bottom": true},
	"2-H Pit left-right" : {"left": true, "right" : true, "top" : false, "bottom": false},
	"2-V Pit 4-way" : {"left": true, "right" : true, "top" : true, "bottom": true},
	"2-V Pit up-down" : {"left": false, "right" : false, "top" : true, "bottom": true},
	"2-V Pit left-right" : {"left": true, "right" : true, "top" : false, "bottom": false},
	"Pillar 4-way" : {"left": true, "right" : true, "top" : true, "bottom": true},
	"Pillar down-left" : {"left": true, "right" : false, "top" : false, "bottom": true},
	"Pillar down-right" : {"left": false, "right" : true, "top" : false, "bottom": true},
	"Pillar down" : {"left": false, "right" : false, "top" : false, "bottom": true},
	"Pillar left-right" : {"left": true, "right" : true, "top" : false, "bottom": false},
	"Pillar left" : {"left": true, "right" : false, "top" : false, "bottom": false},
	"Pillar right" : {"left": false, "right" : true, "top" : false, "bottom": false},
	"Pillar up-down" : {"left": false, "right" : false, "top" : true, "bottom": true},
	"Pillar up-left" : {"left": true, "right" : false, "top" : true, "bottom": false},
	"Pillar up-right" : {"left": false, "right" : true, "top" : true, "bottom": false},
	"Pillar up" : {"left": false, "right" : false, "top" : true, "bottom": false}
}





var top_rooms_raw = ["basic_room", "bottom_opening", "t_room", "right_bottom", "2-H Pit 4-way", "2-H Pit up-down", "2-V Pit 4-way", "2-V Pit up-down", "Pillar 4-way", "Pillar down-left", "Pillar down-right", "Pillar up-down", "Pillar down"]
var left_rooms_raw = ["basic_room", "right_opening", "t_room", "right_bottom", "2-H Pit 4-way", "2-H Pit left-right", "2-V Pit 4-way", "2-V Pit left-right", "Pillar 4-way", "Pillar up-right", "Pillar down-right", "Pillar left-right", "Pillar right"]
var right_rooms_raw = ["basic_room", "left_opening", "t_room", "top_left", "2-H Pit 4-way", "2-H Pit left-right", "2-V Pit 4-way", "2-V Pit left-right", "Pillar 4-way", "Pillar down-left", "Pillar up-left", "Pillar left-right", "Pillar left"]
var bottom_rooms_raw = ["basic_room", "top_opening", "top_left", "2-H Pit 4-way", "2-H Pit up-down", "2-V Pit 4-way", "2-V Pit up-down", "Pillar 4-way", "Pillar up-right", "Pillar up-left", "Pillar up-down", "Pillar up"]

#------These are the active rooms in the selection---------
var top_rooms = top_rooms_raw
var left_rooms = left_rooms_raw
var right_rooms = right_rooms_raw
var bottom_rooms = bottom_rooms_raw


#-----room count too high------
var top_too_many = ["bottom_opening"]
var left_too_many = ["right_opening"]
var right_too_many = ["left_opening"]
var bottom_too_many = ["top_opening"]

func _process(delta):
	if debug == true:
		print (room_count)


func make_less_rooms():
	top_rooms = top_too_many
	left_rooms = left_too_many
	right_rooms = right_too_many
	bottom_rooms = bottom_too_many

func less_rooms_check():
	if room_count >= room_slowdown:
		top_rooms = top_too_many
		left_rooms = left_too_many
		right_rooms = right_too_many
		bottom_rooms = bottom_too_many


#
#func get_room(room, exclude):
#	if room_count >= 10:
#		make_less_rooms()
#	rng.randomize()
#	var room_spawned = false
#	while room_spawned == false:
#		if room == "left":
#			var room_selected = left_rooms[rng.randi_range(0, left_rooms.size() - 1)]
#			if room_selected != exclude:
#				room_spawned = true
#				room_count += 1
#				return room_selected
#		elif room == "right":
#			var room_selected = right_rooms[rng.randi_range(0, right_rooms.size() - 1)]
#			if room_selected != exclude:
#				room_spawned = true
#				room_count += 1
#				return room_selected
#		elif room == "bottom":
#			var room_selected = bottom_rooms[rng.randi_range(0, bottom_rooms.size() - 1)]
#			if room_selected != exclude:
#				room_spawned = true
#				room_count += 1
#				return room_selected
#		elif room == "top":
#			var room_selected = top_rooms[rng.randi_range(0, top_rooms.size() - 1)]
#			if room_selected != exclude:
#				room_spawned = true
#				room_count += 1
#				return room_selected
#

func get_random_room_id(side):
	less_rooms_check()
	rng.randomize()
	var room_selected
	if side == "left":
		room_selected = left_rooms[rng.randi_range(0, left_rooms.size() - 1)]
	elif side == "right":
		room_selected = right_rooms[rng.randi_range(0, right_rooms.size() - 1)]
	elif side == "top":
		room_selected = top_rooms[rng.randi_range(0, top_rooms.size() - 1)]
	elif side == "bottom":
		 room_selected = bottom_rooms[rng.randi_range(0, bottom_rooms.size() - 1)]
	else:
		print("invalid room side")
	return room_selected		
		
