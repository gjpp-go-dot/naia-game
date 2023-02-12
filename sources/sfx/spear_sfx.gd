extends AudioStreamPlayer


var trow_sfx = load("res://assets/sounds/spear_sfx/205563__everheat__arrow.wav")
var get_spear_sfx = load("res://assets/sounds/spear_sfx/394180__saturdaysoundguy__arrow-loose-and-flyby.wav")
var hit_sfx = load("res://assets/sounds/spear_sfx/443575__checholio__11-toing-flecha.wav")
var to_aim_sfx = load("res://assets/sounds/spear_sfx/537765__kostas17__wooden-object-take.wav")


func trow():
	self.stream = trow_sfx

func get_spear():
	self.stream = get_spear_sfx

func hit():
	self.stream = hit_sfx
	
func to_aim():
	self.stream = to_aim_sfx

func _process(delta):
	if Input.is_action_pressed("jump"):
		trow()
		self.play()
