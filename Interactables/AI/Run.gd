extends State

export var path_to_chicken := NodePath()
onready var chicken : KinematicBody2D = get_node(path_to_chicken)

var horizontal_direction : int = 0
var velocity : Vector2 = Vector2()

func enter(_msg := {}) -> void:
	if "horizontal_direction" in _msg:
		horizontal_direction = _msg["horizontal_direction"]
	chicken.sprite_animation.flip_h = true if horizontal_direction == 1 else false


func exit() -> void:
	horizontal_direction = 0
	velocity = Vector2()


func physics_update(_delta: float) -> void:
	if !chicken.left_raycast.is_colliding() and !chicken.right_raycast.is_colliding():
		state_machine.transition_to("Idle")

	velocity.x = horizontal_direction * chicken.MAXSPEED
	velocity.y += chicken.GRAVITY
	velocity = chicken.move_and_slide(velocity, chicken.FLOOR_NORMAL)
