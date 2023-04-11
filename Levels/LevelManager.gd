class_name LevelManager
extends Node2D

export var fruits_left : int = 0
onready var endpt : EndPoint = $EndPoint
onready var level_indicator : Label = $UI/LevelIndicator
onready var screen_transition : ScreenTransition = $CanvasLayer/ScreenTransition

func _ready() -> void:
	level_indicator.update_label(name)
	EventManager.connect("collected_fruit", self, "on_collected_fruit")
	screen_transition.connect("transitioned_out", self, "on_transitioned_out")
	init_endpt_if_all_fruits_are_collected()
	screen_transition.transition_in()


func init_endpt_if_all_fruits_are_collected() -> void:
	if fruits_left == 0: endpt.enable()


func on_collected_fruit() -> void:
	fruits_left -= 1
	enable_endpt_if_all_fruits_are_collected()


func enable_endpt_if_all_fruits_are_collected() -> void:
	if fruits_left == 0:
		AudioManager.playSfx("EnabledEndPoint")
		endpt.enable()


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("reload"):
		screen_transition.transition_out()
		# get_tree().reload_current_scene()


func on_transitioned_out() -> void:
	get_tree().reload_current_scene()
