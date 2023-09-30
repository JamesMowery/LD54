extends Node
class_name HealthComponent

@export var health_max: float = 100.0
@export var current_health: float = 80.0


func get_health_max() -> float:
	return health_max

func get_health() -> float:
	return current_health

func reduce_health(amount: float) -> void:
	current_health -= amount

func add_health(amount: float) -> void:
	current_health += amount
