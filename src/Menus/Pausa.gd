extends Popup



func _ready():
	$Popup/Geral.value = GlobalOpcoes.generalVolume
	$Popup/Musica.value = GlobalOpcoes.musicVolume
	$Popup/SFX.value = GlobalOpcoes.sfxVolume
	if GlobalOpcoes.isPortuguese:
		$Label.text = 'Pausado'
		$Configurar.text = "Configurações"
		$Continuar.text = 'Continuar'
		$Sair.text = 'Voltar ao menu'
		$Popup/Label.text = 'Configurações'
		$Popup/Geral/Label.text = 'Volume geral:'
		$Popup/Musica/Label.text = 'Volume da música:'
		$Popup/SFX/Label.text = "Volume dos efeitos:"
		$Popup/Salvar.text = "Salvar e voltar"
	else:
		$Label.text = 'Paused'
		$Configurar.text = "Settings"
		$Continuar.text = 'Continue'
		$Sair.text = 'Back to menu'
		$Popup/Label.text = 'Settings'
		$Popup/Geral/Label.text = 'General volume:'
		$Popup/Musica/Label.text = 'Music volume:'
		$Popup/SFX/Label.text = "SFX volume:"
		$Popup/Salvar.text = "Save and return"

func pause():
	$".".show()
	get_tree().paused = true
	GlobalOpcoes.isPaused = true

func unpause():
	$".".hide()
	$Popup.hide()
	get_tree().paused = false
	GlobalOpcoes.isPaused = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if GlobalOpcoes.isPaused:
			unpause()
		else:
			pause()

func _on_Continuar_pressed():
	unpause()


func _on_Configurar_pressed():
	$Popup.show()


func _on_Sair_pressed():
	unpause()
	get_tree().change_scene("res://scenes/Menus e utilitarios/Menu.tscn")


func _on_Salvar_pressed():
	GlobalOpcoes.generalVolume = $Popup/Geral.value
	GlobalOpcoes.musicVolume = $Popup/Musica.value
	GlobalOpcoes.sfxVolume = $Popup/SFX.value
	$Popup.hide()
