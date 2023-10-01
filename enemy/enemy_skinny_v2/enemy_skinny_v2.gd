extends EnemyBase2
class_name EnemySkinny

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
