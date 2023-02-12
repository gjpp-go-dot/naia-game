extends AudioStreamPlayer


var ambience_1_sfx = load("res://assets/sounds/environment/38732269_forest-ambience-02.mp3")
var ambience_2_sfx = load("res://assets/sounds/environment/38732269_forest-ambience-02.wav")
var main_theme_sfx = load("res://assets/sounds/environment/Drifting at 432 Hz - Unicorn Heads.mp3")


func ambience_1():
	self.stream = ambience_1_sfx

func ambience_2():
	self.stream = ambience_2_sfx
	

func main_theme():
	self.stream = main_theme_sfx


func _process(delta):
	if Input.is_action_pressed("jump"):
		main_theme()
		self.play()
