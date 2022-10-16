extends CanvasLayer


func _process(delta):
	$Label.text = "Vidas: " + str(Global.vida)
	$Label2.text = "Coletaveis: " + str(Global.points)
