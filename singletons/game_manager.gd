extends Node

enum TERRAIN { WATER, LAND }
enum ENEMY_TARGET { PLAYER, POND }

func check_terrain(terrain) -> float:
	if terrain == GameManager.TERRAIN.WATER:
		return 0.66
	if terrain == GameManager.TERRAIN.LAND:
		return 1.0
	
	return 1.0

func check_game_over(player_health: float) -> void:
	if player_health <= 0:
		print_debug("Game Over!!!")
