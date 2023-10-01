extends Node

enum TERRAIN { WATER, LAND }
enum ENEMY_TARGET { PLAYER, POND }
enum ENEMY_TYPE { SKINNY, PAN, CHUNGUS, SHOOTER }

var points: float = 0

func _ready() -> void:
	print_debug(points)
	SignalManager.on_score_update.emit()

func check_terrain(terrain) -> float:
	if terrain == GameManager.TERRAIN.WATER:
		return 0.66
	if terrain == GameManager.TERRAIN.LAND:
		return 1.0
	
	return 1.0

func add_points(amount: float) -> void:
	points += amount
	SignalManager.on_score_update.emit()

func check_game_over(player_health: float) -> void:
	if player_health <= 0:
		SignalManager.on_game_over.emit()
	
	
