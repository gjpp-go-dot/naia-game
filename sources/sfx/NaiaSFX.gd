extends AudioStreamPlayer


var jump_sfx = load("res://assets/sounds/character/jump.ogg")
var landing_sfx = load("res://assets/sounds/character/landing.wav")
var jump_wather_sfx = load("res://assets/sounds/character/cair_na_agua.mp3")
var jump_spear_sfx = load("res://assets/sounds/character/jump_spear.wav")

func jump():
	self.stream = jump_sfx
	self.play()

func landing():
	self.stream = landing_sfx
	self.play()

func jump_wather():
	self.stream = jump_wather_sfx
	self.play()
	
func jump_spear():
	self.stream = jump_spear_sfx
	self.play()
