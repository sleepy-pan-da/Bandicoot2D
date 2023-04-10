extends KinematicBody2D

const ACCELERATION = 1200
const MAXSPEED = 100
const MAXSPEED_AIR = 150
const FRICTION = 1000
const FLOOR_NORMAL = Vector2(0, -1)
const JUMP_POWER = -350
const GRAVITY = 12

onready var state_machine : StateMachine = $StateMachine
onready var sprite_animation : AnimatedSprite = $SpriteAnimation
onready var raycast : RayCast2D = $RayCast2D
onready var hurtbox : Area2D = $Hurtbox

export var facing_left_initially : bool = false


func _ready() -> void:
    state_machine.connect("transitioned", self, "update_sprite_animation")
    state_machine.get_node("Idle").facing_left = facing_left_initially

func update_sprite_animation(new_animation_name : String):
    sprite_animation.animation = new_animation_name


func _unhandled_input(_event: InputEvent) -> void:
    if Input.is_action_just_pressed("toggle_phase"):
        EventManager.emit_signal("toggle_phase")


func _on_Hurtbox_area_entered(_area: Area2D) -> void:
    set_collision_layer_bit(2, false)
    set_collision_mask_bit(0, false)
    set_collision_mask_bit(4, false)
    hurtbox.set_collision_mask_bit(1, false)
    hurtbox.set_collision_mask_bit(3, false)
    state_machine.transition_to("Death")