extends RoomState
class_name TableState

# go to bed
func go_right():
	transitioned.emit(self, "forward")

# pickup/placedown handheld
func go_down():
	pass
