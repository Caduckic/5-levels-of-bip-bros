extends State
class_name  MovingState

@export var camera: Camera3D
@export var handheld: Node3D
@export var duration: float = 1.0

var nextState: RoomState

func Enter():
	var tween = create_tween()
	tween.tween_property(camera, "global_position", nextState.camera_marker.global_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel()
	tween.tween_property(camera, "rotation", nextState.camera_marker.global_rotation, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	if GlobalVariables.has_handheld:
		tween.parallel()
		tween.tween_property(handheld, "global_position", nextState.handheld_maker.global_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.parallel()
		tween.tween_property(handheld, "rotation", nextState.handheld_maker.global_rotation, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.connect("finished", _on_tween_finished)
	tween.play()

func _on_tween_finished():
	if nextState is TableState and !nextState.has_handheld:
		GlobalVariables.has_handheld = false
		
	if nextState is UnderBedState and nextState.begin_flash:
		nextState.begin_flash = false
		nextState.handheld_maker = $"../../HandheldMarkers/UnderBed"
		handheld.flash_light()
		transitioned.emit($"../UnderBed", "underbed")
	else:
		transitioned.emit(self, nextState.name)
