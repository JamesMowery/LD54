extends Area2D

@export var _health_regen: float = 10.0

@onready var health_component: HealthComponent = $"../HealthComponent"
@onready var regen_timer: Timer = $"../RegenTimer"

var _health: float = 100.0

var _regenerating: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_damage_to_pond.connect(on_damage_to_pond)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Reduce pond health & reduce drop rate
func take_damage(dmg: float) -> void:
	health_component.reduce_health(dmg)

# Improve pond health
func on_wave_passed() -> void:
	pass

# Custom Signals
################################################################################

func on_damage_to_pond(dmg):
	print_debug("DAMAGING POND!!!")
	take_damage(dmg)


func regenerate(amt: float) -> void:
	if _regenerating:
		SignalManager.on_player_entered_pond.emit(_health_regen)

# Node Signals
################################################################################

# When player enters pond
func _on_body_entered(body):
	if body.is_in_group("player"):
		_regenerating = false
		regen_timer.start()
		
		#print_debug("Player Entered Pond")
		#body.set_terrain(GameManager.TERRAIN.WATER)
	if body.is_in_group("enemy"):
		pass
		#print_debug("Enemy Entered Pond")
		#body.switch_target(GameManager.ENEMY_TARGET.POND)

# When player exits pond
func _on_body_exited(body):
	if body.is_in_group("player"):
		_regenerating = false
		body.set_terrain(GameManager.TERRAIN.LAND)

# When enemy enters pond
func _on_area_entered(area):
	print_debug("(Area) Entered Pond")
	if area.is_in_group("enemy"):
		pass

func _on_regen_timer_timeout() -> void:
	_regenerating = true
	SignalManager.on_player_entered_pond.emit(_health_regen)
	
