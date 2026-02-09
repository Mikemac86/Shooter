extends CharacterBody2D


var active: bool = false
var speed : int = 300


var player_nearby : bool = false
var can_attack : bool = true
var health : int = 30
var can_take_dmg = true


func _process(_delta: float) -> void:
	var direction = (Globals.player_pos - position).normalized()
	velocity = direction * speed
	if active:
		move_and_slide()
		look_at(Globals.player_pos)




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
