extends Node2D

@export var next_level_path: String = "res://LevelTwo.tscn"

#func _ready():
	#connect("body_entered", _on_body_entered)
	#
#func _on_body_entered(body):
	#if body.is_in_group("player"):
		#get_tree().change_scene_to_file(next_level_path)

func _on_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_file("res://LevelTwo.tscn")
