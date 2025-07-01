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


func _on_player_close_window() -> void:
	$Window.close_window()


func _on_bed_monster_killing_player() -> void:
	player.begin_death()


func _on_player_flashed() -> void:
	$BedMonster.reset_to_idle()


func _on_window_monster_killing_player() -> void:
	player.begin_death()


func _on_window_monster_killed_player() -> void:
	print("you died")
	$WindowMonster.reset_to_idle()
	player.reset_to_forward()


func _on_bed_monster_killed_player() -> void:
	print("you died")
	$BedMonster.reset_to_idle()
	player.reset_to_forward()
