extends Node2D

onready var sfx : Node2D = $SFX
onready var music : Node2D = $Music

func _ready() -> void:
	playTheme()


func playSfx(soundName : String) -> void:
	var audio : AudioStreamPlayer = sfx.get_node(soundName)
	if not audio:
		print("Audio {soundName} not found".format({"soundName": soundName}))
		return
	audio.play()


func playTheme() -> void:
	var audio : AudioStreamPlayer = music.get_node_or_null("Theme")
	if not audio:
		print("Audio {soundName} not found".format({"soundName": "Theme"}))
		return
	audio.play()


func setMasterBusVolumeDb(desiredVolDb : float) -> void:
	AudioServer.set_bus_volume_db(0, desiredVolDb)


func setMusicBusVolumeDb(desiredVolDb : float) -> void:
	AudioServer.set_bus_volume_db(1, desiredVolDb)


func setSfxBusVolumeDb(desiredVolDb : float) -> void:
	AudioServer.set_bus_volume_db(2, desiredVolDb)


func getMasterBusVolumeDb() -> float:
	return AudioServer.get_bus_volume_db(0)


func getMusicBusVolumeDb() -> float:
	return AudioServer.get_bus_volume_db(1)


func getSfxBusVolumeDb() -> float:
	return AudioServer.get_bus_volume_db(2)