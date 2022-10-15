extends Area2D
func _on_coletavel_body_entered(body):
	Global.points += 1
	$Sprite.visible = false
	$itemfx.play()
	
func _on_itemfx_finished():
	self.queue_free()
	
func _process(delta):
	$itemfx.volume_db = GlobalOpcoes.controlSFX(0,-50)
