extends KinematicBody2D


onready var platform_timer = $platform_timer


func collide_with(collision: KinematicCollision2D, collider: KinematicBody2D):
	if Input.is_action_pressed('ui_down'):
		$CollisionShape2D.disabled = true
		$platformfx.play()
		platform_timer.start()


func _on_platform_timer_timeout():
	$CollisionShape2D.disabled = false

func _process(delta):
	$platformfx.volume_db = GlobalOpcoes.controlSFX(-5,40)
