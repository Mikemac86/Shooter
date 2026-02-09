extends Node2D
class_name LevelParent

#var grenade_speed : int = 100

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://items/item.tscn")







func _ready():
	
	for scout in get_tree().get_nodes_in_group("Enemies"):
		scout.connect("laser", Callable(self, "_on_scout_laser"))

	# Connect containers
	for container in get_tree().get_nodes_in_group("Containers"):
		container.connect("open", _on_container_opened)

	# Connect scouts
	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect("laser", Callable(self, "_on_player_laser"))




func _on_scout_laser(pos, direction):
	create_laser(pos,direction)
	


func create_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) - 90
	laser.direction = direction
	$Projectiles.add_child(laser)
	
	
	
	
	
func _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
	item.global_position = pos
	item.direction = direction
	$Items.call_deferred("add_child", item)
	

func _on_player_laser(pos, direction):
	create_laser(pos,direction)
	$UI.update_laser_text()



func _on_player_grenade(pos, player_direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = player_direction * grenade.speed
	$Projectiles.add_child(grenade)
	$UI.update_grenade_text()
