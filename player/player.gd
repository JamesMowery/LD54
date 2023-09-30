extends CharacterBody2D

var _move_speed: float = 100.0
var _boost_factor: float = 2.5

var _boost_amount: float = 100.0
var _move_direction: Vector2 = Vector2.ZERO
var _is_boosting: bool = false

#var _health: float = 100.0

var _current_terrain: GameManager.TERRAIN

# Called when the node enters the scene tree for the first time.
func _ready():
	_current_terrain = GameManager.TERRAIN.WATER

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	velocity = Vector2.ZERO
	
	get_input(delta)
	move_and_slide()

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

"""
func check_terrain() -> void:
	if _current_terrain == GameManager.TERRAIN.WATER:
		velocity *= 
	if _current_terrain == GameManager.TERRAIN.LAND:
		pass
"""
