extends Node
class_name EnemyMovement

@export var enemy: Node2D
@export var animation: Node2D
@export var movement_speed: float = 100.0

@export var random_target: bool = true
@export var target_player_pct: float = 70
@export var face_player: bool = true
@export var move_to_target: bool = true 

@onready var attack_box: Area2D = $"../EnemyBase/AttackBox"

var _target = GameManager.ENEMY_TARGET.POND
var _target_position = Vector2.ZERO
var _current_facing = Vector2.DOWN
var _is_moving: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_target = randomize_target(target_player_pct)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	enemy.velocity = Vector2.ZERO
	
	if !_is_moving:
		return
	
	if face_player:
		_current_facing = face_to_target(enemy.velocity, _target_position)
		update_rotation(_current_facing)
	
	if _target == GameManager.ENEMY_TARGET.POND:
		_target_position = direction_to_pond(get_pond_position())
	else:
		_target_position = direction_to_pond(get_player_position())
		
	if move_to_target:
		move_towards_target(_target_position)
	
	#print_debug(_target_position)
	#print_debug(_current_facing)

# Movement
################################################################################

func move_towards_target(target_pos: Vector2) -> void:
	enemy.velocity = target_pos.normalized() * movement_speed
	
func direction_to_player(global_player_pos) -> Vector2:
	return global_player_pos - enemy.global_position

func direction_to_pond(global_pond_pos) -> Vector2:
	return global_pond_pos - enemy.global_position

func switch_is_moving(is_moving: bool) -> bool:
	if is_moving:
		return false
	else:
		return true

# Facing
################################################################################

func face_to_target(current_facing: Vector2, target_pos: Vector2) -> Vector2:
	if !face_player:
		return current_facing
	
	if target_pos.y > 0 and absf(target_pos.y) > absf(target_pos.x):
		return Vector2.DOWN
	if target_pos.y < 0 and absf(target_pos.y) > absf(target_pos.x):
		return Vector2.UP
	if target_pos.x < 0 and absf(target_pos.x) > absf(target_pos.y):
		return Vector2.LEFT
	if target_pos.x > 0 and absf(target_pos.x) > absf(target_pos.y):
		return Vector2.RIGHT
	
	print_debug("Facing Error")
	return current_facing
	
func update_rotation(current_facing: Vector2) -> void:
	match current_facing:
		Vector2.DOWN:
			attack_box.rotation_degrees = 0
			animation.play("walk_down")
		Vector2.UP:
			attack_box.rotation_degrees = 180
			animation.play("walk_up")
		Vector2.LEFT:
			attack_box.rotation_degrees = 90
			animation.play("walk_left")
		Vector2.RIGHT:
			attack_box.rotation_degrees = 270
			animation.play("walk_right")

# Positioning
################################################################################

func get_pond_position() -> Vector2:
	if !get_tree().get_first_node_in_group("pond"):
		return enemy.global_position
	
	return get_tree().get_first_node_in_group("pond").global_position

func get_player_position() -> Vector2:
	if !get_tree().get_first_node_in_group("player"):
		return enemy.global_position

	return get_tree().get_first_node_in_group("player").global_position

# Targeting
################################################################################

func randomize_target(player_pct: float) -> GameManager.ENEMY_TARGET:
	var rng = randi_range(0, 99)
	
	if rng <= player_pct:
		return GameManager.ENEMY_TARGET.PLAYER
	else: 
		return GameManager.ENEMY_TARGET.POND

func set_target(new_target: GameManager.ENEMY_TARGET) -> void:
	_target = new_target

func switch_target(current_target: GameManager.ENEMY_TARGET) -> GameManager.ENEMY_TARGET:
	if current_target == GameManager.ENEMY_TARGET.POND:
		return GameManager.ENEMY_TARGET.PLAYER
	else:
		return GameManager.ENEMY_TARGET.POND
