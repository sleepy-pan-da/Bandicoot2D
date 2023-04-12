extends Label



func update_label(level_name : String) -> void:
	var level_number : String = level_name.split("Level")[1]
	text = level_number + "/18"