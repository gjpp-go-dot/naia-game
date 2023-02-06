extends ColorRect

var master = AudioServer.get_bus_volume_db(0)
var music = AudioServer.get_bus_volume_db(1)
var sfx = AudioServer.get_bus_volume_db(2)

func volume():
	master = $SlideMas.value
	music = $SlideMus.value
	sfx = $SlideSFX.value
	master = master/100*86 - 80
	music = music/100*86 - 80
	sfx = sfx/100*86 - 80
	

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
	

func quit():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/hud/MenuIni.tscn")

func altVolume():
	$AnimationPlayer.play("Pausa")



func retornar():
	$AnimationPlayer.play_backwards("Pausa")
	
func pause():
	$AnimationPlayer.play("Appear")
	get_tree().paused = true
	
func unpause():
	$AnimationPlayer.play_backwards("Appear")
	get_tree().paused = false
