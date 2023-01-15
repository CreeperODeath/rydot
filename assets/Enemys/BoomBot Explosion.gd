extends StaticBody2D


func _ready():
	$BoomTimer.start()


func _on_BoomTimer_timeout():
	queue_free()
