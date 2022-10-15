extends Node2D

onready var language = $OptionButton

func SetLanguage():
	
	# Seta as opções do dropdown
	language.add_item("Português") #0
	language.add_item("English") #1
	
	# Seta a opção selecionada como médio
	if GlobalOpcoes.isPortuguese:
		language.select(0)
	else:
		language.select(1)
	

func _ready():
	SetLanguage()
	$Geral.value = GlobalOpcoes.generalVolume
	$Musica.value = GlobalOpcoes.musicVolume
	$SFX.value = GlobalOpcoes.sfxVolume
	if GlobalOpcoes.isPortuguese:
		$Label.text = 'Configurações'
		$Geral/Label.text = 'Volume geral:'
		$Musica/Label.text = 'Volume da música:'
		$SFX/Label.text = 'Volume dos efeitos:'
		$OptionButton/Label.text = 'Língua:'
		$Menu.text = 'Menu principal'
	else:
		$Label.text = "Settings"
		$Geral/Label.text = 'General volume:'
		$Musica/Label.text = 'Music volume:'
		$SFX/Label.text = 'SFX volume:'
		$OptionButton/Label.text = 'Language'
		$Menu.text = 'Main menu'
	
func _process(delta):
	GlobalOpcoes.generalVolume = $Geral.value
	GlobalOpcoes.musicVolume = $Musica.value
	GlobalOpcoes.sfxVolume = $SFX.value
	if language.selected == 0:
		GlobalOpcoes.isPortuguese = true
	else:
		GlobalOpcoes.isPortuguese = false


func _on_Menu_pressed():
	get_tree().change_scene("res://scenes/Menus e utilitarios/Menu.tscn")
