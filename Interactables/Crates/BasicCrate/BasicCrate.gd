extends TogglePhase
class_name BasicCrate

const BOX_BOUNCE_POWER = -300#-250

export(Array, PackedScene) var broken_particles
export(PackedScene) var fruit

onready var top_area = $AreasToBreakCrate/TopArea
onready var btm_area = $AreasToBreakCrate/BtmArea
onready var animated_sprite = $AnimatedSprite

var breaking : bool = false
enum HitFrom {TOP, BOTTOM}
var last_hit_from : int

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
		last_hit_from = HitFrom.TOP


func _on_BtmArea_body_entered(body) -> void:
	if body.state_machine.state.name == "Jump":
		hit_crate()
		last_hit_from = HitFrom.BOTTOM


func hit_crate() -> void:
	AudioManager.playSfx("HitCrate")
	breaking = true
	animated_sprite.play("Breaking")


func _on_AnimatedSprite_animation_finished() -> void:
	if breaking:
		break_into_pieces()
		spill_out_fruit()
		queue_free()


func break_into_pieces() -> void:
	AudioManager.playSfx("BreakCrate")
	var particles = []
	for particle in broken_particles:
		particles.append(particle.instance())
		
	for particle in particles:
		get_parent().add_child(particle)
		particle.global_position = global_position
	
	particles[0].apply_central_impulse(Vector2(-get_rand_int_between(50, 70), -get_rand_int_between(120, 150)))
	particles[1].apply_central_impulse(Vector2(get_rand_int_between(50, 70), -get_rand_int_between(120, 150)))
	particles[2].apply_central_impulse(Vector2(-get_rand_int_between(50, 70), get_rand_int_between(50, 70)))
	particles[3].apply_central_impulse(Vector2(get_rand_int_between(50, 70), get_rand_int_between(50, 70)))


func spill_out_fruit() -> void:
	var spilled_fruit = fruit.instance()
	get_parent().add_child(spilled_fruit)
	spilled_fruit.global_position = global_position

	if last_hit_from == HitFrom.BOTTOM: spilled_fruit.global_position.y -= 10
	
	if last_hit_from == HitFrom.TOP:
		spilled_fruit.apply_central_impulse(Vector2(0, -350))
	else:
		spilled_fruit.apply_central_impulse(Vector2(0, 0))



func get_rand_int_between(start_val : int, end_val : int) -> int:
	randomize()
	return (randi() % (end_val-start_val) + start_val)


# overriden in base class
func update() -> void:
	modulate = Color(1,1,1,1) if phased_in else Color(1,1,1,0.3)

	# phase in hitbox will kick in before physics collisions to properly check if player is within phased in objects 
	phase_in_hitbox.set_collision_layer_bit(1, phased_in)
	yield(get_tree(), "idle_frame")
	physics_body.set_collision_layer_bit(4, phased_in)
	custom_update()


# overrides func in base
func custom_update() -> void:
	top_area.set_collision_mask_bit(2, phased_in)
	btm_area.set_collision_mask_bit(2, phased_in)
