extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer

var spawn_container: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawns: Array = get_tree().get_nodes_in_group("spawn")
	
	for i in spawns:
		spawn_container.push_front(i)
	
	spawn_container.shuffle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_spawn_timer_timeout() -> void:
	#ObjectManager.create_enemy(GameManager.ENEMY_TYPE.SKINNY, Vector2(100, 100))
	print_debug(spawn_container.pick_random().global_position)
	ObjectManager.create_enemy(GameManager.ENEMY_TYPE.SKINNY, spawn_container.pick_random().global_position)
