extends Node

var rng = RandomNumberGenerator.new()

class_name room_variables
var basic_room = "res://maps/Rooms/room_template.tscn"
var bottom_opening = "res://maps/Rooms/bottom_opening.tscn"

var top_rooms = [basic_room, bottom_opening]
var left_rooms = [basic_room]
var right_rooms = [basic_room]
var bottom_rooms = [basic_room]



func get_room(room, exclude):
	rng.randomize()
	var room_spawned = false
	while room_spawned == false:
		if room == "top":
			var room_selected = top_rooms[rng.randi_range(0, top_rooms.size() - 1)]
			if room_selected != exclude:
				room_spawned = true
				return room_selected
		
