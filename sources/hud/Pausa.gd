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

func _process(delta):
	volume()
	AudioServer.set_bus_volume_db(0,master)
	AudioServer.set_bus_volume_db(1,music)
	AudioServer.set_bus_volume_db(2,sfx)
	if Input.is_action_pressed("Pausa"):
		self.pause()

func quit():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/hud/MenuIni.tscn")

func altVolume():
	$AnimationPlayer.play("Pausa")



func retornar():
	$Continuar.position = Vector2(477,220)
	$AnimationPlayer.play_backwards("Pausa")
	
func pause():
	$AnimationPlayer.play("Appear")
	get_tree().paused = true
	
func unpause():
	$AnimationPlayer.play_backwards("Appear")
	get_tree().paused = false


func _on_voltar_pressed():
	retornar()


func _on_slide_mas_changed():
	pass # Replace with function body.


func _on_slide_mus_changed():
	pass # Replace with function body.


func _on_slide_sfx_changed():
	pass # Replace with function body.
