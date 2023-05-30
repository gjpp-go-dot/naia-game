extends Camera2D



func _process(delta):
	if Global.fase == 1:
		self.limit_left = -430
	if Global.fase == 2:
		self.limit_left = -10000000
