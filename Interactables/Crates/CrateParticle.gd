extends RigidBody2D

onready var animation_player : AnimationPlayer = $AnimationPlayer

func _on_Timer_timeout() -> void:
	animation_player.play("Flicker")


func delete_particle() -> void:
	queue_free()