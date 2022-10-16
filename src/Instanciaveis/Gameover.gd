extends Node2D


func _ready():
	Global.points = Global.count
	if GlobalOpcoes.isPortuguese:
		$Label.text = "Fim de Jogo"
		$TentarDNV.text = "Tentar novamente"
		$Menu.text = 'Menu inicial'
	else:
		$Label.text = "Game Over"
		$TentarDNV.text = "Try again"
		$Menu.text = 'Main menu'
	
	$AnimationPlayer.play("Gamend")

func _on_TentarDNV_pressed():
	for i in range(len(Global.checkpoint)):
		for u in range(len(Global.checkpoint[i])):
			if Global.checkpoint[i][u]:
				get_tree().change_scene('res://scenes/Fases/Fase'+str(i+1)+'.tscn')



func _on_Menu_pressed():
	get_tree().change_scene("res://scenes/Menus e utilitarios/Menu.tscn")
