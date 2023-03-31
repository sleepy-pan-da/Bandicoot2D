extends State

export var path_to_player := NodePath()
onready var player : KinematicBody2D = get_node(path_to_player)

# this is for sprite flipping
var facing_left : bool = false

func enter(_msg := {}) -> void:
	if "facing_left" in _msg:	
		facing_left = _msg["facing_left"]
	player.sprite_animation.flip_h = facing_left

	if !player.is_on_floor():
		state_machine.transition_to("Fall", {"facing_left": facing_left})


func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("move_left"):
		state_machine.transition_to("Run", {"horizontal_direction" : -1, "facing_left" : true})
	elif Input.is_action_just_pressed("move_right"):
		state_machine.transition_to("Run", {"horizontal_direction" : 1, "facing_left" : false})
	elif Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump", {"facing_left": facing_left})
