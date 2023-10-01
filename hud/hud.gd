extends CanvasLayer

@onready var score_label: Label = $HUDControl/MarginContainer/HBoxContainer/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_score_update.connect(on_score_update)

func on_score_update() -> void:
	score_label.text = str(GameManager.points)
