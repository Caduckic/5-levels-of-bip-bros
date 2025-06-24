extends State
abstract class_name RoomState

@export var camera: Camera3D
@export var camera_pos: Marker3D

func Enter():
	camera.transform = camera_pos.transform

func go_right():
	pass

func go_left():
	pass

func go_down():
	pass

func go_up():
	pass
