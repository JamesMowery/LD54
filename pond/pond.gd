extends Area2D

@onready var health_drop_timer = $HealthRegenDropTimer

var _health: float = 100.0
var _health_regen: float = 100.0
var _health_drop_timer: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Reduce pond health & reduce drop rate
func on_hit_by_enemy() -> void:
	pass

# Improve pond health
func on_wave_passed() -> void:
	pass

# When player enters pond
func _on_body_entered(body):
	if body.is_in_group("player"):
		print_debug("Player Entered Pond")
		body.set_terrain(GameManager.TERRAIN.WATER)
	if body.is_in_group("enemy"):
		print_debug("Enemy Entered Pond")
		body.switch_target(GameManager.ENEMY_TARGET.POND)

# When player exits pond
func _on_body_exited(body):
	if body.is_in_group("player"):
		print_debug("Player Exited Pond")
		body.set_terrain(GameManager.TERRAIN.LAND)

# When enemy enters pond
func _on_area_entered(area):
	#print_debug("(Area) Entered Pond")
	if area.is_in_group("enemy"):
		area.get_parent().switch_target(GameManager.ENEMY_TARGET.POND)
		
		#area.switch_target(GameManager.ENEMY_TARGET.POND)
		#SignalManager.on_enemy_entered_pond.emit()
		#print_debug("Enemy Entered Pond")
	
# When enemy exits pond (maybe not needed)
func _on_area_exited(area):
	pass # Replace with function body.

# When health drop elapses
func _on_timer_timeout():
	pass # Replace with function body.
