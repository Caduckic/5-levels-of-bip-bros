extends Node3D

signal state_entered(state: String)
signal close_window

var state_machine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine = $StateMachine

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("UP"):
		go_up()
	if Input.is_action_just_pressed("DOWN"):
		go_down()
	if Input.is_action_just_pressed("LEFT"):
		go_left()
	if Input.is_action_just_pressed("RIGHT"):
		go_right()
	if Input.is_action_just_pressed("ACTION"):
		action()

func go_up():
	state_machine.go_up()

func go_down():
	state_machine.go_down()

func go_left():
	state_machine.go_left()

func go_right():
	state_machine.go_right()

func action():
	if state_machine.current_state.name.to_lower() == "window":
			close_window.emit()
	state_machine.action()


func _on_state_machine_state_entered(state:  String) -> void:
	state_entered.emit(state)
