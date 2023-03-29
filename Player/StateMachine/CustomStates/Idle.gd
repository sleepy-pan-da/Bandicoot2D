extends State

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("move_left"):
		state_machine.transition_to("Run", {"horizontal_direction" : -1})
	elif Input.is_action_just_pressed("move_right"):
		state_machine.transition_to("Run", {"horizontal_direction" : 1})
	elif Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")