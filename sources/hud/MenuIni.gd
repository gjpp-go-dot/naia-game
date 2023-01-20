extends Node2D

func _process(_delta):
	if $Control.process_mode == Node.PROCESS_MODE_DISABLED:
		$Iniciar.process_mode = Node.PROCESS_MODE_INHERIT
		$Ajustes.process_mode = Node.PROCESS_MODE_INHERIT
		$Sair.process_mode = Node.PROCESS_MODE_INHERIT
		$AnimIni.process_mode = Node.PROCESS_MODE_INHERIT
		$AnimAju.process_mode = Node.PROCESS_MODE_INHERIT
		$AnimSai.process_mode = Node.PROCESS_MODE_INHERIT

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


func _on_ajustes_pressed():
	$Control/AnimationPlayer.playback_speed = 1
	$Control/AnimationPlayer.play("AJus")
	$Iniciar.process_mode = Node.PROCESS_MODE_DISABLED
	$Ajustes.process_mode = Node.PROCESS_MODE_DISABLED
	$Sair.process_mode = Node.PROCESS_MODE_DISABLED
	$AnimIni.process_mode = Node.PROCESS_MODE_DISABLED
	$AnimAju.process_mode = Node.PROCESS_MODE_DISABLED
	$AnimSai.process_mode = Node.PROCESS_MODE_DISABLED


func _on_sair_pressed():
	get_tree().quit()
