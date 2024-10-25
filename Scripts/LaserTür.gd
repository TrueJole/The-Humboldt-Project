extends Tür

@onready var lasers: Node = $Lasers

func basicDoorFunc() -> void:
	super()

func _process(_delta: float) -> void:
	if locked:
		lasers.show()
	else:
		lasers.hide()

func _physics_process(_delta: float) -> void:
	basicDoorFunc()
