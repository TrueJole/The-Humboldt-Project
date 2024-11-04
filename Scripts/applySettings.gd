extends Node3D

@onready var WEnvironment:Resource =  $WorldEnvironment.environment
@onready var bakedVoxelGI: VoxelGI = $VoxelGI


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), lerpf(-12, 20, Root.Settings.soundlevel / 100.0))
	if Root.Settings.soundlevel == 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
	
	WEnvironment.ssao_enabled = Root.Settings.ssao
	WEnvironment.volumetric_fog_enabled = Root.Settings.volumetricFog
	WEnvironment.ssr_enabled = Root.Settings.ssr
	WEnvironment.ssao_enabled = Root.Settings.ssao
	#WEnvironment.ssil_enabled = Root.Settings.ssil
	WEnvironment.tonemap_exposure = Root.Settings.exposure

	if Root.Settings.msaa == true:
		RenderingServer.viewport_set_msaa_3d(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_2X)
		RenderingServer.viewport_set_screen_space_aa(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_SCREEN_SPACE_AA_DISABLED)
	else:
		RenderingServer.viewport_set_msaa_3d(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_DISABLED)
		RenderingServer.viewport_set_screen_space_aa(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_SCREEN_SPACE_AA_FXAA)
	#
	RenderingServer.directional_shadow_atlas_set_size(2**Root.Settings.shadowPower, true)
	get_viewport().positional_shadow_atlas_size = 2**(Root.Settings.shadowPower-2)
	RenderingServer.gi_set_use_half_resolution(false)
	RenderingServer.voxel_gi_set_quality(RenderingServer.VOXEL_GI_QUALITY_LOW)
	bakedVoxelGI.subdiv = bakedVoxelGI.SUBDIV_64
	match Root.Settings.giQuality:
		0:
			bakedVoxelGI.visible = false
			RenderingServer.gi_set_use_half_resolution(true)
		1:
			bakedVoxelGI.visible = true
			RenderingServer.gi_set_use_half_resolution(true)
		2:
			bakedVoxelGI.visible = true
			bakedVoxelGI.subdiv = bakedVoxelGI.SUBDIV_128
		3:
			bakedVoxelGI.visible = true
			bakedVoxelGI.subdiv = bakedVoxelGI.SUBDIV_256
			RenderingServer.voxel_gi_set_quality(RenderingServer.VOXEL_GI_QUALITY_HIGH)
	
	get_tree().root.scaling_3d_scale = Root.Settings.scale3D
	
	# ENABLE WIREFRAME MODE #4 - Wireframe
	#get_tree().root.debug_draw = 19#24#4
	
