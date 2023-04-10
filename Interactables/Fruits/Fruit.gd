extends RigidBody2D

export(PackedScene) var collectedFruitVfx

func _on_PickableArea_body_entered(_body : Node) -> void:
	collected()


func collected() -> void:
	AudioManager.playSfx("CollectFruit")
	EventManager.emit_signal("collected_fruit")
	var vfx : AnimatedSprite = collectedFruitVfx.instance()
	get_parent().add_child(vfx)
	vfx.global_position = global_position
	vfx.play("Default")
	queue_free()