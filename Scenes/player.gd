extends Node3D

signal state_entered(state: String)

var state_machine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine = $StateMachine


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("UP"):
		state_machine.go_up()
	if Input.is_action_just_pressed("DOWN"):
		state_machine.go_down()
	if Input.is_action_just_pressed("LEFT"):
		state_machine.go_left()
	if Input.is_action_just_pressed("RIGHT"):
		state_machine.go_right()

func go_up():
	state_machine.go_up()

func go_down():
	state_machine.go_down()

func go_left():
	state_machine.go_left()

func go_right():
	state_machine.go_right()

func action():
	state_machine.action()


func _on_state_machine_state_entered(state:  String) -> void:
	state_entered.emit(state)
