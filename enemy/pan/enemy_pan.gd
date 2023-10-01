extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_component: Node = $"../HealthComponent"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pre_attack_delay: Timer = $PreAttackDelay
@onready var attack_cooldown: Timer = $AttackCooldown

enum STATE { IDLE, WALK, ATTACK, PREATTACK, DEAD }

var _current_state: STATE = STATE.WALK
var _current_direction: Vector2 = Vector2.ZERO
var _is_attacking: bool = false
var _can_attack: bool = false

var _move_speed: float = 50.0
var _current_target: GameManager.ENEMY_TARGET

var _player_preference: float = 60.0

func _ready() -> void:
	acquire_target(_player_preference)

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	move_to_target()
	handle_rotation()
	move_and_slide()

func handle_state() -> void:
	if velocity == Vector2.ZERO:
		set_state(STATE.IDLE)

func set_state(new_state: STATE) -> void:
	if new_state == _current_state:
		return
	
	_current_state = new_state
	
	match _current_state:
		STATE.IDLE:
			animated_sprite_2d.play("idle")
		STATE.WALK:
			animated_sprite_2d.play("walk")
		STATE.PREATTACK:
			animated_sprite_2d.play("attack")
			animation_player.play("pre_attack")
		STATE.ATTACK:
			animated_sprite_2d.play("attack")
			attack()
			_is_attacking = false

func attack() -> void:
	pass

func handle_rotation -> void:
	pass
	

func

func move_to_target():
	var target: Vector2
	
	if _current_target == GameManager.ENEMY_TARGET.PLAYER:
		target = get_tree().get_first_node_in_group("player").global_position
	else:
		target = get_tree().get_first_node_in_group("pond").global_position
	
	
	velocity = global_position - target


func acquire_target(player_pct: float) -> void:
	var target: Vector2
	if randf_range(0, 100) < player_pct:
		_current_target = GameManager.ENEMY_TARGET.PLAYER
	else:
		_current_target = GameManager.ENEMY_TARGET.POND


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass
		#_is_attacking = true
		# ATTACK

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_is_attacking = true

func _on_pre_attack_delay_timeout() -> void:
	set_state(STATE.ATTACK)

func _on_attack_cooldown_timeout() -> void:
	_can_attack = true
	attack_cooldown.start()
