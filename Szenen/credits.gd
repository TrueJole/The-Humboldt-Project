extends Control

signal done
func _on_back_button_pressed() -> void:
	hide()
	done.emit()
