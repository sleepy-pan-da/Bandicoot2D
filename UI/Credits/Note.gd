extends CanvasLayer

onready var rich_text_label : RichTextLabel = $RichTextLabel
onready var tween : Tween = $Tween

func _ready() -> void:
	rich_text_label.percent_visible = 0
	tween.interpolate_property(rich_text_label, "percent_visible", 0, 1, 20, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
