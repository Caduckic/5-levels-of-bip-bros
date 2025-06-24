extends Node3D

var player
var ui

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = $Player
	ui = $UI

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_ui_button_pressed(action: String) -> void:
	if action == "up":
		player.go_up()
	if action == "down":
		player.go_down()
	if action == "left":
		player.go_left()
	if action == "right":
		player.go_right()
	if action == "action":
		player.action()


func _on_player_state_entered(state: String) -> void:
	ui.set_ui_room_state(state)
