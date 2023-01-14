extends RigidBody2D

onready var sprite = $AnimatedSprite
onready var collision_shape = $CollisionShape2D


func _on_Area2D_body_entered(body):
	if body.is_in_group("damage_enemy"):
		sprite.set_animation("broke")
		collision_shape.set_deferred("disabled", true)
