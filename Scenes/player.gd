extends Node3D

signal state_entered(state: String)
signal close_window
signal flashed

var state_machine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine = $StateMachine
	state_machine.Start()

func _process(delta: float) -> void:
	state_machine.Update(delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	state_machine.PhysicsUpdate(delta)
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

func get_handheld() -> Node3D:
	return $Handheld

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

func begin_death():
	GlobalVariables.is_playing = false
	GlobalVariables.has_handheld = false
	$Handheld.transform = $HandheldMarkers/Table.transform
	state_machine.change_to_state("dying")
	
func begin_punish():
	pass
	#$Handheld.transform = $HandheldMarkers/Table.transform
	#state_machine.change_to_state("dying")

func reset_to_forward():
	state_machine.change_to_state("forward")

func _on_state_machine_state_entered(state:  String) -> void:
	state_entered.emit(state)
	$StateMachine/Moving.current_state = state

func _on_handheld_flashed() -> void:
	flashed.emit()
