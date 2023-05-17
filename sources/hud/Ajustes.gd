extends Control

var master = AudioServer.get_bus_volume_db(0)
var music = AudioServer.get_bus_volume_db(1)
var sfx = AudioServer.get_bus_volume_db(2)

signal close

var closing = false

func _on_voltar_mouse_entered():
	get_node("MenuSFX").call("select")

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
	if closing and z_index == 0:
		emit_signal("close")

func _show():
	closing = false
	get_node("Background").visible = true
	$AnimationPlayer.playback_speed = 1.5
	get_node("AnimationPlayer").play("AJus")

func _on_voltar_pressed():
	get_node("MenuSFX").call("confirm")
	closing = true
	$AnimationPlayer.playback_speed = 2
	$AnimationPlayer.play_backwards("AJus")

