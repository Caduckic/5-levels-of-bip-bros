extends Node

@export var is_on: bool = false
@export var window: Node3D

var state_machine

var rotation_z

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
		# to ensure the player doesn't feel cheated if the window opens right as the monster is coming
		window.add_time_until_open($StateMachine/Ready.kill_duration)
		$Mesh.visible = true
		var tween = create_tween()
		tween.tween_property($Mesh, "global_position", $Markers/Window.global_position, $StateMachine/Ready.kill_duration)
		
		tween.connect("finished", _on_run_finish)
		tween.play()
	elif state.to_lower() == "kill":
		$Mesh.visible = true
		if window.is_open:
			$StateMachine/Kill.kill_success = true
			killing_player.emit()

func _on_run_finish():
	pass # TODO add bang noise if window is closed

func reset_to_idle():
	state_machine.change_to_state("idle")

func _on_kill_killed_player() -> void:
	killed_player.emit()
