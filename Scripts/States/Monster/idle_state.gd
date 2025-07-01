extends State
class_name IdleState

@export var idle_timer: Timer
@export var idle_duration_min: float
@export var idle_duration_max: float

@export var mesh: MeshInstance3D
@export var idle_marker: Marker3D

func Enter():
	mesh.visible = false
	mesh.transform = idle_marker.transform
	idle_timer.connect("timeout", _on_idle_timeout)
	var idle_time = randf_range(idle_duration_min, idle_duration_max)
	idle_timer.start(idle_time)

func _on_idle_timeout():
	transitioned.emit(self, "ready")
