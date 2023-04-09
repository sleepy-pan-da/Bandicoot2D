extends TogglePhase

export(Array, PackedScene) var broken_particles
export(PackedScene) var explosion
onready var animated_sprite = $AnimatedSprite
var breaking : bool = false

func _on_NitroCrate_body_entered(_body : Node) -> void:
	print(_body.name)
	hit_crate()


func hit_crate() -> void:
	breaking = true
	animated_sprite.play("Breaking")


func _on_AnimatedSprite_animation_finished() -> void:
	if breaking:
		break_into_pieces()
		create_explosion()
		queue_free()


func break_into_pieces() -> void:
	var particles = []
	for particle in broken_particles:
		particles.append(particle.instance())
		
	for particle in particles:
		get_parent().add_child(particle)
		particle.global_position = global_position
	
	particles[0].apply_central_impulse(Vector2(-get_rand_int_between(100, 140), -get_rand_int_between(240, 300)))
	particles[1].apply_central_impulse(Vector2(get_rand_int_between(100, 140), -get_rand_int_between(240, 300)))
	particles[2].apply_central_impulse(Vector2(-get_rand_int_between(100, 140), get_rand_int_between(100, 140)))
	particles[3].apply_central_impulse(Vector2(get_rand_int_between(100, 140), get_rand_int_between(100, 140)))


func get_rand_int_between(start_val : int, end_val : int) -> int:
	randomize()
	return (randi() % (end_val-start_val) + start_val)


func create_explosion() -> void:
	var cur_explosion = explosion.instance()
	get_parent().add_child(cur_explosion)
	cur_explosion.global_position = global_position
	cur_explosion.explode()
