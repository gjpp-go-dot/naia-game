extends RigidBody2D

var targetAimPoint = Vector2(0,0)
var launched = false
export var nibWeight: float = 0.075
export var freeze: bool = true setget set_freeze
var speed = 0.0 setget setSpeed, getSpeed

var damage = 50

func setSpeed(newSpeed):
	speed = newSpeed

func getSpeed():
	return speed

func calculate_speed():
	return (targetAimPoint - global_position).normalized() * ((speed) * (weight * mass))

func throw():
	set_freeze(false)
	launched = true

	apply_central_impulse(calculate_speed())

func aim_on(target: Vector2):
	look_at(target)
	targetAimPoint = target

func _physics_process(delta):
	rotate(deg2rad((1 if global_rotation_degrees < 90 and global_rotation_degrees > -90  else -1) * (delta * 60) * ((weight * mass) * nibWeight)))

func get_prediction_line():
	var lines_to_draw = []
	var pos = position

	var velocity = calculate_speed() * (1 - ((weight * mass) * nibWeight))
	var num_points = 1000
	var gravity_weight = (weight * mass)
	var step = 2.0 / num_points

	for _i in range(num_points):
		var new_pos = pos + velocity * step + Vector2(0, weight) * gravity_weight * step * step
		var new_velocity = velocity + Vector2(0, weight) * gravity_weight * step
		lines_to_draw.append([pos, new_pos])
		pos = new_pos
		velocity = new_velocity

	return lines_to_draw

func set_freeze(_freeze: bool):
	freeze = _freeze
	if _freeze:
		mode = RigidBody2D.MODE_STATIC
		set_physics_process(false)
	else:
		mode = RigidBody2D.MODE_RIGID
		set_physics_process(true)

func _ready():
	set_freeze(freeze)
