extends Control

const RoomActions = preload("res://Scripts/room_actions.gd")

signal button_pressed(action: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_ui_forward():
	$Control/Up.visible = false
	$Control/Down.visible = true
	$Control/Left.visible = true
	$Control/Right.visible = true
	$Control/Action.visible = true # TODO change if holding handheld

func set_ui_underbed():
	$Control/Up.visible = true
	$Control/Down.visible = false
	$Control/Left.visible = false
	$Control/Right.visible = false
	$Control/Action.visible = true # TODO change if holding handheld
   
func set_ui_window():
	$Control/Up.visible = false
	$Control/Down.visible = true
	$Control/Left.visible = false
	$Control/Right.visible = false
	$Control/Action.visible = true # TODO change if window open

func set_ui_table():
	$Control/Up.visible = false
	$Control/Down.visible = true
	$Control/Left.visible = true
	$Control/Right.visible = true
	$Control/Action.visible = true

func set_ui_moving():
	$Control/Up.visible = false
	$Control/Down.visible = false
	$Control/Left.visible = false
	$Control/Right.visible = false
	$Control/Action.visible = false
	
func set_ui_play():
	$Control/Up.visible = false
	$Control/Down.visible = false
	$Control/Left.visible = false
	$Control/Right.visible = false
	$Control/Action.visible = true

# sets the button layout per state
func set_ui_room_state(state: String):
	if state.to_lower() == "forward":
		set_ui_forward()
	if state.to_lower() == "table":
		set_ui_table()
	if state.to_lower() == "underbed":
		set_ui_underbed()
	if state.to_lower() == "window":
		set_ui_window()
	if state.to_lower() == "moving":
		set_ui_moving()
	if state.to_lower() == "play":
		set_ui_play()

func _on_left_pressed() -> void:
	button_pressed.emit("left")

func _on_right_pressed() -> void:
	button_pressed.emit("right")

func _on_down_pressed() -> void:
	button_pressed.emit("down")

func _on_up_pressed() -> void:
	button_pressed.emit("up")

func _on_action_pressed() -> void:
	button_pressed.emit("action")
