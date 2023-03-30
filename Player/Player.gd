extends KinematicBody2D

const ACCELERATION = 1200
const MAXSPEED = 100
const MAXSPEED_AIR = 150
const FRICTION = 1000
const FLOOR_NORMAL = Vector2(0, -1)
const JUMP_POWER = -250
const GRAVITY = 10

onready var state_machine : StateMachine = $StateMachine
onready var sprite_animation : AnimatedSprite = $SpriteAnimation
onready var raycast : RayCast2D = $RayCast2D

func _ready() -> void:
    state_machine.connect("transitioned", self, "update_sprite_animation")


func update_sprite_animation(new_animation_name : String):
    sprite_animation.animation = new_animation_name