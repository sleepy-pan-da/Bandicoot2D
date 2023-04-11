class_name ScreenTransition
extends ColorRect

onready var tween : Tween = $Tween
var black_screen : bool = true
signal transitioned_out

func _ready():
	material.set_shader_param("progress", 1)


func transition_in() -> void:
	material.set_shader_param("progress", 1)
	tween.interpolate_property(material, "shader_param/progress", 1, 0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	black_screen = false


func transition_out() -> void:
	material.set_shader_param("progress", 0)
	tween.interpolate_property(material, "shader_param/progress", 0, 1, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	black_screen = true


func _on_Tween_tween_all_completed() -> void:
	if black_screen: emit_signal("transitioned_out")