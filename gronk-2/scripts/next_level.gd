extends Area2D
@onready var level_manager: Node = %LevelManager

var level = 1

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		call_deferred("change_scene")

func change_scene():
	if GameManager.level == 0:
		level_manager.save_score()
		get_tree().change_scene_to_file("res://scenes/levels/level_one.tscn")
		GameManager.level = 1
		GameManager.gameLocation = 1
	elif GameManager.level == 1:
		level_manager.save_score()
		get_tree().change_scene_to_file("res://scenes/levels/level_two.tscn")
		GameManager.level = 2
		GameManager.gameLocation = 2
	elif GameManager.level == 2:
		level_manager.save_score()
		get_tree().change_scene_to_file("res://scenes/menu/end_screen.tscn")
		GameManager.level = 3
		GameManager.gameLocation = 3
