extends Control

@onready var loadingBar: ProgressBar = $ProgressBar
@export var nextScene: String = "res://Szenen/World.tscn"  #"res://Szenen/Screenshot.tscn"#
@onready var center_container: CenterContainer = $CenterContainer

var loading: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loadingBar.hide()
	$Swirl.hide()
	#RenderingServer.viewport_set_msaa_2d(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_2X)
	pass # Replace with function bosdy.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if loading:
		var progress: Array[float]
		progress.clear()
		ResourceLoader.load_threaded_get_status(nextScene, progress)
		print(progress[0])
		loadingBar.value = min(progress[0] * 100.0, 99)
		if progress[0] == 1:
			
		
			
			get_parent().add_child(ResourceLoader.load_threaded_get(nextScene).instantiate())
		
			RenderingServer.viewport_set_msaa_2d(get_tree().get_root().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_DISABLED)

			get_node("../Preview").free()
			#$"../Preview/Player/Head/Camera3D".current = false
			
			#$"../World/Player/Head/Camera3D".current = true
			
			
			#$"../World/Preview/Player".free()
			
		
			
			$"../World/AnimationPlayer".play('intro')

			queue_free()


func _on_start_button_pressed() -> void:
	if not loading:
		$Swirl.show()
		loading = true
		get_node('OptionsMenu').queue_free()
		loadingBar.show()
		print(ResourceLoader.get_dependencies(nextScene))
		ResourceLoader.load_threaded_request(nextScene, "", false)
		

func _on_exit_button_pressed() -> void:
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()


func _on_options_button_pressed() -> void:
	if not loading:
		center_container.hide()
		get_node('OptionsMenu').show()


func _on_options_menu_done() -> void:
	if not loading:
		center_container.show()
		get_node('OptionsMenu').hide()
		var file: FileAccess = FileAccess.open('user://settings.dat', FileAccess.WRITE)
		file.store_var(Root.Settings, true) 
