extends Node2D

var contador = 0
var tile = ""

func _physics_process(delta):
	$water.position.y -= 0.2

func _on_water_body_entered(body):
	if body.name == "Naia":
		print("glup glup")
		breakpoint

func _on_target_body_entered(body):
	if body.name == "Spear":
		print("alvo atingido")
		contador += 1
		if contador == 1:
			$target.position.x = 997
			$target.position.y = -285
			$tiles1.show()
		elif contador == 2:
			$target.position.x = 410
			$target.position.y = -476
			$tiles2.show()
		elif contador == 3:
			$target.position.x = -296
			$target.position.y = -670
			$tiles3.show()
		elif contador == 4:
			$target.hide()
			print("ganhou")
