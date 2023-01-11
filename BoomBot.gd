extends "res://assets/Enemys/slime_enemy.gd"

	


func _on_explode_radius_body_entered(body):
	if body.is_in_group("player"):
		can_move = false
		slime_sprite.set_animation("boom")
		slime_sprite.set_frame(0)


func _on_AnimatedSprite_animation_finished():
	if slime_sprite.get_animation() == "boom":
		health = 0
