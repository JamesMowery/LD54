extends Node

signal on_game_over
signal on_wave_over
signal on_health_update
signal on_enemy_entered_pond
signal on_damage_to_pond(amount: float)
signal on_damage_to_player(amount: float)
signal on_damage_to_enemy(enemy: Node2D, amount: float)
