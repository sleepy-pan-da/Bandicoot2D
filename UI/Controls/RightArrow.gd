extends AnimatedSprite

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("move_right") and event.scancode == KEY_RIGHT:
		play("Pressed")
	elif Input.is_action_just_released("move_right") and event.scancode == KEY_RIGHT:
		play("Default")