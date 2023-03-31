extends Node2D


func _unhandled_input(_event: InputEvent) -> void:
    if Input.is_action_just_pressed("reload"):
        get_tree().reload_current_scene()