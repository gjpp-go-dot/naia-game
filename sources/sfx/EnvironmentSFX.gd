extends AudioStreamPlayer


var ambience_1_sfx = load("res://assets/sounds/environment/38732269_forest-ambience-02.mp3")


func ambience_1():
	self.stream = ambience_1_sfx
	self.play()

func _on_ready():
	ambience_1()
