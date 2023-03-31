extends State

export var path_to_player := NodePath()
onready var player : KinematicBody2D = get_node(path_to_player)

const INITIAL_LEFT_VELOCITY = 50
const INITIAL_UP_VELOCITY = -250

var velocity : Vector2 = Vector2()
var horizontal_direction : int = 0

func enter(_msg := {}) -> void:
	randomize()
	horizontal_direction = 1 if (randi() % 2 == 0) else -1
	velocity.x = horizontal_direction * INITIAL_LEFT_VELOCITY
	velocity.y = INITIAL_UP_VELOCITY


func physics_update(_delta: float) -> void:
	velocity.y += player.GRAVITY
	velocity = player.move_and_slide(velocity, player.FLOOR_NORMAL)
	player.rotate(deg2rad(180*_delta*horizontal_direction))