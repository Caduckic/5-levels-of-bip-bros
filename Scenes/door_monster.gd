extends Node

@export var is_on: bool = false
@export var door: Node3D
@export var parent: Node3D
var state_machine

signal killed_player
signal killing_player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine = find_child("StateMachine")
	if state_machine and is_on:
		state_machine.Start()
	if door:
		$StateMachine/Kill.door = door


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_on:
		state_machine.Update(delta)

func _physics_process(delta: float) -> void:
	if is_on:
		state_machine.PhysicsUpdate(delta)

func reset_to_idle():
	$StateMachine/Ready.kill_timer.stop()
	state_machine.change_to_state("idle")

func add_time_until_knock(duration: float):
	$StateMachine/Idle.idle_timer.wait_time += duration

func _on_state_machine_state_entered(state:  String) -> void:
	if state.to_lower() == "idle":
		$Mesh.visible = false
	elif state.to_lower() == "ready":
		var parent_time_offset: float = $StateMachine/Ready.kill_duration + $StateMachine/Kill.wait_at_door_durtation + randf_range(4.0, 10.0)
		parent.add_time_until_knock(parent_time_offset)
		$Mesh.visible = true
	elif state.to_lower() == "kill":
		$KillTimer.stop()
		$Mesh.visible = true


func _on_kill_killed_player() -> void:
	killed_player.emit()


func _on_kill_killing_player() -> void:
	killing_player.emit()
