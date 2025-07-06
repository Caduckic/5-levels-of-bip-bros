extends State
class_name  MovingState

@export var camera: Camera3D
@export var handheld: Node3D
@export var duration: float = 1.0

var next_state: RoomState
var current_state: String

func Enter():
	var tween = create_tween()
	tween.tween_property(camera, "global_position", next_state.camera_marker.global_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel()
	tween.tween_property(camera, "rotation", next_state.camera_marker.global_rotation, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	if GlobalVariables.has_handheld:
		tween.parallel()
		tween.tween_property(handheld, "global_position", next_state.handheld_maker.global_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.parallel()
		tween.tween_property(handheld, "rotation", next_state.handheld_maker.global_rotation, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.connect("finished", _on_tween_finished)
	tween.play()

func _on_tween_finished():
	if current_state.to_lower() == "dying":
		return
	if next_state is TableState and !next_state.has_handheld:
		GlobalVariables.has_handheld = false
		
	if next_state is UnderBedState and next_state.begin_flash:
		next_state.begin_flash = false
		next_state.handheld_maker = $"../../HandheldMarkers/UnderBed"
		handheld.flash_light()
		transitioned.emit($"../UnderBed", "underbed")
	else:
		transitioned.emit(self, next_state.name)
