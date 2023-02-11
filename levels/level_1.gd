extends Node2D

func _physics_process(delta):
	$water.position.y -= 0.6


func _on_water_body_entered(body):
	print("glup glup")



func _on_target_body_entered(body):
	print("alvo atingido")
