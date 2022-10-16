extends Node2D
onready var timer = $Timer
onready var respawn_timer = $Respawn
var velocity = Vector2.ZERO
var gravity = 30000
var is_triggered = false
var respawn_position
func _ready():
	set_physics_process(false)
	
func _physics_process(delta):
	velocity.y = gravity * delta
	position += velocity * delta
	
func collide_with(collision: KinematicCollision2D, collider: KinematicBody2D):
	if !is_triggered:
		is_triggered = true
		velocity = Vector2.ZERO
		timer.start()
		respawn_position = self.position
		
func _on_Timer_timeout():
	$instableblockfx.play()
	set_physics_process(true)
	respawn_timer.start()
	
func _on_Respawn_timeout():
	set_physics_process(false)
	self.position  = respawn_position
	is_triggered = false
