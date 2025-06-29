extends RoomState
class_name WindowState

# go to bed
func go_left():
	transitioned.emit(self, "forward")

# go to bed
func go_down():
	transitioned.emit(self, "forward")

# close window
func action():
	pass
