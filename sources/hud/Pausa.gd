extends Popup

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


func _process(delta):
	volume()
	AudioServer.set_bus_volume_db(0,master)
	AudioServer.set_bus_volume_db(1,music)
	AudioServer.set_bus_volume_db(2,sfx)
	if Input.action_press("ui_end") && self.transparent == false:
		self.transparent = true
	elif Input.action_press("ui_end") && self.transparent == true:
		self.transparent = false
	

func _on_voltar_menu_button_down():
	get_tree().change_scene_to_file("res://scenes/hud/MenuIni.tscn")

func _on_aju_vol_button_down():
	$AnimationPlayer.play("Pausa")



func _on_voltar_button_down():
	$AnimationPlayer.play_backwards("Pausa")
