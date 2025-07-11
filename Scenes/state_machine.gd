extends Node

signal state_entered(state: String)

@export var initial_state: State

var current_state: State
var states: Dictionary

# Called when the node enters the scene tree for the first time.
func Start() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.Enter()
		current_state = initial_state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func Update(delta: float) -> void:
	if current_state:
		current_state.Update(delta)

func PhysicsUpdate(delta: float) -> void:
	if current_state:
		current_state.PhysicsUpdate(delta)

func on_child_transition(state: State, new_state_name: String):
	#if state != current_state:
		#return
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	if state is MovingState or !has_node("Moving"):
		current_state = new_state
		state_entered.emit(new_state_name)
	else:
		current_state = $Moving
		current_state.next_state = new_state
		state_entered.emit("moving")
		
	current_state.Enter()

func change_to_state(new_state_name: String):
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	current_state = new_state
	state_entered.emit(new_state_name)
	current_state.Enter()

func go_up():
	if current_state is RoomState:
		current_state.go_up()

func go_down():
	if current_state is RoomState:
		current_state.go_down()

func go_left():
	if current_state is RoomState:
		current_state.go_left()

func go_right():
	if current_state is RoomState:
		current_state.go_right()

func action():
	if current_state is RoomState:
		current_state.action()
