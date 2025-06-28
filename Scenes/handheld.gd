extends Node3D

@export var duration: float

func _process(_delta: float) -> void:
	var screen_mat: StandardMaterial3D = $Hinge/Lid/Screen.get_surface_override_material(0)
	screen_mat.albedo_texture = $Test2D.get_sub_viewport_texture()

func flash_light():
	$Hinge/Lid/Flash.light_energy = 1.0
	var tween = create_tween()
	#tween.tween_property($Hinge/Lid/Flash, "light_energy", 1.0, duration/2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($Hinge/Lid/Flash, "light_energy", 0.0, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.connect("finished", _flash_light_finished)
	tween.play()
	
func _flash_light_finished():
	pass
