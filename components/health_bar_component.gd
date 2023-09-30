extends Sprite2D

@export var health_component: HealthComponent
@export var entity_reference: CharacterBody2D
@export var x_offset: float = 0.0
@export var y_offset: float = 0.0

@onready var health_bar_label = $HealthBarLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	health_bar_label.text = str(health_component.get_health()) + " / " + str(health_component.get_health_max())
	# Get data from HealthComponent

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x = entity_reference.global_position.x + x_offset
	global_position.y = entity_reference.global_position.y + x_offset
	
	#position.x = entity_reference.position.x# + x_offset
	#position.y = entity_reference.position.y# + y_offset
	#print_debug("x_pos:", position.x)
	#print_debug("y_pos:", position.y)
	#print_debug("x_pos:", global_position.x)
	#print_debug("y_pos:", global_position.y)
	#print_debug(entity_reference.global_position.x)
	#print_debug(entity_reference.global_position.y)
	#print_debug(entity_reference.position.x)
	#print_debug(entity_reference.position.y)
