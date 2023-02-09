extends Control

var master = AudioServer.get_bus_volume_db(0)
var music = AudioServer.get_bus_volume_db(1)
var sfx = AudioServer.get_bus_volume_db(2)

func volume():
	master = $SlideMas.value
	music = $SlideMus.value
	sfx = $SlideSFX.value

	

func _ready():
	music = AudioServer.get_bus_volume_db(1)
	$SlideMas.value = master
	$SlideMus.value = music
	$SlideSFX.value = sfx

func _process(delta):
	volume()
	AudioServer.set_bus_volume_db(0,master)
	AudioServer.set_bus_volume_db(1,music)
	AudioServer.set_bus_volume_db(2,sfx)
	

func _on_voltar_pressed():
	$AnimationPlayer.playback_speed = 2
	$AnimationPlayer.play_backwards("AJus")
	
