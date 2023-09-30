extends EnemyBase

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_box = $AttackBox
@onready var attack_delay = $AttackDelay
@onready var health_component = $"../HealthComponent"

var _last_facing: Vector2 = Vector2.ZERO
var _attack_ready: bool = false
var _in_attack_area: bool = false

func _ready():
	super._ready()
	attack_delay.start()

func _process(delta):
	super._process(delta)

func _physics_process(delta):
	super._physics_process(delta)
	get_idle()
	get_direction()

func get_direction() -> void:
	if _player_direction.y > 0 \
 		and absf(_player_direction.y) > absf(_player_direction.x):
		animated_sprite_2d.play("walk_down")
		_last_facing = Vector2.DOWN
		attack_box.rotation_degrees = 0
	if _player_direction.y < 0 \
 		and absf(_player_direction.y) > absf(_player_direction.x):
		animated_sprite_2d.play("walk_up")
		_last_facing = Vector2.UP
		attack_box.rotation_degrees = 180
	if _player_direction.x < 0 \
 		and absf(_player_direction.x) > absf(_player_direction.y):
		animated_sprite_2d.play("walk_left")
		_last_facing = Vector2.LEFT
		attack_box.rotation_degrees = 90
	if _player_direction.x > 0 \
 		and absf(_player_direction.x) > absf(_player_direction.y):
		animated_sprite_2d.play("walk_right")
		_last_facing = Vector2.RIGHT
		attack_box.rotation_degrees = 270

func get_idle() -> void:
	if velocity == Vector2.ZERO:
		match _last_facing:
			Vector2.DOWN:
				animated_sprite_2d.play("idle_down")
			Vector2.UP:
				animated_sprite_2d.play("idle_up")
			Vector2.LEFT:
				animated_sprite_2d.play("idle_left")
			Vector2.RIGHT:
				animated_sprite_2d.play("idle_right")

func check_attack() -> void:
	if !_in_attack_area:
		return
	
	attack()

func attack() -> void:
	if !_attack_ready:
		return
	#print_debug("Attacking")
	_attack_ready = false
	attack_box.hide()
	attack_delay.start()
	SignalManager.on_damage_to_player.emit(_attack_damage)

func take_damage(damage) -> void:
	#print_debug("Enemy Took Damage!")
	health_component.reduce_health(damage)

func _on_attack_delay_timeout():
	#print_debug("Attack Timeout")
	_attack_ready = true
	attack_box.show()
	check_attack()
	
func _on_attack_box_area_entered(area):
	if area.is_in_group("player"):
		_in_attack_area = true
		check_attack()

func _on_attack_box_area_exited(area):
	if area.is_in_group("player"):
		_in_attack_area = false
