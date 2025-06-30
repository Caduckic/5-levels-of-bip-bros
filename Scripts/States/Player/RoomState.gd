extends State
abstract class_name RoomState

@export var camera: Camera3D
@export var camera_marker: Marker3D
@export var handheld: Node3D
@export var handheld_maker: Marker3D

func Enter():
	camera.transform = camera_marker.transform

func go_right():
	pass

func go_left():
	pass

func go_down():
	pass

func go_up():
	pass

func action():
	pass
