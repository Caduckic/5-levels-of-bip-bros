extends RoomState
class_name TableState

var has_handheld: bool = false

# go to bed
func go_right():
	transitioned.emit(self, "forward")

# pickup/placedown handheld
func go_down():
	pass

func action():
	if !GlobalVariables.has_handheld:
		handheld_maker = $"../../HandheldMarkers/TablePickedUp"
		GlobalVariables.has_handheld = true
		has_handheld = true
		transitioned.emit(self, "table")
	else:
		handheld_maker = $"../../HandheldMarkers/Table"
		has_handheld = false
		transitioned.emit(self, "table")
