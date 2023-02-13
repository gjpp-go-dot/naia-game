extends AudioStreamPlayer

var main_theme_sfx = load("res://assets/sounds/environment/Drifting at 432 Hz - Unicorn Heads.mp3")

func main_theme():
	self.stream = main_theme_sfx
	self.play()


func _on_ready():
	main_theme()
