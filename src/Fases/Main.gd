extends Node2D

func _ready():
	$ambientalfx.play()
	if Global.checkpoint[0][0]:
		$personagem.position = Vector2(-7,245)
	elif Global.checkpoint[0][1]:
		$personagem.position = Vector2(1518,500)

func _process(delta):
	$ambientalfx.volume_db = GlobalOpcoes.controlMusic(-5,-55)


func _on_Check1_area_entered(area):
	Global.checkpoint[0][0] = true


func _on_Check2_area_entered(area):
	Global.checkpoint[0][0] = false
	Global.checkpoint[0][1] = true




func _on_Death_area_entered(area):
	get_tree().change_scene("res://scenes/Menus e utilitarios/Gameover.tscn")


func _on_Next_area_entered(area):
	get_tree().change_scene("res://scenes/Fases/Fase2.tscn")
