extends State
class_name ReadyPunishState

@export var punish_timer: Timer
@export var punish_duration: float

func Enter():
	print($"../..".name + " about to open door")
	punish_timer.connect("timeout", _on_punish_timeout)
	punish_timer.start(punish_duration)

func _on_punish_timeout():
	transitioned.emit(self, "punish")
