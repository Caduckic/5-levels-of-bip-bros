extends Node3D

func _process(_delta: float) -> void:
	var screen_mat: StandardMaterial3D = $Hinge/Lid/Screen.get_surface_override_material(0)
	screen_mat.albedo_texture = $Test2D.get_sub_viewport().get_texture()
