extends Node3D

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
