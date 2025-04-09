extends Control

# audio settings
func _on_master_volume_value_changed(value: float) -> void:
	pass # Replace with function body.

func _on_music_volume_value_changed(value: float) -> void:
	pass # Replace with function body.

func _on_sfx_volume_value_changed(value: float) -> void:
	pass # Replace with function body.

func _on_mute_focus_box_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.

# display settings
func _on_fullscreen_box_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.

func _on_ui_scale_value_changed(value: float) -> void:
	pass # Replace with function body.

# navigation buttons
func _on_button_reset_pressed() -> void:
	pass # Replace with function body.

func _on_button_apply_pressed() -> void:
	pass # Replace with function body.

func _on_button_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
