extends State

export var path_to_player := NodePath()
onready var player : KinematicBody2D = get_node(path_to_player)

# 1 -> right, -1 -> left
var horizontal_direction : int = 0
var velocity : Vector2 = Vector2()


func enter(_msg := {}) -> void:
	if "velocity" in _msg:
		velocity = _msg["velocity"]
	if "horizontal_direction" in _msg:
		horizontal_direction = _msg["horizontal_direction"]


func exit() -> void:
	horizontal_direction = 0
	velocity = Vector2()


func handle_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("jump"):
		state_machine.transition_to("Jump", {"velocity": velocity, "horizontal_direction": horizontal_direction})
	
	if Input.is_action_pressed("move_left"):
		horizontal_direction = -1
	elif Input.is_action_pressed("move_right"):
		horizontal_direction = 1
	else: 
		horizontal_direction = 0


func physics_update(_delta: float) -> void:
	update_horizontal_velocity(_delta)
	velocity = player.move_and_slide(velocity, player.FLOOR_NORMAL)
	if velocity.x == 0:
		state_machine.transition_to("Idle")


func update_horizontal_velocity(_delta: float) -> void:
	# Acceleration
	if horizontal_direction != 0:
		velocity.x += horizontal_direction * (player.ACCELERATION * _delta)
		if velocity.x > 0: 
			velocity.x = min(velocity.x, player.MAXSPEED)
		else: 
			velocity.x = max(velocity.x, -player.MAXSPEED)
	else:
		# Deceleration
		if velocity.x > 10: 
			velocity.x += -1 * (player.FRICTION * _delta)
		elif velocity.x < -10: 
			velocity.x += 1 * (player.FRICTION * _delta)
		else:
			velocity.x = 0