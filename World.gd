extends Node2D


var time = 600

func _on_Timer_timeout():
	time -= 1
	print(time)


func _ready():
	pass # Replace with function body.


#func _process(delta):
#	pass
