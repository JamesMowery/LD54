extends StaticBody2D

@onready var spawn_timer = $SpawnTimer
@onready var health_component = $"../HealthComponent"

var _spawn_rate: float = 100.0
var _health: float = 100.0
var _enemies: Array = []
var _next_enemy_to_spawn: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Randomize an array full of the different enemy types and return it
func _randomize_next_enemy() -> void:
	pass

# Spawn the next enemy
func spawn() -> void:
	# randomize
	# get the next enemy from the array
	# instantiate it
	pass

# On enemy attack hitbox shown & entered
func _on_body_entered(body):
	pass # Replace with function body.

# On enemy attack hitbox shown & entered
func _on_area_entered(area):
	pass # Replace with function body.

# Spawn enemy when timer times out
func _on_spawn_timer_timeout():
	spawn()
	pass # Replace with function body.
