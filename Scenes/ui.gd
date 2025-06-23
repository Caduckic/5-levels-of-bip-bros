extends Control

signal button_pressed

enum {UI_UP = 0, UI_DOWN, UI_LEFT, UI_RIGHT, UI_ACT}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_left_pressed() -> void:
	button_pressed.emit(UI_LEFT)


func _on_right_pressed() -> void:
	button_pressed.emit(UI_RIGHT)


func _on_down_pressed() -> void:
	button_pressed.emit(UI_DOWN)


func _on_up_pressed() -> void:
	button_pressed.emit(UI_UP)


func _on_action_pressed() -> void:
	button_pressed.emit(UI_ACT)
