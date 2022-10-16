extends Area2D
func _on_vida_extra_body_entered(body):
	Global.vida += 1
	$Sprite.visible = false
	self.queue_free()
