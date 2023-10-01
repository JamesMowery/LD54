extends Sprite2D

@export var health_component: HealthComponent
@export var entity_reference: Node2D
@export var x_offset: float = 0.0
@export var y_offset: float = 0.0

@onready var health_bar_label = $HealthBarLabel

func _ready():
	SignalManager.on_health_update.connect(on_health_update)
	update_health()

func _process(delta):
	global_position.x = entity_reference.global_position.x + x_offset
	global_position.y = entity_reference.global_position.y + y_offset

func update_health() -> void:
	health_bar_label.text = str(health_component.get_health()) + " / " + str(health_component.get_health_max())

func on_health_update() -> void:
	update_health()
	GameManager.check_game_over(health_component.get_health())
