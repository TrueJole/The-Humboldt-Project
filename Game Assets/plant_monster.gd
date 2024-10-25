extends StaticBody3D


func _on_activation_module_activated(body: Node3D) -> void:
	$AnimationPlayer.play("killed")
	await $AnimationPlayer.animation_finished
	queue_free()
