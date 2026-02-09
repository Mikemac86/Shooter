extends Node

signal stat_change

var player_pos : Vector2 
var player_vunerable : bool = true
var max_health : int = 100
var max_stamina : int = 100

var laser_amount = 20:
	set(value):
		laser_amount = value
		stat_change.emit()
var grenade_amount = 5:
	set(value):
		grenade_amount = value
		stat_change.emit()
		
var stamina_amount = 100:
		set(value):
			stamina_amount = value
			stat_change.emit()
var player_health = 60: 
	set(value):
		if value > player_health:
			player_health = min(value, max_health)
		else:
			if player_vunerable:
				player_health = value
				player_vunerable = false
				player_invulnerable_timer()
		stat_change.emit()






func player_invulnerable_timer():
	await get_tree().create_timer(.5).timeout
	player_vunerable = true
