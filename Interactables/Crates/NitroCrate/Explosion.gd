extends Area2D

onready var animated_sprite = $AnimatedSprite

func explode() -> void:
	animated_sprite.play("Default")


func _on_AnimatedSprite_animation_finished():
	queue_free()


func _on_Explosion_area_entered(area : Area2D):
	if area.has_method("hit_crate"): area.hit_crate()


func _on_Explosion_body_entered(body : Node):
	if body.has_method("break_crate"):
		body.break_crate()
	elif body.has_method("hit_crate"): 
		body.hit_crate()
