extends BasicCrate

var hits_left : int = 5

# override func in BasicCrate
func hit_crate() -> void:
	hits_left -= 1
	breaking = true
	animated_sprite.play("Breaking")


func break_crate() -> void:
	hits_left = 0
	breaking = true
	animated_sprite.play("Breaking")


# override func in BasicCrate
func _on_AnimatedSprite_animation_finished() -> void:
	if breaking:
		if hits_left > 0:
			spill_out_fruit()
			return_back_to_default()
		else:
			break_into_pieces()
			spill_out_fruit()
			queue_free()


func return_back_to_default() -> void:
	breaking = false
	animated_sprite.play("Default")