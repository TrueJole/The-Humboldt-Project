extends Node

@export var rain: SubViewport = SubViewport.new()
@export var rainTexture: ViewportTexture = ViewportTexture.new()
@export var Settings: SettingsClass = SettingsClass.new()


func _ready() -> void:
	rain = get_node("/root/root/SubViewport")
	rainTexture = rain.get_texture()
	print('Rain: ', rain)

func on_scene_loaded() -> void:
	pass

func default_settings() -> void:
	print('applied default settings')
	Settings.soundlevel = 100
	Settings.ssao = true
	Settings.volumetricFog = true
	Settings.ssr = false
	Settings.ssil = false
	Settings.giQuality = 2
	Settings.msaa = false
	Settings.exposure = 1
	Settings.shadowPower = 10
	Settings.showFPS = false
	Settings.fullscreen = true
	Settings.fpsMode = 1
	Settings.scale3D = 1
	Settings.hiResRain = false
	Settings.mousesens = 0.002

func _init() -> void:
	#DirAccess.remove_absolute('user://settings.tres')
	#default_settings()
	#var file: FileAccess = FileAccess.open('user://settings.dat', FileAccess.WRITE)
	#file.store_var(Settings, true)


	#file.close()
	if FileAccess.file_exists('user://settings.dat'):
		var file: FileAccess = FileAccess.open('user://settings.dat', FileAccess.READ_WRITE)
		
		Settings = file.get_var(true)
		print(Settings)
		print('Loaded Settings')
	else:
		default_settings()
		
		
		
	#else:
	#	file.store_var(Settings)
	#file.close()
