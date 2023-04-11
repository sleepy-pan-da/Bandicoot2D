extends AnimatedSprite

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("reload") and event.scancode == KEY_R:
		play("Pressed")
	elif Input.is_action_just_released("reload") and event.scancode == KEY_R:
		play("Default")