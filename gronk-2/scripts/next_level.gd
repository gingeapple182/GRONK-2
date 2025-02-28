extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Something entered: ", body.name)
	if body.is_in_group("player"):
		print("Player reached next level marker")
		#get_tree().change_scene_to_file("res://scenes/level_two.tscn")
		call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_file("res://scenes/level_two.tscn")
