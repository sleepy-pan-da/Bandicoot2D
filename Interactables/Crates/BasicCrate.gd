extends TogglePhase

const BOX_BOUNCE_POWER = -250

onready var top_area = $AreasToBreakCrate/TopArea
onready var btm_area = $AreasToBreakCrate/BtmArea
onready var animated_sprite = $AnimatedSprite

var breaking : bool = false

func _on_TopArea_body_entered(body : Node) -> void:
	# There are cases where the state can be run or idle, but those are hard to come by as
	# the player needs to be pixel perfect
	if body.state_machine.state.name == "Jump":
		# This is for cases where the player shorthops onto the crate, breaking the crate in the jump state.
		# To solve this issue, the top area is toggled off and on to ensure that the crate is only broken in
		# the fall state.
		top_area.set_deferred("monitoring", false)
		top_area.set_deferred("monitoring", true)
	elif body.state_machine.state.name == "Fall":
		body.state_machine.transition_to("Jump", {"velocity": body.state_machine.state.velocity, "jump_power": BOX_BOUNCE_POWER, "facing_left": body.state_machine.state.facing_left})
		hit_crate()


func _on_BtmArea_body_entered(body) -> void:
	if body.state_machine.state.name == "Jump":
		hit_crate()


# overrides func in base
func custom_update() -> void:
	top_area.set_collision_mask_bit(2, phased_in)
	btm_area.set_collision_mask_bit(2, phased_in)


func hit_crate() -> void:
	breaking = true
	animated_sprite.play("Breaking")


func _on_AnimatedSprite_animation_finished() -> void:
	if breaking: queue_free()
