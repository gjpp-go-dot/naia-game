extends CanvasLayer

func _process(delta):
	if Constants.estado == 0:
		$spear0.show()
		$spear1.hide()
		$spear2.hide()
	if Constants.estado == 1:
		$spear1.show()
		$spear2.hide()
		$spear0.hide()
	if Constants.estado == 2:
		$spear2.show()
		$spear1.hide()
		$spear0.hide()
		
