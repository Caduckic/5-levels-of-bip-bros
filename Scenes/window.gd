extends Node3D

@export var duration_min: float
@export var duration_max: float
@export var open_time: float
@export var is_on: bool = false

var is_open: bool = false
var open_timer_stopped: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(_delta: float) -> void:
	if is_on and not is_open and not open_timer_stopped:
		open_timer_stopped = true
		$Timer.wait_time = randf_range(duration_min, duration_max)
		$Timer.start()

func close_window():
	if is_open:
		var tween = create_tween()
		tween.tween_property($FrameBorder, "global_position", $ClosedMarker.global_position, open_time/2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.connect("finished", _on_close_tween_finish)
		tween.play()

func _on_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property($FrameBorder, "global_position", $OpenMarker.global_position, open_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.connect("finished", _on_open_tween_finish)
	tween.play()

func add_time_until_open(duration: float):
	$Timer.wait_time += duration

func _on_open_tween_finish():
	is_open = true

func _on_close_tween_finish():
	is_open = false
	open_timer_stopped = false
