extends Node2D

@onready var seta:PackedScene = load("res://scenes/objects/seta.tscn") 

func _ready():
	$Timer.start()
	
func shoot():
	$anim.frame = 1
	var seta_instace = seta.instantiate()
	seta_instace.position = $anim.position
	add_child(seta_instace)



func _on_timer_timeout():
	$anim.frame = 0


func _on_button_button_down():
	shoot()
