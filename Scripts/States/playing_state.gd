extends RoomState
class_name PlayingState

func Enter():
	GlobalVariables.is_playing = true
	
func Exit():
	GlobalVariables.is_playing = false

func action():
	GlobalVariables.is_playing = false
	transitioned.emit(self, "forward")
