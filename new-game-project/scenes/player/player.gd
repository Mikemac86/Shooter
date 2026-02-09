extends CharacterBody2D


signal laser(pos, player_direction)
signal grenade(pos, player_direction)


var player_speed : int = 500 
var can_laser : bool = true
var can_grenade : bool = true
var can_sprint : bool = true




func _process(_delta):
	
	#input
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * player_speed
	move_and_slide()
	Globals.player_pos = global_position
	# rotate player
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)


	if Input.is_action_pressed("primary_action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		
		# randomly select a marker2D for the laser to start
		var laser_markers = $LaserStartPosition.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		var pos = selected_laser.global_position
		var fire_dir = (get_global_mouse_position() - pos).normalized()
		
		$GPUParticles2D.emitting = true

		
		# code to make the laser spawn at the gun and move in the direction you are facing
		
		
		can_laser = false
		$LaserTimer.start()
		#emit the position we selected
		laser.emit(pos, fire_dir)

		
	if Input.is_action_pressed("secondary_action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		
		var pos = $LaserStartPosition.get_children()[0].global_position
		var grenade_dir = (get_global_mouse_position() - pos).normalized()
		can_grenade = false
		$GrenadeTimer.start()
		grenade.emit(pos, grenade_dir)


	if Input.is_action_pressed("Sprint") and can_sprint:
		player_speed = 1000
		
	if Input.is_action_just_released("Sprint"):
		player_speed = 500


func hit():
	Globals.player_health -= 5
	$PlayerImage.material.set_shader_parameter("progress", 1)
	$HitTimer.start()

func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
	


	


func _on_hit_timer_timeout() -> void:
	$PlayerImage.material.set_shader_parameter("progress", 0)
