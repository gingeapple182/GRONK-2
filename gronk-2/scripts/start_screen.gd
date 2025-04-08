extends Control



func _on_button_start_pressed() -> void:
	print("Start game pressed")
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
func _on_button_options_pressed() -> void:
	print("Options pressed")
	pass

func _on_button_exit_pressed() -> void:
	print("Exit game pressed")
	get_tree().quit()
	
