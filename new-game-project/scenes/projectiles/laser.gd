extends Area2D

@export var speed : int = 2000
var direction : Vector2 = Vector2.UP

func _ready():
	$SelfDestructTimer.start()

func _process(delta: float):
	position += direction * speed * delta


func _on_body_entered(body):
	
	if body.has_method("hit"):
		body.hit()
	queue_free()
	


func _on_self_destruct_timer_timeout():
	queue_free()
	
