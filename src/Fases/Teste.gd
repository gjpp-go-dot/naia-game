extends Node2D


func _ready():
	if Global.checkpoint[1][0]:
		$personagem.position = Vector2(641,245)


func _on_Death_area_entered(area):
	get_tree().change_scene("res://scenes/Menus e utilitarios/Gameover.tscn")


func _on_Check_area_entered(area):
	Global.checkpoint[0][1] = false
	Global.checkpoint[1][0] = true
