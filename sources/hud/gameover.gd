extends CanvasLayer


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_button_up():
	get_tree().reload_current_scene()


func _on_texture_button_2_button_up():
	get_tree().change_scene_to_file("res://scenes/hud/MenuIni.tscn")

func lost():
	$AnimationPlayer.play("perdeu")
