extends State

export var path_to_chicken := NodePath()
onready var chicken : KinematicBody2D = get_node(path_to_chicken)

const INITIAL_LEFT_VELOCITY = 50
const INITIAL_UP_VELOCITY = -250

var velocity : Vector2 = Vector2()
var horizontal_direction : int = 0

func enter(_msg := {}) -> void:
	AudioManager.playSfx("ChickenDie")
	randomize()
	horizontal_direction = 1 if (randi() % 2 == 0) else -1
	velocity.x = horizontal_direction * INITIAL_LEFT_VELOCITY
	velocity.y = INITIAL_UP_VELOCITY


func physics_update(_delta: float) -> void:
	velocity.y += chicken.GRAVITY
	velocity = chicken.move_and_slide(velocity, chicken.FLOOR_NORMAL)
	chicken.rotate(deg2rad(180*_delta*horizontal_direction))
