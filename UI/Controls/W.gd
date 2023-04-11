extends AnimatedSprite

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("jump") and event.scancode == KEY_W:
		play("Pressed")
	elif Input.is_action_just_released("jump") and event.scancode == KEY_W:
		play("Default")