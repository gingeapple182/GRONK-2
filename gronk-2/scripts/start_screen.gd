extends Control



func _on_button_start_pressed() -> void:
	print("Start game pressed")
	get_tree().change_scene_to_file("res://scenes/level_intro.tscn")
	
func _on_button_options_pressed() -> void:
	print("Options pressed")
	get_tree().change_scene_to_file("res://scenes/settings_menu.tscn")

func _on_button_exit_pressed() -> void:
	print("Exit game pressed")
	get_tree().quit()
	
