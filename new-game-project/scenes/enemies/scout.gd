extends CharacterBody2D


var player_nearby : bool = false
var can_laser : bool = true
var right_gun_use : bool = true
var health : int = 30
var can_take_dmg = true

signal laser(pos,direction)

	
	
	
func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var marker_node = $LaserSpawnPositions.get_child(right_gun_use)
			right_gun_use = not right_gun_use
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_pos - pos).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$Timers/LaserCooldown.start()
	



func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true


func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false


func _on_laser_cooldown_timeout() -> void:
	can_laser = true


func hit():
	if can_take_dmg:
		health -= 10
		can_take_dmg = false
		$Timers/Timer.start()
		$Sprite2D.material.set_shader_parameter("progress", 1)
		$Timers/FlashTimer.start()
		
	if health <= 0:
		queue_free()
		
		



func _on_timer_timeout() -> void:
	can_take_dmg = true
	


func _on_flash_timer_timeout() -> void:
	$Sprite2D.material.set_shader_parameter("progress", 0)
