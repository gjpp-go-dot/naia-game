extends Node2D

export (PackedScene) var throwObjectScene = null

var throwObject = null
var aiming = false
var throwSpeed = 65

func _ready():
	assert(throwObjectScene != null)

	throwObject = throwObjectScene.instance()
	add_child(throwObject)

func _process(delta):
	if throwObject.launched:
		return

	if aiming:
		var mousePos = get_viewport().get_mouse_position()
		print(mousePos)
		throwObject.aim_on(mousePos)

		if Input.is_action_just_pressed("spear_throw"):
			aiming = false
			throwObject.throw(throwSpeed * (delta * 65))

		if Input.is_action_just_pressed("spear_aim"):
			aiming = false

	elif Input.is_action_just_pressed("spear_aim"):
		aiming = true
