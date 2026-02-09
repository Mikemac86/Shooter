extends ItemContainer


func hit():
	if !opened:
		$LidSprite.hide()
		var pos = $SpawnPositions/Marker2D2.global_position
		open.emit(pos, current_direction)
		opened = true
