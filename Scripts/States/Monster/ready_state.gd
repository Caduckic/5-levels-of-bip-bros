extends State
class_name ReadyState

@export var kill_timer: Timer
@export var kill_duration: float

func Enter():
	print("about to kill")
	kill_timer.connect("timeout", _on_kill_timeout)
	kill_timer.start(kill_duration)

func _on_kill_timeout():
	transitioned.emit(self, "kill")
