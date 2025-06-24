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

# begin handheld game
func go_up():
	pass
	#transitioned.emit(self, "play")
