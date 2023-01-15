extends RichTextLabel


var time
var time_display_min
var time_display_sec
onready var SoundTimer = $SoundTimer
onready var LowTime = $LowTime
onready var world = get_node("/root/World")
func _process(_delta):
	if is_instance_valid(world):
		time = world.time
	if time != null:
		time_display_min = round(time / 60)
		time_display_sec = time%60
		if time_display_sec <10:
			time_display_sec = "0" + str(time_display_sec)
			if SoundTimer.is_stopped():
				SoundTimer.start()
				LowTime.play()
		set_text("Time " + str(time_display_min) + ":" + str(time_display_sec))
