extends LevelParent






func _on_area_2d_area_entered(_area):
	var tween = create_tween()
	tween.tween_property($Player, "player_speed", 0,.5)
	TransitionLayer.change_scene("res://scenes/levels/outside.tscn")
