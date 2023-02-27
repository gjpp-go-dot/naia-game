extends VideoStreamPlayer


var cenas = 0

func _on_finished():
	self.stream = load("res://assets/cutscenes/final_cutscene.ogv")
	self.play()
	self.stream = load("res://assets/cutscenes/Vídeo-sem-título-‐-Feito-com-o-Clipchamp-_11_.ogv")
	self.play()
# segundo link eh os creditos
