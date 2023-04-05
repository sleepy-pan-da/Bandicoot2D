extends State

export var path_to_player := NodePath()
onready var player : KinematicBody2D = get_node(path_to_player)

var velocity : Vector2 = Vector2()
# this is for sprite flipping
var facing_left : bool = false

func enter(_msg := {}) -> void:
	if "facing_left" in _msg:	
		facing_left = _msg["facing_left"]
	player.sprite_animation.flip_h = facing_left
	fall_if_not_on_floor()


func process_input() -> void:
	if Input.is_action_pressed("move_left"):
		state_machine.transition_to("Run", {"horizontal_direction" : -1, "facing_left" : true})
	elif Input.is_action_pressed("move_right"):
		state_machine.transition_to("Run", {"horizontal_direction" : 1, "facing_left" : false})
	elif Input.is_action_pressed("jump"):
		state_machine.transition_to("Jump", {"facing_left": facing_left})


func physics_update(_delta: float) -> void:
	process_input()
	velocity.y += player.GRAVITY
	velocity = player.move_and_slide(velocity, player.FLOOR_NORMAL)
	fall_if_not_on_floor()


func fall_if_not_on_floor() -> void:
	if !player.is_on_floor(): state_machine.transition_to("Fall", {"facing_left": facing_left})
	