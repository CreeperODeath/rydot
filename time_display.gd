extends RichTextLabel


var time
var time_display_min
var time_display_sec
onready var world = get_node("/root/World")
func _process(delta):
	time = world.time
	time_display_min = round(time / 60)
	time_display_sec = time%60
	if time_display_sec <10:
		time_display_sec = "0" + str(time_display_sec)
	set_text("Time " + str(time_display_min) + ":" + str(time_display_sec))
