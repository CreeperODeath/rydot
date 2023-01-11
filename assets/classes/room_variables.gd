extends Node

var rng = RandomNumberGenerator.new()

var room_count = 0

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
	"right_bottom" : "res://maps/Rooms/right_bottom.tscn"}


var top_rooms_raw = [room_dic["basic_room"], room_dic["bottom_opening"], room_dic["t_room"], room_dic["right_bottom"]]
var left_rooms_raw = [room_dic["basic_room"], room_dic["right_opening"], room_dic["t_room"], room_dic["right_bottom"]]
var right_rooms_raw = [room_dic["basic_room"], room_dic["left_opening"], room_dic["t_room"], room_dic["top_left"]]
var bottom_rooms_raw = [room_dic["basic_room"], room_dic["top_opening"], room_dic["top_left"]]

#------These are the active rooms in the selection---------
var top_rooms = top_rooms_raw
var left_rooms = left_rooms_raw
var right_rooms = right_rooms_raw
var bottom_rooms = bottom_rooms_raw


#-----room count too high------
var top_too_many = [bottom_opening]
var left_too_many = [right_opening]
var right_too_many = [left_opening]
var bottom_too_many = [top_opening]


func make_less_rooms():
	top_rooms = top_too_many
	left_rooms = left_too_many
	right_rooms = right_too_many
	bottom_rooms = bottom_too_many



func get_room(room, exclude):
	if room_count >= 10:
		make_less_rooms()
	rng.randomize()
	var room_spawned = false
	while room_spawned == false:
		if room == "left":
			var room_selected = left_rooms[rng.randi_range(0, left_rooms.size() - 1)]
			if room_selected != exclude:
				room_spawned = true
				room_count += 1
				return room_selected
		elif room == "right":
			var room_selected = right_rooms[rng.randi_range(0, right_rooms.size() - 1)]
			if room_selected != exclude:
				room_spawned = true
				room_count += 1
				return room_selected
		elif room == "bottom":
			var room_selected = bottom_rooms[rng.randi_range(0, bottom_rooms.size() - 1)]
			if room_selected != exclude:
				room_spawned = true
				room_count += 1
				return room_selected
		elif room == "top":
			var room_selected = top_rooms[rng.randi_range(0, top_rooms.size() - 1)]
			if room_selected != exclude:
				room_spawned = true
				room_count += 1
				return room_selected
				
				
func get_random_room_id(side):
	pass
		
