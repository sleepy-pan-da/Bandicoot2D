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
	if "jump_power" in _msg:
		velocity.y = _msg["jump_power"]
		return
	velocity.y = player.JUMP_POWER


func exit() -> void:
	horizontal_direction = 0
	velocity = Vector2()

# The code here will usually be in handle_input
# but it needs to be here for increased precision
# when jumping off crates
func update(_delta: float) -> void:
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


func handle_input(_event: InputEvent) -> void:
	# short hop
	if Input.is_action_just_released("jump"):
		velocity.y *= 0.5
	
	
func physics_update(_delta: float) -> void:
	update_horizontal_velocity(_delta)
	velocity.y += player.GRAVITY
	velocity = player.move_and_slide(velocity, player.FLOOR_NORMAL)

	if velocity.y >= 0:
		state_machine.transition_to("Fall", {"velocity" : velocity, "horizontal_direction": horizontal_direction, "facing_left": facing_left})


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
