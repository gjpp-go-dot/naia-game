extends Area2D

func _on_Impulso_body_entered(body):
	Global.trampoline = true
	body.impulso(1.3)
	$impulsefx.play()
