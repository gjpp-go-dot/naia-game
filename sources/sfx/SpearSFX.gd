extends AudioStreamPlayer


var throw_sfx = load("res://assets/sounds/spear_sfx/205563__everheat__arrow.wav")
var get_spear_sfx = load("res://assets/sounds/spear_sfx/394180__saturdaysoundguy__arrow-loose-and-flyby.wav")
var hit_sfx = load("res://assets/sounds/spear_sfx/443575__checholio__11-toing-flecha.wav")
var to_aim_sfx = load("res://assets/sounds/spear_sfx/537765__kostas17__wooden-object-take.wav")


func throw():
	self.stream = throw_sfx
	self.play()

func get_spear():
	self.stream = get_spear_sfx
	self.play()

func hit():
	self.stream = hit_sfx
	self.play()

func to_aim():
	self.stream = to_aim_sfx
	self.play()
