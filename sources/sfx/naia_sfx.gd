extends AudioStreamPlayer


var jump_sfx = load("res://assets/sounds/character/jump.ogg")
var landing_sfx = load("res://assets/sounds/character/landing.wav")
var jump_wather_sfx = load("res://assets/sounds/character/cair_na_agua.mp3")


func jump():
	self.stream = jump_sfx
	self.play()

func landing():
	self.stream = landing_sfx
	self.play()

func jump_wather():
	self.stream = jump_wather_sfx
	self.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("jump"):
		jump()
