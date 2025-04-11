extends Control

var pending_master_volume := 100.0
var pending_music_volume := 100.0
var pending_sfx_volume := 100.0
#var mute_when_unfocussed := true


# set settings to be accurate
func _ready() -> void:
	# audio
	var master_db = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	var music_db = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	var sfx_db = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))

	pending_master_volume = db_to_linear(master_db) * 100.0
	pending_music_volume = db_to_linear(music_db) * 100.0
	pending_sfx_volume = db_to_linear(sfx_db) * 100.0

	$Panel/VBoxContainer/MasterVolume/MasterVolumeSlider.value = pending_master_volume
	$Panel/VBoxContainer/MusicVolume/MusicVolumeSlider.value = pending_music_volume
	$Panel/VBoxContainer/SFXVolume/SFXVolumeSlider.value = pending_sfx_volume
	
	$Panel/VBoxContainer/MuteUnfocussed/MuteFocusCheckBox.button_pressed = GameManager.mute_when_unfocussed
	
	# display

# audio settings
func _on_master_volume_value_changed(value: float) -> void:
	pending_master_volume = value

func _on_music_volume_value_changed(value: float) -> void:
	pending_music_volume = value

func _on_sfx_volume_value_changed(value: float) -> void:
	pending_sfx_volume = value

func _on_mute_focus_box_toggled(toggled_on: bool) -> void:
	GameManager.mute_when_unfocussed = toggled_on

# display settings
func _on_fullscreen_box_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.

func _on_ui_scale_value_changed(value: float) -> void:
	pass # Replace with function body.


# navigation buttons
func _on_button_reset_pressed() -> void:
	pass # Replace with function body.

func _on_button_apply_pressed() -> void:
	var master_db = linear_to_db(pending_master_volume / 100.0)
	var music_db = linear_to_db(pending_music_volume / 100.0)
	var sfx_db = linear_to_db(pending_sfx_volume / 100.0)
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), master_db)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), music_db)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), sfx_db)
	print("Applying volumes: Master =", pending_master_volume, ", Music =", pending_music_volume, ", SFX =", pending_sfx_volume)
	print("Master dB:", master_db, "Music dB:", music_db, "SFX dB:", sfx_db)
	print("Settings applied ':)'")

func _on_button_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/start_screen.tscn")
