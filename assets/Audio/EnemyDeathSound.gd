extends AudioStreamPlayer

func _ready():
	play()

func _on_BoomSound_finished():
	queue_free()
