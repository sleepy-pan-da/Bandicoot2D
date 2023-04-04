extends RigidBody2D

export(PackedScene) var collectedFruitVfx

func _on_PickableArea_body_entered(_body : Node) -> void:
	collected()


func collected() -> void:
	var vfx : AnimatedSprite = collectedFruitVfx.instance()
	get_parent().add_child(vfx)
	vfx.global_position = global_position
	vfx.play("Default")
	queue_free()