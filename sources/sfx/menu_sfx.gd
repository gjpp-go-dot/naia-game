extends AudioStreamPlayer


var select_sfx = load("res://assets/sounds/menu/menu_selecionar.mp3")
var confirm_sfx = load("res://assets/sounds/menu/menu_confirmar.mp3")
var cancel_sfx = load("res://assets/sounds/menu/menu_cancelar.mp3")


func select():
	self.stream = select_sfx

func confirm():
	self.stream = confirm_sfx

func cancel():
	self.stream = cancel_sfx


func _process(delta):
	if Input.is_action_pressed("jump"):
		cancel()
		self.play()
