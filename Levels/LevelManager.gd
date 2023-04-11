class_name LevelManager
extends Node2D

export var fruits_left : int = 0
export (PackedScene) var next_level
onready var endpt : EndPoint = $EndPoint
onready var level_indicator : Label = $UI/LevelIndicator
onready var screen_transition : ScreenTransition = $CanvasLayer/ScreenTransition
onready var timer_till_restart : Timer = $TimerTillRestart
var completed_level : bool = false

func _ready() -> void:
	level_indicator.update_label(name)
	EventManager.connect("collected_fruit", self, "on_collected_fruit")
	EventManager.connect("died", self, "on_death")
	EventManager.connect("completed_level", self, "on_completed_level")

	screen_transition.connect("transitioned_out", self, "on_transitioned_out")
	init_endpt_if_all_fruits_are_collected()
	screen_transition.transition_in()


func init_endpt_if_all_fruits_are_collected() -> void:
	if fruits_left == 0: endpt.enable()


func on_collected_fruit() -> void:
	fruits_left -= 1
	enable_endpt_if_all_fruits_are_collected()


func on_death() -> void:
	timer_till_restart.start()


func _on_TimerTillRestart_timeout() -> void:
	screen_transition.transition_out()


func on_completed_level() -> void:
	completed_level = true
	screen_transition.transition_out()


func enable_endpt_if_all_fruits_are_collected() -> void:
	if fruits_left == 0:
		AudioManager.playSfx("EnabledEndPoint")
		endpt.enable()


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("reload"):
		screen_transition.transition_out()


func on_transitioned_out() -> void:
	if completed_level:
		completed_level = false
		if !next_level: return
		get_tree().change_scene_to(next_level)
	else: get_tree().reload_current_scene()
