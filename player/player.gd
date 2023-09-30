extends CharacterBody2D

@onready var health_component = $"../HealthComponent"
@onready var remote_transform_2d = $RemoteTransform2D
@onready var attack_delay: Timer = $AttackDelay
@onready var attack_box: Area2D = $AttackBox

var _move_speed: float = 100.0
var _boost_factor: float = 2.5

var _boost_amount: float = 100.0
var _move_direction: Vector2 = Vector2.ZERO
var _is_boosting: bool = false
var _in_attack_area: bool = false
var _attack_damage: float = 20.0
var _attack_ready: bool = true

var _current_terrain: GameManager.TERRAIN

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_damage_to_player.connect(on_damage_to_player)
	_current_terrain = GameManager.TERRAIN.WATER

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	velocity = Vector2.ZERO
	
	get_input(delta)
	move_and_slide()
	
	remote_transform_2d.global_position = global_position

func get_input(delta):
	if Input.is_action_pressed("move_left"):
		velocity.x = -1 * _move_speed
		rotation_degrees = -90
	if Input.is_action_pressed("move_right"):
		velocity.x = 1 * _move_speed
		rotation_degrees = 90
	if Input.is_action_pressed("move_up"):
		velocity.y = -1 * _move_speed
		rotation_degrees = 0
	if Input.is_action_pressed("move_down"):
		velocity.y = 1 * _move_speed
		rotation_degrees = 180
	
	# Factor In The Terrain Cost
	var movement_cost = GameManager.check_terrain(_current_terrain)
	#print_debug("Movement Cost:", movement_cost)
	velocity *= movement_cost
	
	if Input.is_action_pressed("boost"):
		_is_boosting = true
		velocity *= _boost_factor
	else:
		_is_boosting = false

func set_terrain(terrain: GameManager.TERRAIN) -> void:
	#print_debug("Terrain Type: ", terrain)
	_current_terrain = terrain


func check_attack(enemy: Node2D) -> void:
	if !_in_attack_area:
		return
	
	attack(enemy)

func attack(enemy: Node2D) -> void:
	if !_attack_ready or enemy == null:
		return
	#print_debug("Attacking")
	_attack_ready = false
	attack_box.hide()
	attack_delay.start()
	SignalManager.on_damage_to_enemy.emit(enemy, _attack_damage)

func _on_attack_delay_timeout():
	#print_debug("Attack Timeout")
	_attack_ready = true
	attack_box.show()
	check_attack(null)

func on_damage_to_player(amount: float) -> void:
	#print_debug("Damage Received")
	health_component.reduce_health(amount)

func _on_attack_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		#print_debug("on_attack_box_area_entered")
		_in_attack_area = true
		check_attack(area.get_parent())

func _on_attack_box_area_exited(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		#print_debug("on_attack_box_area_exited")
		_in_attack_area = false

