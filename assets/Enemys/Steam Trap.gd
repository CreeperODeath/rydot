extends StaticBody2D

onready var animation = $AnimatedSprite
onready var BombInstance = preload("res://assets/Enemys/Steam Explosion.tscn")


func _ready():
	pass 


func _process(_delta):
	pass

func _on_Search_body_entered(area):
	if area.is_in_group("player") and animation.animation != ("Loop"):
		animation.play("Open")


func _on_AnimatedSprite_animation_finished():
	if animation.animation == ("Loop"):
		var bomb = BombInstance.instance()
		bomb.position = self.position
		get_parent().add_child(bomb)
	if animation.animation == ("Open"):
		animation.play("Loop")
