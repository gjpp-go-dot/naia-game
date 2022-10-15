extends Node2D

export (PackedScene) var throwObjectScene = null

var throwObject = null
var aiming = false
var throwSpeed = 65

func _ready():
	assert(throwObjectScene != null)

	throwObject = throwObjectScene.instance()
	add_child(throwObject)

func _draw():
	if aiming:
		var lines = throwObject.get_prediction_line()

		if lines.size() > 0:
			for i in range(lines.size() - 1):
				draw_line(lines[i][0], lines[i][1], Color(1, 1, 1, 1), 2)

func _process(delta):
	if throwObject.launched:
		return

	if aiming:
		update()
		throwObject.setSpeed(throwSpeed * (delta * 60))
		var mousePos = get_viewport().get_mouse_position()
		print(mousePos)
		throwObject.aim_on(mousePos)

		if Input.is_action_just_pressed("spear_throw"):
			aiming = false
			throwObject.throw()

		if Input.is_action_just_pressed("spear_aim"):
			aiming = false

	elif Input.is_action_just_pressed("spear_aim"):
		aiming = true
