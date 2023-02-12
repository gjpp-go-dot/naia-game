extends Control

var settings_scene = load("res://scenes/hud/Ajustes.tscn")
var settings_node = null

func _on_iniciar_mouse_entered():
	$AnimIni.play("IniBig")

func _on_ajustes_mouse_entered():
	$AnimAju.play("AjuBig")

func _on_sair_mouse_entered():
	$AnimSai.play("SaiBig")

func _on_iniciar_mouse_exited():
	$AnimIni.play_backwards("IniBig")

func _on_ajustes_mouse_exited():
	$AnimAju.play_backwards("AjuBig")

func _on_sair_mouse_exited():
	$AnimSai.play_backwards("SaiBig")

func close_settings():
	if is_instance_valid(settings_node):
		settings_node.queue_free()

func _on_ajustes_pressed():
	if is_instance_valid(settings_node):
		settings_node.queue_free()
	settings_node = settings_scene.instantiate()
	add_child(settings_node)
	settings_node.call("show")
	settings_node.close.connect(close_settings)


func _on_sair_pressed():
	get_tree().quit()


func _on_iniciar_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
