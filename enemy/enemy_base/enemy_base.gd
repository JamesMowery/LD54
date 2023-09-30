extends CharacterBody2D
class_name EnemyBase

@export var move_speed: float = 100.0
@export var _attack_damage: float = 20.0

@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D

var _current_target = GameManager.ENEMY_TARGET.POND
var _attack_strength: float = 20.0
var _is_moving: bool = true
var _player_direction: Vector2

func _ready():
	SignalManager.on_enemy_entered_pond.connect(on_enemy_entered_pond)
	SignalManager.on_damage_to_enemy.connect(on_damage_to_enemy)

func _process(delta):
	pass

func _physics_process(delta):
	velocity = Vector2.ZERO
	move_to_target()
	move_and_slide()
	_player_direction = velocity

# Enemy Attack Player
func attack() -> void:
	pass


func move_to_target() -> void:
	if !_is_moving:
		return
	
	var dir_to_move: Vector2
	
	if _current_target == GameManager.ENEMY_TARGET.PLAYER:
		var player_pos = get_move_to_player()
		#dir_to_move = player_pos - position
		dir_to_move = player_pos - global_position
	else:
		var pond_pos = get_move_to_pond()
		#dir_to_move = pond_pos - position
		dir_to_move = pond_pos - global_position
	
	velocity = dir_to_move.normalized() * move_speed
		
func get_move_to_player() -> Vector2:
	if get_tree().get_first_node_in_group("player") == null:
		return Vector2(0, 0)
	#print_debug("Player Position:", get_tree().get_first_node_in_group("player").global_position)
	return get_tree().get_first_node_in_group("player").global_position

func get_move_to_pond() -> Vector2:
	#print_debug("Pond Position:", get_tree().get_first_node_in_group("pond").global_position)
	return get_tree().get_first_node_in_group("pond").global_position

func switch_is_moving() -> void:
	#print_debug("Is Switching Target")
	
	if _is_moving:
		_is_moving = false
	else:
		_is_moving = true

func switch_target(target: GameManager.ENEMY_TARGET) -> void:
	#if _current_target == GameManager.ENEMY_TARGET.PLAYER:
	switch_is_moving()
	_current_target = target

func randomize_attack_target() -> void:
	var rng = randi_range(1, 100)
	
	if rng >= 30:
		_current_target = GameManager.ENEMY_TARGET.PLAYER
	else: 
		_current_target = GameManager.ENEMY_TARGET.POND

# Apply damage to this enemy
func take_damage(damage) -> void:
	pass

func on_enemy_entered_pond() -> void:
	#print_debug("Enemy Entered Pond")
	_is_moving = false
	switch_target(GameManager.ENEMY_TARGET.POND)

func _on_hurt_box_body_entered(body):
	#print_debug("Enemy Hit (Body)...")
	
	if body.is_in_group("player"):
		print_debug("Enemy Hit By Body")
		#take_damage()

func _on_hurt_box_area_entered(area):
	pass
	#print_debug("Enemy Hit (Area)...")
	
	if area.is_in_group("player"):
		pass
		#print_debug("Enemy Hit By Body")
		#take_damage()

# By Default, Attack
func _on_visible_on_screen_notifier_2d_screen_entered():
	randomize_attack_target()

# Probably Not Needed
func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # Replace with function body.

func on_damage_to_enemy(enemy: Node2D, damage: float) -> void:
	#print_debug("CHECKING ENEMY EQUALITY")
	if enemy == self:
		take_damage(damage)
		
