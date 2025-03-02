extends Node3D
@onready var animation_player: AnimationPlayer = $"AnimationPlayer"
@onready var audioPlayer: AudioStreamPlayer3D = $"AudioStreamPlayer3D"
@onready var particles: GPUParticles3D = $"GPUParticles3D"
@onready var timer: Timer = $Timer
var spülen:bool
signal activated

func _on_timer_timeout() -> void:
	particles.emitting = false
	animation_player.play("SpülenZurück")
	spülen = false


func _on_interactive_component_pressed() -> void:
	
	if animation_player.current_animation == 'SpülenZurück' or spülen == false:
		spülen = true
		animation_player.play("Spülen")
		activated.emit()
	spülen = true
	if not audioPlayer.playing:
		audioPlayer.play()
	timer.start()
	particles.emitting = true
	
	
