extends Sprite2D

var speed: float = 300.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.is_playing:
		var direction: Vector2 = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
		global_position += direction * speed * delta
