extends CharacterBody2D

var enemy_speed : int = 250
var active : bool = false
var speed : int = 400
var can_take_dmg : bool = true
var health : int = 20
var max_speed : int = 600





func _ready():
	$Explosion.hide()
	$DroneImage.show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("explosion")
			_damage_targets()
	
func hit():
	if can_take_dmg:
		health -= 10
		can_take_dmg = false
		$Timers/HitTimer.start()
		$DroneImage.material.set_shader_parameter("progress", 1)
		$Timers/FlashTimer.start()
	
	if health <= 0:
		speed = 0
		$AnimationPlayer.play("explosion")
		_damage_targets()

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	#var tween = create_tween()
	#tween.tween_property(self, "speed", max_speed, 6)


func _on_hit_timer_timeout() -> void:
	can_take_dmg = true


func _on_flash_timer_timeout() -> void:
	$DroneImage.material.set_shader_parameter("progress", 0)





func _damage_targets():
	var targets = get_tree().get_nodes_in_group("Containers") + get_tree().get_nodes_in_group("Player")
	var explosion_radius : int = 300
	for target in targets:

		if not is_instance_valid(target):
			continue

		if not target.has_method("hit"):
			continue

		var distance = target.global_position.distance_to(global_position)

		if distance <= explosion_radius:
			target.hit()
