extends Node2D


var velocity = Vector2.ZERO
var gravity = 720

func _physics_process(delta):
	velocity.y = gravity * delta
	position += velocity * delta
