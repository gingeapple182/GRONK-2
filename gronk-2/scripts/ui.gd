extends CanvasLayer

@onready var score_label: Label = $ScoreUI/ScoreLabel
@onready var health_ui: Control = $HealthUI

func update_score(current_score: int) -> void:
	score_label.text = str(current_score)

func update_health(curremt_health: float) -> void:
	health_ui.update_hearts(curremt_health)
