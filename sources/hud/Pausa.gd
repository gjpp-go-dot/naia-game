extends ColorRect

var master = AudioServer.get_bus_volume_db(0)
var music = AudioServer.get_bus_volume_db(1)
var sfx = AudioServer.get_bus_volume_db(2)

func _on_continuar_mouse_entered():
	if $Continuar.disabled == false:
		get_node("MenuSFX").call("select")

func _on_aju_vol_mouse_entered():
	if $AjuVol.disabled == false:
		get_node("MenuSFX").call("select")

func _on_voltar_menu_mouse_entered():
	if $VoltarMenu.disabled == false:
		get_node("MenuSFX").call("select")

func _on_voltar_mouse_entered():
	if $Voltar.disabled == false:
		get_node("MenuSFX").call("select")

func volume():
	master = $SlideMas.value
	music = $SlideMus.value
	sfx = $SlideSFX.value

func _ready():
	$Voltar.disabled = true
	$Continuar.disabled = true
	$AjuVol.disabled = true
	$VoltarMenu.disabled = true
	$SlideMas.value = master
	$SlideMus.value = music
	$SlideSFX.value = sfx
	$Continuar.pressed.connect(resume)
	$AjuVol.pressed.connect(altVolume)
	$Voltar.pressed.connect(retornar)
	$VoltarMenu.pressed.connect(quit)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and get_tree().paused == true:
		get_node("MenuSFX").call("confirm")
		$AnimationPlayer.play_backwards("Appear")
		$menu_soundtrack.stop()
		resume()


	elif Input.is_action_just_pressed("ui_cancel") and get_tree().paused== false:
		get_node("MenuSFX").call("confirm")
		$AnimationPlayer.play("Appear")
		pause()
		$menu_soundtrack.play()

	print(get_tree().paused)


func quit():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/hud/MenuIni.tscn")

func altVolume():
	$Voltar.disabled = false
	$AnimationPlayer.play("Pausa")

func retornar():
	$Voltar.disabled = true
	get_node("MenuSFX").call("confirm")
	$Continuar.position = Vector2(477,220)
	$AnimationPlayer.play_backwards("Pausa")

func pause():
	if get_tree().paused:
		return
	$Continuar.disabled = false
	$AjuVol.disabled = false
	$VoltarMenu.disabled = false
	get_node("MenuSFX").call("confirm")
	volume()
	$AnimationPlayer.play("Appear")
	get_tree().paused = true

func resume():
	if not get_tree().paused:
		return
	$Continuar.disabled = true
	$AjuVol.disabled = true
	$VoltarMenu.disabled = true
	$Voltar.disabled = true
	get_node("MenuSFX").call("confirm")
	volume()
	$AnimationPlayer.play_backwards("Appear")
	get_tree().paused = false
	$menu_soundtrack.stop()

func _on_voltar_pressed():
	$Voltar.disabled = true
	get_node("MenuSFX").call("confirm")
	retornar()


func _on_slide_mas_changed():
	AudioServer.set_bus_volume_db(0,master)
	volume()


func _on_slide_mus_changed():
	AudioServer.set_bus_volume_db(1,music)
	volume()


func _on_slide_sfx_changed():
	AudioServer.set_bus_volume_db(2,sfx)
	volume()


func _on_continuar_pressed():
	resume()
