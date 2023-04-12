extends AnimatedSprite

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("toggle_phase") and event.scancode == KEY_SPACE:
		play("Pressed")
	elif Input.is_action_just_released("toggle_phase") and event.scancode == KEY_SPACE:
		play("Default")