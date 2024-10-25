extends Node3D

@export var Schalter1: Node3D
@export var Schalter2: Node3D
@export var Schalter3: Node3D
@export var Schalter4: Node3D

@export var TürA: Node3D
@export var TürB: Node3D
@export var TürC: Node3D

var locked: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not locked:
		TürA.locked = Schalter3.state
		TürB.locked = ! (Schalter1.state and Schalter4.state)
		TürC.locked = ! (Schalter2.state and (Schalter3.state and (not Schalter4.state)))
		print(TürA.locked, TürB.locked, TürC.locked)
		if ! TürC.locked:
			locked = true
			##TODO fertig
	
