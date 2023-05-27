extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= delta*200


func _on_seta_body_entered(body):
	if body.name == "water2" or body.name == "Spear":
		self.queue_free()
	elif  body.name == "Naia":
		body.get_node("Naiui/Hud").dano(1)
		self.queue_free()
	else:
		print(body.name)
