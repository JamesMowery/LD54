extends Node
class_name HealthComponent

@export var entity: Node2D

@export var health_max: float = 100.0
@export var current_health: float = 80.0

func get_health_max() -> float:
	return health_max

func get_health() -> float:
	return current_health

func reduce_health(amount: float) -> void:
	current_health -= amount
	SignalManager.on_health_update.emit()
	check_death()
	
func add_health(amount: float) -> void:
	current_health += amount
	SignalManager.on_health_update.emit()
	
func check_death() -> void:
	if current_health <= 0:
		SignalManager.on_enemy_death.emit(entity)
		get_parent().queue_free()
