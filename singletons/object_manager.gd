extends Node

enum ENEMIES_KEY { SKINNY, CHUNGUS, SHOOTER }

const ENEMIES = {
	ENEMIES_KEY.SKINNY: preload("res://enemy/enemy_skinny/enemy_skinny.tscn"),
}

func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)
	
func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)

func create_enemy(enemy_type: GameManager.ENEMY_TYPE, g_pos: Vector2):
	var new_enemy
	if enemy_type == GameManager.ENEMY_TYPE.SKINNY:
		new_enemy = ENEMIES[ENEMIES_KEY.SKINNY].instantiate()
	
	new_enemy.setup()
	call_add_child(new_enemy)


"""
enum BULLET_KEY { PLAYER, ENEMY }

const BULLETS = {
	BULLET_KEY.PLAYER: 
		preload("res://bullets/bullet_player/bullet_player.tscn"),
	BULLET_KEY.ENEMY:
		preload("res://bullets/bullet_enemy/bullet_enemy.tscn"),
}

func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)

func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)

func create_bullet(speed: float, direction: Vector2, start_pos: Vector2,
					life_span: float, key: BULLET_KEY):
	var new_b = BULLETS[key].instantiate()
	new_b.setup(direction, life_span, speed)
	new_b.global_position = start_pos
	call_add_child(new_b)
"""
