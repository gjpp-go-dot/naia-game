extends CharacterBody2D

@export var speed = 140
@export var run_multiplier = 1.6
@export var jump_speed = -650
@export var gravity = 1800
@export_range(0.0, 1.0) var friction = 0.12
@export_range(0.0 , 1.0) var acceleration = 0.11
@export var max_wall_jump_speed = 120

signal process_event(event_name)

var can = {
	"move": true,
	"jump": true,
	"run": true,
	"sneak": true,
	"spear_attack": true,
	"rappel": true,
}

class INPUTS_MAP:
	const MOVE_LEFT = "move_left"
	const MOVE_RIGHT = "move_right"
	const MOVE_DOWN = "move_down"
	const JUMP = "jump"
	const SNEAK = "sneak"
	const RUN = "run"
	const SPEAR_AIM = "spear_aim"
	const SPEAR_THROW = "spear_throw"
	const CHANGE_SPEAR_UP = "change_spear_up"
	const CHANGE_SPEAR_DOWN = "change_spear_down"

class STATES:
	const IDLE = "idle"
	const WALKING = "walking"
	const RUNNING = "running"
	const JUMPING = "jumping"
	const FALLING = "falling"
	const LANDING = "landing"
	const SPEAR_AIM = "spear_aim"
	const SPEAR_RELEASE = "spear_release"
	const RAPPEL = "rappel"
	const RAPPEL_IDLE = "rappel_idle"
var spear_scene = preload("res://scenes/objects/Spear.tscn")
const SPEAR_OFFSET_RIGHT = Vector2(-29, -9)
const SPEAR_OFFSET_LEFT = Vector2(29, -9)

const DEFAULT_CAMERA_ZOOM = Vector2(1.1, 1.1)

var current_state = STATES.IDLE
var landed = true
var last_direction = 1

var can_rappel = false
var vine_x_position = 0
var in_rappel = false

var trampoline = false
var in_trampoline = false

enum SpearTypes{
	DEFAULT = 0,
	JUMP = 1,
	RAPPEL = 2,
}

var spear_object = null
var current_spear_type = SpearTypes.DEFAULT

var camera_tween = null

var default_gravity = gravity

var last_wall_hold = Time.get_ticks_msec()
var wall_jumped = null

func bind_process_event(event_name):
	emit_signal("process_event", event_name)

func bind_set_state(state):
	current_state = state

func get_current_animation():
	return get_node("AnimatedSprite2D").get("animation")

func set_camera_zoom(zoom, time = 0.5):
	if camera_tween:
		camera_tween.kill()
	camera_tween = create_tween()
	camera_tween.tween_property(get_node("Camera2D"), "zoom", zoom, time)

func focus_horizon(value = 1):
	get_node("Camera2D").set("drag_horizontal_offset",  value)
	set_camera_zoom(DEFAULT_CAMERA_ZOOM - Vector2(0.2, 0.2))

func reset_focus_horizon():
	get_node("Camera2D").set("drag_horizontal_offset", 0)
	set_camera_zoom(DEFAULT_CAMERA_ZOOM)

func process_spear_aim():
	spear_object.call("aim", get_global_mouse_position(), last_direction)
	if Input.is_action_just_pressed(INPUTS_MAP.SPEAR_THROW):
		get_node("AnimatedSprite2D").call("manual_unlock")
		get_node("AnimatedSprite2D").set("lock", false)
		bind_set_state(STATES.SPEAR_RELEASE)
		bind_process_event("spear_release")
		spear_object.call("throw", last_direction)
	elif Input.is_action_just_pressed(INPUTS_MAP.SPEAR_AIM):
		get_node("AnimatedSprite2D").call("manual_unlock")
		bind_set_state(STATES.IDLE)
		get_node("AnimatedSprite2D").call("STOP")
		call_spear_back()

func summon_new_spear():
	last_direction = 1 if get_global_mouse_position().x > get_global_position().x else -1

	bind_process_event("look_left" if last_direction < 0 else "look_right")
	get_node("AnimatedSprite2D").call("manual_unlock")
	get_node("AnimatedSprite2D").call("SPEAR_AIM")
	bind_set_state(STATES.SPEAR_AIM)

	spear_object = spear_scene.instantiate()
	spear_object.set("position", get_global_position() + (SPEAR_OFFSET_RIGHT if last_direction > 0 else SPEAR_OFFSET_LEFT))
	spear_object.call("set_spear_type", current_spear_type)

	get_parent().add_child(spear_object)

	focus_horizon(last_direction)

func call_spear_back():
	if is_instance_valid(spear_object):
		spear_object.call("call_back", self)
	reset_focus_horizon()

func set_type_spear(type = null):
	if type == null:
		type = current_spear_type
	else:
		current_spear_type = type

	if is_instance_valid(spear_object):
		spear_object.call("set_spear_type", type)


func exec_trampoline():
	in_trampoline = true
	get_node("Naiui").visible = true
	get_node("Naiui/ProgressBar").call("start_bounce")
	set_camera_zoom(Vector2(1.5, 1.5))
	bind_process_event("prepare_trampoline_jump")

func jump(jump_speed_custom = null):
	if jump_speed_custom:
		velocity.y = jump_speed_custom
	else:
		velocity.y = jump_speed
	landed = false

## JUST FOR TESTS !!!
func _process(_delta):
	if Input.is_action_just_released(INPUTS_MAP.CHANGE_SPEAR_UP) or Input.is_action_just_released(INPUTS_MAP.CHANGE_SPEAR_DOWN):
		# range 0 to 2
		var new_type = current_spear_type + (1 if Input.is_action_just_released(INPUTS_MAP.CHANGE_SPEAR_UP) else -1)
		if new_type < 0:
			new_type = 2
		elif new_type > 2:
			new_type = 0

		current_spear_type = new_type

		set_type_spear()

func _physics_process(delta):
	if in_trampoline:
		if not Input.is_action_pressed(INPUTS_MAP.JUMP) or get_node("Naiui/ProgressBar").get("value") == 100:
			jump(jump_speed + ((jump_speed * 0.50) * (get_node("Naiui/ProgressBar").get("value") / 100)))
			print(velocity.y)
			landed = false
			in_trampoline = false
			get_node("Naiui").visible = false
			get_node("Naiui/ProgressBar").call("stop_bounce")
			set_camera_zoom(DEFAULT_CAMERA_ZOOM)
		else:
			return

	velocity.y += gravity * delta

	if get_current_animation() == "spear_aim" or get_current_animation() == "spear_release":
		process_spear_aim()
		return

	var current_speed = speed
	var direction = Input.get_axis(INPUTS_MAP.MOVE_LEFT, INPUTS_MAP.MOVE_RIGHT)

	if direction != 0:
		last_direction = direction

	if can["spear_attack"] and (not get_node("AnimatedSprite2D").get("lock")) and (current_state != STATES.SPEAR_RELEASE and current_state != STATES.SPEAR_AIM) and Input.is_action_just_pressed(INPUTS_MAP.SPEAR_AIM):
			if spear_object == null and is_on_floor() and not (get_current_animation() == "spear_aim" or get_current_animation() == "spear_release"):
				summon_new_spear()
			else:
				call_spear_back()

	if can["run"]:
		if Input.is_action_pressed(INPUTS_MAP.RUN):
			current_speed = speed * run_multiplier

	if can["move"]:
		if direction != 0:
			velocity.x = lerp(velocity.x, direction * current_speed, acceleration)
			if current_speed == speed:
				bind_set_state(STATES.WALKING)
			else:
				bind_set_state(STATES.RUNNING)
		else:
			velocity.x = lerp(velocity.x, 0.0, friction)
			bind_set_state(STATES.IDLE)

	if can["rappel"] and can_rappel:
		if Input.is_action_pressed(INPUTS_MAP.JUMP) or Input.is_action_pressed(INPUTS_MAP.MOVE_DOWN):
			in_rappel = true

			if Input.is_action_pressed(INPUTS_MAP.JUMP):
				velocity.y = -120
			if Input.is_action_pressed(INPUTS_MAP.MOVE_DOWN):
				velocity.y = 120

		if in_rappel:
			if abs(velocity.y) > 40:
				gravity = -(velocity.y * 1.5)
			else:
				velocity.y = 0

	elif can["rappel"] and not can_rappel:
		gravity = default_gravity
		in_rappel = false


	if can["jump"] and not can_rappel and not in_rappel:
		if Input.is_action_just_pressed(INPUTS_MAP.JUMP) and is_on_floor():
			if trampoline and landed:
				exec_trampoline()
			elif landed:
				jump()

	if is_on_wall() and (Input.get_axis(INPUTS_MAP.MOVE_LEFT, INPUTS_MAP.MOVE_RIGHT) != 0):
		if velocity.y > 0:
			velocity.y = velocity.y + acceleration if velocity.y < max_wall_jump_speed else max_wall_jump_speed
		last_wall_hold = Time.get_ticks_msec()

	if can["jump"] and Input.is_action_just_pressed(INPUTS_MAP.JUMP) and (last_wall_hold - Time.get_ticks_msec() < 394) and is_on_wall() and not is_on_floor():
		if wall_jumped == null or wall_jumped != get_wall_normal():
			jump()
			var ine = get_wall_normal().x * (max_wall_jump_speed * 2.75)
			velocity.x = ine
			wall_jumped = get_wall_normal()

	move_and_slide()

	if is_on_floor():
		if (not landed) and (velocity.y > jump_speed * 0.5):
			bind_set_state(STATES.LANDING)
			landed = true
			wall_jumped = null
	else:
		if in_rappel:
			print(velocity.y)
			if abs(velocity.y) > 40:
				bind_set_state(STATES.RAPPEL)
			else:
				bind_set_state(STATES.RAPPEL_IDLE)
		elif velocity.y < 0:
			bind_set_state(STATES.JUMPING)
		else:
			bind_set_state(STATES.FALLING)

	#print(current_state)
	if not in_rappel:
		bind_process_event("look_left" if last_direction < 0 else "look_right")
	elif not is_on_floor():
		print(vine_x_position, " ", global_position.x)
		bind_process_event("look_left" if vine_x_position < global_position.x else "look_right")

	match current_state:
		STATES.IDLE:
			bind_process_event("idle")
		STATES.WALKING:
			bind_process_event("walk")
		STATES.RUNNING:
			bind_process_event("run")
		STATES.JUMPING:
			bind_process_event("jump")
		STATES.FALLING:
			bind_process_event("fall")
		STATES.LANDING:
			bind_process_event("land")
		STATES.RAPPEL:
			bind_process_event("rappel")
		STATES.RAPPEL_IDLE:
			bind_process_event("rappel_idle")

func _on_animated_sprite_2d_animation_finished_component(animation):
	pass
	match animation:
		"spear_release":
			get_node("AnimatedSprite2D").call("manual_unlock")
			bind_set_state(STATES.IDLE)
			get_node("AnimatedSprite2D").call("STOP")
			reset_focus_horizon()
