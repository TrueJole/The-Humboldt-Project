class_name Tür
extends Node3D



@onready var door: RigidBody3D = $"Tür"
@onready var audioPlayer: AudioStreamPlayer3D = $AudioStreamPlayer3D
#@onready var occluder: OccluderInstance3D = $"Tür/OccluderInstance3D"

@export var locked: bool
var closed: bool

var closeSound: Resource = load("res://Resources/Sounds/DoorClosedRandom.tres")
var screachSound: Resource = load("res://Resources/Sounds/DoorClosingRandom.tres")

func basicDoorFunc() -> void:
	if locked:
		door.set_collision_layer_value ( 1, true )
		door.set_collision_layer_value ( 2, false )
		door.rotation.y = 0
		door.freeze = true
		closed = true
		
	else:
		#close the door if it is nearly closed
		if snappedf(door.rotation.y, 0.1) == 0 and door.angular_velocity.y < 0.9:
			door.rotation.y = 0
			if not closed:
				door.angular_velocity = Vector3(0,0,0)
				audioPlayer.pitch_scale = 1
				audioPlayer.stream = closeSound
				audioPlayer.play()
			closed = true
			#occluder.show()
		else:
			#occluder.hide()
			audioPlayer.pitch_scale = clampf(lerpf(0.6, 2, door.angular_velocity.y),0.6,2)
			#audioPlayer.pitch_scale = door.angular_velocity.y
			if absf(door.angular_velocity.y) > 0.02 and not audioPlayer.playing and randi_range(0,round(60/clampf(lerpf(0.6, 2, door.angular_velocity.y),0.6,5))) == 0:
				audioPlayer.stream = screachSound
				audioPlayer.pitch_scale = clampf(lerpf(0.6, 2, door.angular_velocity.y),0.6,2)
				audioPlayer.play()
			elif abs(door.angular_velocity.y) <= 0.02:
				pass
				#audioPlayer.stop()
				#print_debug(door.angular_velocity.y)
				
				
			closed = false
			#door.angular_velocity = Vector3(0,0,0)
		door.set_collision_layer_value ( 1, false )
		door.set_collision_layer_value ( 2, true )
		door.freeze = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	basicDoorFunc()
