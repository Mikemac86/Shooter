extends RigidBody2D

var speed : int = 300

var explosion_active : bool = false
var explosion_radius : int = 400




func explode():
	explosion_active = true
	$Explosion.visible = true
	$AnimationPlayer.play("Explosion")
	_damage_targets()

#func _process(_delta):
#	if explosion_active:
#		var targets = get_tree().get_nodes_in_group("Containers")
#		for target in targets:
#			var in_range = target.global_position.distance_to(global_position) < explosion_radius
#			if target.has_method("hit") and in_range:
#				target.hit()



func _damage_targets():
	var targets = get_tree().get_nodes_in_group("Containers") + get_tree().get_nodes_in_group("Enemies") + get_tree().get_nodes_in_group("Player")

	for target in targets:

		if not is_instance_valid(target):
			continue

		if not target.has_method("hit"):
			continue

		var distance = target.global_position.distance_to(global_position)

		if distance <= explosion_radius:
			target.hit()
