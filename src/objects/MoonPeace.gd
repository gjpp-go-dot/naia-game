extends RigidBody2D

var targetAimPoint = Vector2(0,0)
var launched = false
var collided = false

export var freeze: bool = true setget set_freeze

var speed = 0.0 setget setSpeed, getSpeed

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
	if not collided:
		rotate(deg2rad((0.1 * (delta * 60) * ((weight * mass)))))

func get_prediction_line():
	var lines_to_draw = []
	var pos = position

	var velocity = calculate_speed()
	var num_points = 100
	var gravity_weight = (weight * mass)
	var step = 1.75 / num_points

	for _i in range(num_points):
		var new_pos = pos + velocity * step + Vector2(0, 9.8) * gravity_weight * step * step
		var new_velocity = velocity + Vector2(0, 9.8) * gravity_weight * step
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


func _on_Area2D_body_shape_entered(_body_rid: RID, body: Node, _body_shape_index: int, _local_shape_index: int):
	if not body == self:
		collided = true
