extends TogglePhase

const BOX_BOUNCE_POWER = -250

onready var top_area = $AreasToBreakCrate/TopArea
onready var btm_area = $AreasToBreakCrate/BtmArea
onready var animated_sprite = $AnimatedSprite

var breaking : bool = false

func _on_TopArea_body_entered(body : Node) -> void:
	# print("cur state: {cur_state}".format({"cur_state": body.state_machine.state.name}))
	# print("cur velocity: {cur_velo}".format({"cur_velo": body.state_machine.state.velocity}))
	if body.state_machine.state.name == "Jump":
		top_area.set_deferred("monitoring", false)
		top_area.set_deferred("monitoring", true)
	elif body.state_machine.state.name == "Fall":
		body.state_machine.transition_to("Jump", {"velocity": body.state_machine.state.velocity, "jump_power": BOX_BOUNCE_POWER, "facing_left": body.state_machine.state.facing_left})
		break_crate()


func _on_BtmArea_body_entered(body) -> void:
	if body.state_machine.state.name == "Jump":
		break_crate()


# overrides func in base
func custom_update() -> void:
	top_area.set_collision_mask_bit(2, phased_in)
	btm_area.set_collision_mask_bit(2, phased_in)


func break_crate() -> void:
	breaking = true
	animated_sprite.play("Breaking")


func _on_AnimatedSprite_animation_finished() -> void:
	if breaking: queue_free()
