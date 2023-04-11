extends State

export var path_to_chicken := NodePath()
onready var chicken : KinematicBody2D = get_node(path_to_chicken)
var velocity : Vector2 = Vector2()


func physics_update(_delta) -> void:
	if chicken.left_raycast.is_colliding():
		state_machine.transition_to("Run", {"horizontal_direction" : -1})
	elif chicken.right_raycast.is_colliding():
		state_machine.transition_to("Run", {"horizontal_direction" : 1})
	
	velocity.y += chicken.GRAVITY
	velocity = chicken.move_and_slide(velocity, chicken.FLOOR_NORMAL)