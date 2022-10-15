extends Area2D
func _on_vida_extra_body_entered(body):
	Global.vida += 1
	$Sprite.visible = false
func _on_itemfx_finished():
	self.queue_free()
