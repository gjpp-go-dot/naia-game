extends VideoStreamPlayer


func _on_finished():
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
