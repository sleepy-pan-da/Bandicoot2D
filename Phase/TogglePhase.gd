class_name TogglePhase
extends Node2D

export var phased_in : bool = true
export var path_to_tilemap := NodePath()
export var damages_player : bool = false
onready var phase_in_hitbox : Area2D = $PhaseInHitbox
var physics_body : Node2D = self

# THINGS THAT CAN BE PHASED
# tilemap terrain
# terrain
# damages player

func _ready() -> void:
	if path_to_tilemap: physics_body = get_node(path_to_tilemap)
	EventManager.connect("toggle_phase", self, "change_phase_state")
	update()


func change_phase_state() -> void:
	phased_in = !phased_in
	update()


func update() -> void:
	modulate = Color(1,1,1,1) if phased_in else Color(1,1,1,0.5)

	# phase in hitbox will kick in before physics collisions to properly check if player is within phased in objects 
	phase_in_hitbox.set_collision_layer_bit(1, phased_in)
	yield(get_tree(), "idle_frame")
	if damages_player: physics_body.set_collision_layer_bit(3, phased_in)
	else: physics_body.set_collision_layer_bit(0, phased_in)

	