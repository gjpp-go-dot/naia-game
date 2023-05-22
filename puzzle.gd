extends Node2D

var contador = 0
var tile = ""

func _on_ready():
	$transition/fill/anim.play("transition_out")

func _physics_process(delta):
	$water.position.y -= 0.2

func _on_water_body_entered(body):
	if body.name == "Naia":
		contador = 0
		$Naia.position.x = -289
		$Naia.position.y = 24
		$target.position.x = 95
		$target.position.y = -328
		$water.position.x = -244
		$water.position.y = 120
		$tiles1.hide()
		$tiles2.hide()
		$tiles3.hide()
		$target.show()


func _on_target_body_entered(body):
	if body.name == "Spear":
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
			$target.position.x = -651
			$target.position.y = -643
			$tiles3.show()
		elif contador == 4:
			$target.hide()

func _on_area_2d_5_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/cutscenes/Final.tscn")
