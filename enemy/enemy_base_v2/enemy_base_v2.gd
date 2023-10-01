extends CharacterBody2D
class_name EnemyBase2

@export var _attack_damage: float = 20.0
@export var _point_value: float = 100.0

@onready var attack_timeout: Timer = $AttackTimeout
@onready var health_component: HealthComponent = $"../HealthComponent"
@onready var enemy_movement_component: EnemyMovement = $"../EnemyMovementComponent"
@onready var attack_box: Area2D = $AttackBox

var _is_attacking: bool = false
var _in_attack_area: bool = false
var _current_target: GameManager.ENEMY_TARGET
var _needs_rotation: bool = false

func _ready() -> void:
	SignalManager.on_enemy_entered_pond.connect(on_enemy_entered_pond)
	SignalManager.on_damage_to_enemy.connect(on_damage_to_enemy)
	SignalManager.on_enemy_death.connect(on_enemy_death)
	attack_box.hide()
	
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()

# Attacking
################################################################################
func check_attack() -> void:
	if !_in_attack_area:
		return
	
	attack()

func attack() -> void:
	if !_is_attacking or !_in_attack_area:
		return
	
	_is_attacking = false
	if _current_target == GameManager.ENEMY_TARGET.PLAYER:
		SignalManager.on_damage_to_player.emit(_attack_damage)
	if _current_target == GameManager.ENEMY_TARGET.POND:
		SignalManager.on_damage_to_pond.emit(_attack_damage)

	attack_box.hide()
	attack_timeout.start()
	
# Taking Damage
################################################################################

func take_damage(dmg: float) -> void:
	health_component.reduce_health(dmg)

# Custom Signals
################################################################################

func on_enemy_entered_pond() -> void:
	enemy_movement_component.is_moving = false
	enemy_movement_component.switch_target(GameManager.ENEMY_TARGET.POND)
	
func on_damage_to_enemy(enemy: Node2D, damage: float) -> void:
	if enemy == self:
		take_damage(damage)
		
func on_enemy_death(enemy: Node2D) -> void:
	if enemy == self:
		GameManager.add_points(_point_value)
		get_parent().queue_free()

# Node Signals
################################################################################

func _on_attack_timeout_timeout() -> void:
	attack_box.show()
	_is_attacking = true
	check_attack()

func _on_screen_entered() -> void:
	pass # Replace with function body.

func _on_screen_exited() -> void:
	pass # Replace with function body.

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("pond"):
		enemy_movement_component._is_moving = false
		_current_target = GameManager.ENEMY_TARGET.POND

func _on_attack_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		_current_target = GameManager.ENEMY_TARGET.PLAYER
	if area.is_in_group("pond"):
		_current_target = GameManager.ENEMY_TARGET.POND

	_in_attack_area = true
	check_attack()

func _on_attack_box_area_exited(area: Area2D) -> void:
	_in_attack_area = false
