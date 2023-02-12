extends ColorRect

var master = AudioServer.get_bus_volume_db(0)
var music = AudioServer.get_bus_volume_db(1)
var sfx = AudioServer.get_bus_volume_db(2)



func volume():
	master = $SlideMas.value
	music = $SlideMus.value
	sfx = $SlideSFX.value


func _ready():

	$SlideMas.value = master
	$SlideMus.value = music
	$SlideSFX.value = sfx
	$Continuar.pressed.connect(unpause)
	$AjuVol.pressed.connect(altVolume)
	$Voltar.pressed.connect(retornar)
	$VoltarMenu.pressed.connect(quit)

func _input(event):
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			unpause()
		else:
			pause()

func quit():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/hud/MenuIni.tscn")

func altVolume():
	$AnimationPlayer.play("Pausa")



func retornar():
	$Continuar.position = Vector2(477,220)
	$AnimationPlayer.play_backwards("Pausa")

func pause():
	volume()
	$AnimationPlayer.play("Appear")
	get_tree().paused = true

func unpause():
	$AnimationPlayer.play_backwards("Appear")
	get_tree().paused = false


func _on_voltar_pressed():
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
