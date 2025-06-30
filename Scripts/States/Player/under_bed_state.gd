extends RoomState
class_name UnderBedState

var begin_flash: bool = false

# go to bed
func go_right():
	transitioned.emit(self, "forward")

# go to bed
func go_up():
	transitioned.emit(self, "forward")

# flash light
func action():
	if GlobalVariables.has_handheld:
		begin_flash = true
		handheld_maker = $"../../HandheldMarkers/Flash"
		transitioned.emit(self, "underbed")
