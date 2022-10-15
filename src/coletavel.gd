extends Area2D
func _on_coletavel_body_entered(body):
	Global.points += 1
	$Sprite.visible = false
	body.play_song("coletavel")
	self.queue_free()
