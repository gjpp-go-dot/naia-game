extends Node2D

func _ready():
	if GlobalOpcoes.isPortuguese:
		$ColorRect/Titulo.text = 'Luz de Jaci'
		$Novo.text = 'Novo jogo'
		$Configuracoes.text = 'Configurações'
		$Sair.text = "Sair do jogo"
	else:
		$ColorRect/Titulo.text = "Jaci's light"
		$Novo.text = 'New game'
		$Configuracoes.text = 'Settings'
		$Sair.text = "Quit game"

func _on_Configuracoes_pressed():
	get_tree().change_scene("res://scenes/Menus e utilitarios/Configurações.tscn")
	


func _on_Sair_pressed():
	get_tree().quit()


func _on_Novo_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")
