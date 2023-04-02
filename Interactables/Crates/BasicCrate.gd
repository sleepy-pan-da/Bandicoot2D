extends TogglePhase

const BOX_BOUNCE_POWER = -180

onready var top_area = $AreasToBreakCrate/TopArea
onready var btm_area = $AreasToBreakCrate/BtmArea

var player_states_that_can_break_crate = ["Jump", "Fall"]

func _on_TopArea_body_entered(body : Node) -> void:
	if body.state_machine.prev_state.name in player_states_that_can_break_crate:
		body.state_machine.transition_to("Jump", {"jump_power": BOX_BOUNCE_POWER, "facing_left": body.state_machine.state.facing_left})
		queue_free()


func _on_BtmArea_body_entered(body) -> void:
	if body.state_machine.prev_state.name in player_states_that_can_break_crate:
		queue_free()
		pass


func custom_update() -> void:
	top_area.set_collision_mask_bit(2, phased_in)
	btm_area.set_collision_mask_bit(2, phased_in)
