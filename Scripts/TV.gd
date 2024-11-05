extends Node3D


var loaded: RigidBody3D
var justLoaded: bool
@onready var sub_viewport: SubViewport = $MeshInstance3D/SubViewport
@onready var video_stream_player: VideoStreamPlayer = $MeshInstance3D/SubViewport/VideoStreamPlayer
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

#var timer: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if loaded and loaded.freeze:
		sub_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
		loaded.global_transform = $"Activation Module".global_transform
		#loaded.global_position = get_node('Activation Module').global_position + Vector3(0,0,0)
		#loaded.global_position = get_node('Activation Module').global_position + Vector3(0,0,0)
		#loaded.rotation = Vector3(deg_to_rad(270),deg_to_rad(180),deg_to_rad(180))

		#var texture: Texture2D = loaded.get_meta('data')
		
		#print_debug(timer)
		#timer -= 1
	else:
		if loaded:
			loaded.freeze = false
		sub_viewport.render_target_update_mode = SubViewport.UPDATE_DISABLED
		video_stream_player.stop()
		audio_stream_player_3d.stream = null
		audio_stream_player_3d.playing = false
		print('removed')
		loaded = null
		pass
		#projector.light_projector = null
		

func activated() -> void:
	var cart:RigidBody3D = get_node("Activation Module").lastBody
	#print_debug(timer)
	if cart.has_meta('held') and not cart.get_meta('held'):
		loaded = cart
		#timer = 5
		if not loaded.sleeping: #not video_stream_player.is_playing() or not audio_stream_player_3d.playing:
			
			
			
			loaded.freeze = true
			
			if loaded.has_meta('audioData'):
				print_debug('Audio used')
				audio_stream_player_3d.stream = loaded.get_meta('audioData')
				audio_stream_player_3d.play()
			else:
				video_stream_player.stream = (cart.get_meta('data'))
				video_stream_player.play()
				print_debug('TV used')
		else:
			pass
		
		loaded = cart
		
