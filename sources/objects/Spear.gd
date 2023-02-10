extends RigidBody2D

enum SpearType{
	DEFAULT = 0,
	TRAMPOLINE = 1,
	RAPPEL = 2
}

var spear_textures = [
	load("res://assets/sprites/objects/spear/spear_combat.png"),
	load("res://assets/sprites/objects/spear/spear_jump.png"),
	load("res://assets/sprites/objects/spear/spear_rappel.png")
]

@export var spear_type = SpearType.DEFAULT
@export var spear_speed = 320

enum Status{
	AIMING,
	LAUNCHED,
	STUCK
}

var status = Status.AIMING
var callback_node = null
var callback_tween = null

var vine_scene = preload("res://scenes/objects/Vines.tscn")
var vine_object = null

var trampoline_state = false

func trampoline_exec():
	print("trampoline")
	trampoline_state = true
	get_node("Area2D").monitoring = true
	get_node("Area2D").monitorable = true

func rappel_exec():
	print("rappel")
	vine_object = vine_scene.instantiate()
	vine_object.set("global_position", global_position)
	get_parent().add_child(vine_object)

func run_hability():
	if spear_type == SpearType.TRAMPOLINE:
		call_deferred("trampoline_exec")
	elif spear_type == SpearType.RAPPEL:
		call_deferred("rappel_exec")

func set_spear_type(type):
	spear_type = type

	get_node("Sprite2D").set("texture", spear_textures[spear_type])

func aim(global_position_mouse, direction):
	if status != Status.AIMING:
		return
	var spear_position = get_global_position()
	var spear_direction = global_position_mouse - spear_position if direction == 1 else spear_position - global_position_mouse
	var spear_angle = 0
	if direction == 1:
		spear_angle = clamp(spear_direction.angle(), -PI / 3, PI / 32) + PI / 2
	else:
		spear_angle = clamp(spear_direction.angle(), -PI / 32, PI / 3) + PI / 2 + PI
	set_rotation(spear_angle)

func throw(direction):
	status = Status.LAUNCHED
	freeze = false
	angular_damp = -1
	angular_velocity = 0.6 * direction
	apply_central_impulse(Vector2(cos(get_rotation() - (PI / 2)), sin(get_rotation() - (PI / 2))) * spear_speed)

func _ready():
	freeze = true
	set_spear_type(spear_type)

func _on_area_2d_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	if _body.get_name() == "Naia" and trampoline_state and _body.get("global_position").y < global_position.y:
		_body.set("trampoline", true)
		print("trampoline: true")

func _on_area_2d_body_shape_exited(_body_rid, _body, _body_shape_index, _local_shape_index):
	if _body.get_name() == "Naia" and trampoline_state and _body.get("trampoline"):
		_body.set("trampoline", false)
		print("trampoline: false")

func _on_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	if status == Status.LAUNCHED:
		status = Status.STUCK
		set_deferred("freeze", true)
		set_deferred("sleeping", true)
		collision_layer = 1
		collision_mask = 1
		get_node("CollisionShape2DInnerHandle").set_deferred("disabled", false)
		get_node("NipCollision").visible = true
		run_hability()

func _physics_process(delta):
	if callback_node != null:
		global_position = global_position.lerp(callback_node.global_position, 0.090)

		if (global_position.distance_to(callback_node.global_position) < 25) or modulate.a == 0:
			callback_node = null
			queue_free()

func call_back(node):
	collision_layer = 0
	callback_node = node
	sleeping = true
	freeze = true
	get_node("NipCollision").visible = false
	if callback_tween:
		callback_tween.kill()
	callback_tween = create_tween()
	callback_tween.tween_property(self, "modulate", Color(1,1,1,0), 0.5)
	if is_instance_valid(vine_object):
		vine_object.call("kill_vine")
