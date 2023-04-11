extends AnimatedSprite

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("move_left") and event.scancode == KEY_LEFT:
		play("Pressed")
	elif Input.is_action_just_released("move_left") and event.scancode == KEY_LEFT:
		play("Default")