extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
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
	get_tree().reload_current_scene()


func _on_Menu_pressed():
	get_tree().change_scene("res://scenes/Menus e utilitarios/Menu.tscn")
