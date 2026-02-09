extends CharacterBody2D

var enemy_speed : int = 250


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# direction
	var direction = Vector2.RIGHT
	
	# velocity
	velocity = direction * enemy_speed
	#move and slide
	move_and_slide()
	
func hit():
	print("damage")
