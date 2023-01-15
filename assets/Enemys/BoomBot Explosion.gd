extends StaticBody2D


func _ready():
	print("boom")
	$BoomTimer.start()


func _on_BoomTimer_timeout():
	queue_free()
