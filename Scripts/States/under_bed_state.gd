extends RoomState
class_name UnderBedState

# go to bed
func go_right():
	transitioned.emit(self, "forward")

# flash light
func go_down():
	pass

# go to bed
func go_up():
	transitioned.emit(self, "forward")
