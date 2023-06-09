extends State

export var path_to_player := NodePath()
onready var player : KinematicBody2D = get_node(path_to_player)

# 1 -> right, -1 -> left
var horizontal_direction : int = 0
var velocity : Vector2 = Vector2()
# this is for sprite flipping
var facing_left : bool = false

func enter(_msg := {}) -> void:
	if "velocity" in _msg:
		velocity = _msg["velocity"]
	if "horizontal_direction" in _msg:
		horizontal_direction = _msg["horizontal_direction"]
	if "facing_left" in _msg:	
		facing_left = _msg["facing_left"]
	player.sprite_animation.flip_h = facing_left
	

func exit() -> void:
	horizontal_direction = 0
	velocity = Vector2()


func process_input() -> void:
	if Input.is_action_pressed("jump") and player.raycast.is_colliding():
		state_machine.transition_to("Jump", {"velocity": velocity, "horizontal_direction": horizontal_direction, "facing_left": facing_left})
	
	# horizontal movement
	if Input.is_action_pressed("move_left"):
		horizontal_direction = -1
		facing_left = true
	elif Input.is_action_pressed("move_right"):
		horizontal_direction = 1
		facing_left = false
	else: 
		horizontal_direction = 0
	player.sprite_animation.flip_h = facing_left


func physics_update(_delta: float) -> void:
	process_input()
	update_horizontal_velocity(_delta)
	velocity.y += player.GRAVITY
	velocity = player.move_and_slide(velocity, player.FLOOR_NORMAL)

	if player.is_on_floor():
		if horizontal_direction == 0:
			state_machine.transition_to("Idle", {"facing_left": facing_left})
		else:
			state_machine.transition_to("Run", {"velocity" : velocity, "horizontal_direction": horizontal_direction, "facing_left": facing_left})


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
