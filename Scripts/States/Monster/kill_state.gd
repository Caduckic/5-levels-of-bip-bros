extends State
class_name KillState

@export var mesh: MeshInstance3D
@export var over_player_marker: Marker3D

@export var death_duration: float

var kill_success = false
var rotation_z: float = 0.0

signal killed_player

func Enter():
	if kill_success:
		mesh.transform = over_player_marker.transform
		var tween = create_tween()
		tween.tween_property(self, "rotation_z", deg_to_rad(10.0), death_duration/2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "rotation_z", -deg_to_rad(10.0), death_duration/2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		
		tween.connect("finished", _on_tween_finished)
		tween.play()
		kill_success = false
	else:
		transitioned.emit(self, "idle")
	
func _on_tween_finished():
	killed_player.emit()

func Update(_delta: float):
	mesh.rotation.z = rotation_z
