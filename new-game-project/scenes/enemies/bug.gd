extends CharacterBody2D


var active: bool = false
var speed : int = 300


var player_nearby : bool = false
var can_attack : bool = true
var health : int = 20
var can_take_dmg = true


func _process(_delta: float) -> void:
	var direction = (Globals.player_pos - position).normalized()
	velocity = direction * speed
	if active:
		move_and_slide()
		look_at(Globals.player_pos)


func hit():
	if can_take_dmg:
		can_take_dmg = false
		$Particles/HitParticles.emitting = true
		$Timers/HitTimer.start()
		health -= 10
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
		$Timers/FlashTimer.start()
	if health <= 0:
		await get_tree().create_timer(.5).timeout
		queue_free()
	
	
	

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true
	$AnimatedSprite2D.play("attack")

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false







func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	$AnimatedSprite2D.play("walk")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	active = false
	$AnimatedSprite2D.pause()


func _on_animated_sprite_2d_animation_finished() -> void:
	if player_nearby:
		Globals.player_health -= 10
		$Timers/AttackTimer.start()


func _on_attack_timer_timeout() -> void:
	$AnimatedSprite2D.play("attack")


func _on_hit_timer_timeout() -> void:
	can_take_dmg = true
	
	


func _on_flash_timer_timeout() -> void:
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
