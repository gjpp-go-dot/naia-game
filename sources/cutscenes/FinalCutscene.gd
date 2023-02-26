extends VideoStreamPlayer


var cenas = 0

func _on_finished():
	self.stream = load("res://assets/cutscenes/final_cutscene.ogv")
	self.play()
	
