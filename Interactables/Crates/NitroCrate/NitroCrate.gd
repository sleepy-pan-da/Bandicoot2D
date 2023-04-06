extends TogglePhase

export(Array, PackedScene) var broken_particles

onready var animated_sprite = $AnimatedSprite

var breaking : bool = false

# This will not kill player but is used to explode. 
# The phase in hitbox will kill player
#func _on_NitroCrate_body_entered(_body : Node) -> void:
#	print("Nitro crate")
#	# EXPLODE!
#	hit_crate()


func _on_PhaseInHitbox_body_entered(body):
	print("Nitro crate")
	# EXPLODE!
	hit_crate()


func hit_crate() -> void:
	breaking = true
	animated_sprite.play("Breaking")


func _on_AnimatedSprite_animation_finished() -> void:
	if breaking:
		break_into_pieces()
		queue_free()


func break_into_pieces() -> void:
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


func get_rand_int_between(start_val : int, end_val : int) -> int:
	randomize()
	return (randi() % (end_val-start_val) + start_val)



