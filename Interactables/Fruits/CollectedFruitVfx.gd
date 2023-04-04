extends AnimatedSprite

func _on_CollectedFruitVfx_animation_finished() -> void:
	queue_free()