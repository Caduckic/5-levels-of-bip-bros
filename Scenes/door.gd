extends Node3D

@export var move_duration: float
var is_open: bool = false

var opening_angle: float = -95
var _rotation_y: float = 0.0

func _process(_delta: float) -> void:
	rotation.y = _rotation_y


func open():
	if not is_open:
		var tween = create_tween()
		tween.tween_property(self, "_rotation_y", deg_to_rad(opening_angle), move_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.connect("finished", _on_open_finished)
		tween.play()

func close():
	if is_open:
		var tween = create_tween()
		tween.tween_property(self, "_rotation_y", deg_to_rad(0), move_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.connect("finished", _on_close_finished)
		tween.play()

func _on_open_finished():
	is_open = true

func _on_close_finished():
	is_open = false
