extends Control

const HEART_FULL = preload("res://assets/sprites/heart_full.png")
const HEART_HALF = preload("res://assets/sprites/heart_half.png")
const HEART_EMPTY =preload("res://assets/sprites/heart_empty.png")

var max_health := 100.0
var hearts := 4.0

func update_hearts(current_health) -> void:
	print("Update hearts received:", current_health, " (", typeof(current_health), ")")
	var health_per_heart := max_health / hearts
	for i in range(hearts):
		var heart = $HBoxContainer.get_child(i)
		var heart_value = clamp(current_health - (i * health_per_heart), 0, health_per_heart)
		
		if heart_value >= health_per_heart:
			heart.texture = HEART_FULL
		elif heart_value >= health_per_heart / 2:
			heart.texture = HEART_HALF
		else:
			heart.texture = HEART_EMPTY
