extends Node


var background: Vector2 = Vector2()

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_right"):
		background.x -= 2
		self.set_scroll_offset(background)
	if  Input.is_action_pressed("ui_left"):
		background.x += 2
		self.set_scroll_offset(background)
