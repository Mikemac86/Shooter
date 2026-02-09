extends CanvasLayer





func _on_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/levels/outside.tscn")




func _on_button_2_pressed() -> void:
	get_tree().quit()
