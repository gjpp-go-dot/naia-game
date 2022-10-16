extends Area2D

func _on_arma_body_entered(body):
	if Global.attack == true:
		if body.name.begins_with("adversario"):
			body.morrer()
