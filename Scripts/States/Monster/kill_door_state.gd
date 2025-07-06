extends State
class_name KillDoorState

@export var mesh: MeshInstance3D
@export var doorway_maker: Marker3D
@export var over_player_marker: Marker3D

@export var walk_duration: float
@export var shake_head_duration: float

@export var wait_at_door_timer: Timer
@export var wait_at_door_durtation: float

var kill_success = false
var rotation_y: float = 0.0
var handheld: Node3D
var door: Node3D

signal killing_player
signal killed_player

func Enter():
	door.open()
	wait_at_door_timer.connect("timeout", _on_wait_at_door_timeout)
	wait_at_door_timer.start(wait_at_door_durtation)
	kill_success = false

func PhysicsUpdate(_delta: float):
	if !GlobalVariables.is_playing and door.is_open and !kill_success:
		kill_success = true
		var tween = create_tween()
		tween.tween_property(mesh, "global_position", over_player_marker.global_position, walk_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.parallel()
		tween.tween_property(mesh, "global_rotation", over_player_marker.global_rotation, walk_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		
		tween.connect("finished", _on_tween_finished)
		tween.play()
		
	mesh.rotation.y = rotation_y

func _on_tween_finished():
	killing_player.emit()
	var shake_tween = create_tween()
	shake_tween.tween_property(self, "rotation_y", deg_to_rad(15.0), shake_head_duration/2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	shake_tween.tween_property(self, "rotation_y", -deg_to_rad(15.0), shake_head_duration/2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	shake_tween.tween_property(self, "rotation_y", deg_to_rad(0.0), shake_head_duration/2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	shake_tween.connect("finished", _on_shake_tween_finished)
	shake_tween.play()

func _on_shake_tween_finished():
	door.close()
	$"../../VisibleTimer".start(0.01)
	killed_player.emit()

func _on_wait_at_door_timeout():
	door.close()
	$"../../VisibleTimer".start(1.0)
	transitioned.emit(self, "idle")
