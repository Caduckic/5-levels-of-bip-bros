extends Node

@export var is_on: bool = false
var state_machine

signal killed_player
signal killing_player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine = find_child("StateMachine")
	if state_machine and is_on:
		state_machine.Start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_on:
		state_machine.Update(delta)

func _physics_process(delta: float) -> void:
	if is_on:
		state_machine.PhysicsUpdate(delta)


func _on_state_machine_state_entered(state:  String) -> void:
	if state.to_lower() == "idle":
		$Mesh.visible = false
	elif state.to_lower() == "ready":
		$Mesh.visible = true
	elif state.to_lower() == "kill":
		$Mesh.visible = true
		$StateMachine/Kill.kill_success = true
		killing_player.emit()

func reset_to_idle():
	$StateMachine/Ready.kill_timer.stop()
	state_machine.change_to_state("idle")

func _on_kill_killed_player() -> void:
	killed_player.emit()
