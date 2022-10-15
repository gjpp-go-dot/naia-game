extends RigidBody2D

var targetAimPoint = Vector2(0,0)
var launched = false
export var nibWeight: float = 0.065
export var freeze: bool = true setget setFreeze, getFreeze


func throw(speed: float = 50.0):
	setFreeze(false)
	launched = true

	apply_central_impulse((targetAimPoint - global_position).normalized() * ((speed) * (weight * mass)))

func aim_on(target: Vector2):
	look_at(target)
	targetAimPoint = target

func _update_draw():
	if launched:
		draw_line(global_position, targetAimPoint, Color(1,0,0,1))

func _physics_process(delta):
	rotate(deg2rad((1 if global_rotation_degrees < 90 else -1) * (delta * 60) * ((weight * mass) * nibWeight)))

func setFreeze(_freeze: bool):
	freeze = _freeze
	if _freeze:
		mode = RigidBody2D.MODE_STATIC
		set_physics_process(false)
	else:
		mode = RigidBody2D.MODE_RIGID
		set_physics_process(true)

func getFreeze():
	return freeze

func _ready():
	setFreeze(freeze)
	#aim_on(Vector2(1280, 0))
	#throw()
