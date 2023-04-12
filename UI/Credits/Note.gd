extends CanvasLayer

onready var rich_text_label : RichTextLabel = $RichTextLabel
onready var tween : Tween = $Tween
onready var confetti_1 : FakeConfettiParticles = $FakeConfettiParticles
onready var confetti_2 : FakeConfettiParticles = $FakeConfettiParticles2

func _ready() -> void:
	AudioManager.playSfx("Credits")
	confetti_1.emitting = true
	confetti_2.emitting = true
	rich_text_label.percent_visible = 0
	tween.interpolate_property(rich_text_label, "percent_visible", 0, 1, 20, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
