extends Node2D
class_name EndPoint

onready var animated_sprite : AnimatedSprite = $AnimatedSprite
onready var area2d : Area2D = $Area2D
onready var confetti : FakeConfettiParticles = $FakeConfettiParticles

var is_flag_out : bool = false

func _ready() -> void:
	animated_sprite.play("Disabled")


func enable() -> void:
	area2d.set_deferred("monitoring", true)
	animated_sprite.play("Enabled")
	

func _on_Area2D_body_entered(_body : Node) -> void:
	reached()


func reached() -> void:
	AudioManager.playSfx("HitEndPoint")
	AudioManager.playSfx("ReachedEndPoint")
	is_flag_out = true
	area2d.set_deferred("monitoring", false)
	animated_sprite.play("FlagOut")
	confetti.emitting = true
	yield(get_tree().create_timer(2), "timeout")
	EventManager.emit_signal("completed_level")


func _on_AnimatedSprite_animation_finished() -> void:
	if is_flag_out:
		animated_sprite.play("FlagIdle")