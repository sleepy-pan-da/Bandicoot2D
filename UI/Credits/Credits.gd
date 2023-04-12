extends Node2D

export (String, FILE) var level_1
onready var screen_transition : ScreenTransition = $CanvasLayer/ScreenTransition

func _ready() -> void:
	screen_transition.connect("transitioned_out", self, "on_transitioned_out")
	screen_transition.transition_in()


func _unhandled_key_input(_event) -> void:
	if Input.is_action_just_pressed("reload"):
		screen_transition.transition_out()


func on_transitioned_out() -> void:
	if !level_1: return
	get_tree().change_scene(level_1)
