extends VideoStreamPlayer


var cenas = 0

func _on_finished():
	self.stream = load("res://assets/cutscenes/final_cutscene.ogv")
	self.play()
	get_tree().change_scene_to_file("res://scenes/hud/creditos.tscn")
# segundo link eh os creditos
