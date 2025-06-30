extends State
class_name DyingState

@export var camera: Camera3D
@export var forward_marker: Marker3D

func Enter():
	camera.transform = forward_marker.transform
