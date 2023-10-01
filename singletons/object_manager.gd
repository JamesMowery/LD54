extends Node

enum ENEMIES_KEY { SKINNY, CHUNGUS, SHOOTER }

const ENEMIES = {
	ENEMIES_KEY.SKINNY: preload("res://enemy/enemy_skinny_v2/enemy_skinny_v2.tscn"),
}

func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)
	
func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)

func create_enemy(enemy_type: GameManager.ENEMY_TYPE, g_pos: Vector2):
	var new_enemy
	if enemy_type == GameManager.ENEMY_TYPE.SKINNY:
		new_enemy = ENEMIES[ENEMIES_KEY.SKINNY].instantiate()
	
	new_enemy.global_position = g_pos
	
	call_add_child(new_enemy)
