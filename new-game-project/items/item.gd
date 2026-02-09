extends Area2D

var rotation_speed = 5
var available_options = ["health", "laser","laser", "laser", "grenade"]
var type = available_options [randi()%len(available_options)]

var direction : Vector2 
var distance : int = randi_range(150,200)
var can_be_picked_up = false



func _ready():
	if type == "laser":
		$Sprite2D.modulate = Color(0,0,1)
	if type == "health":
		$Sprite2D.modulate = Color(.5,0,0)
	if type == "grenade":
		$Sprite2D.modulate = Color(0,.5,0)
	can_be_picked_up = true


	var target_pos = position + direction * distance
	var movement_tween = create_tween()
	movement_tween.set_parallel(true)
	movement_tween.tween_property(self, "scale", Vector2(1,1), .3).from(Vector2(0,0))
	movement_tween.tween_property(self, "position", target_pos, .5)


func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(body):
	if body.is_in_group("Player") and can_be_picked_up == true:
		if type == "health":
			Globals.player_health += 10
		if type == "laser":
			Globals.laser_amount += 10
		if type == "grenade":
			Globals.grenade_amount += 3
		queue_free()
