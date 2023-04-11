extends KinematicBody2D

const FLOOR_NORMAL = Vector2(0, -1)
const MAXSPEED = 50
const GRAVITY = 12

onready var state_machine : StateMachine = $StateMachine
onready var left_raycast : RayCast2D = $LeftRayCast
onready var right_raycast : RayCast2D = $RightRayCast
onready var sprite_animation : AnimatedSprite = $AnimatedSprite
onready var hurtbox : Area2D = $Hurtbox


func _ready() -> void:
    state_machine.connect("transitioned", self, "update_sprite_animation")


func update_sprite_animation(new_animation_name : String) -> void:
	sprite_animation.animation = new_animation_name


func _on_Hurtbox_area_entered(_area : Area2D) -> void:
    set_collision_layer_bit(5, false)
    set_collision_mask_bit(0, false)
    set_collision_mask_bit(4, false)
    hurtbox.set_collision_mask_bit(1, false)
    hurtbox.set_collision_mask_bit(3, false)	
    state_machine.transition_to("Death")