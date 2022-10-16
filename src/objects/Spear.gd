extends RigidBody2D

var targetAimPoint = Vector2(0,0)
var launched = false
var attacking = false

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
	var num_points = 10
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

func __stab(direction, selfDestroy = false):
	var tween = Tween.new()

	add_child(tween)
	tween.interpolate_property(self, "global_position", global_position, global_position + (75 * direction), 0.2)
	tween.start()

	yield(tween, "tween_all_completed")
	tween.queue_free()
	if selfDestroy:
		queue_free()

	attacking = false

func attack(attackType, direction, selfDestroy = false):
	if launched or attacking:
		return
	attacking = true
	collision_mask = 0
	collision_layer = 0

	assert(direction == Vector2.RIGHT or direction == Vector2.LEFT)

	if direction == Vector2.RIGHT:
		pass
	elif direction == Vector2.LEFT:
		rotate(deg2rad(180))

	assert(attackType == "stab")

	match attackType:
		"stab":
			__stab(direction, selfDestroy)


func _on_Area2D_body_shape_entered(body_rid:RID, body:Node, body_shape_index:int, local_shape_index:int):
	if attacking:
		body.call("hit", self)
