extends RoomState
class_name ForwardState

# go to window
func go_right():
	transitioned.emit(self, "window")

# go to table
func go_left():
	transitioned.emit(self, "table")

# go to under bed
func go_down():
	transitioned.emit(self, "underbed")

# do nothing
func go_up():
	pass

# begin handheld game
func action():
	if GlobalVariables.has_handheld:
		transitioned.emit(self, "play")
