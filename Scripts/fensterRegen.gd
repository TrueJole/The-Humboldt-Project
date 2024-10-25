extends Node3D


@export var rainIndex: int
func _ready() -> void:
	var mesh: MeshInstance3D = MeshInstance3D.new()
	#mesh.set_surface_override_material(rainIndex, StandardMaterial3D.new())
	mesh = $Mesh
	mesh.get_surface_override_material(rainIndex).albedo_texture = Root.rainTexture
