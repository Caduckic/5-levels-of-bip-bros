extends Node

@export var is_on: bool = false
@export var player: Node3D
@export var door: Node3D
@export var door_monster: Node3D
var state_machine

signal punished_player
signal punishing_player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine = find_child("StateMachine")
	if state_machine and is_on:
		state_machine.Start()
	if player:
		$StateMachine/Punish.handheld = player.get_handheld()
	if door:
		$StateMachine/Punish.door = door


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_on:
		state_machine.Update(delta)

func _physics_process(delta: float) -> void:
	if is_on:
		state_machine.PhysicsUpdate(delta)

func reset_to_idle():
	$StateMachine/Ready.punish_timer.stop()
	state_machine.change_to_state("idle")

func add_time_until_knock(duration: float):
	$StateMachine/Idle.idle_timer.wait_time += duration

func _on_state_machine_state_entered(state:  String) -> void:
	if state.to_lower() == "idle":
		$Mesh.visible = false
	elif state.to_lower() == "ready":
		$Mesh.visible = true
		var monster_time_offset: float = $StateMachine/Ready.punish_duration + $StateMachine/Punish.wait_at_door_durtation + randf_range(4.0, 10.0)
		door_monster.add_time_until_knock(monster_time_offset)
	elif state.to_lower() == "punish":
		$Mesh.visible = true
		punishing_player.emit()


func _on_punish_punished_player() -> void:
	punished_player.emit()


func _on_visible_timer_timeout() -> void:
	$Mesh.visible = false
