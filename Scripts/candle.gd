extends StaticBody3D

class_name Candle

@export var lit: bool 
@export var changeable: bool
@onready var omni_light_3d: OmniLight3D = $OmniLight3D
@onready var interactive_component: Area3D = $"Interactive Component"

signal changed

var justLit: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	omni_light_3d.visible = lit


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if changeable:
		$"Interactive Component/CollisionShape3D".disabled = false
	else:
		$"Interactive Component/CollisionShape3D".disabled = true
	
	#print(justLit)
	justLit -= 1
	omni_light_3d.visible = lit
	interactive_component.monitorable = changeable


func _on_interactive_component_pressed() -> void:
	if changeable:
		if justLit < 0:
			lit = not lit
			omni_light_3d.visible = lit
			changed.emit()
		justLit = 3

	
	
	
