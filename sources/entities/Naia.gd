extends CharacterBody2D

@export var speed = 130
@export var run_multiplier = 1.6
@export var jump_speed = -700
@export var gravity = 2100
@export_range(0.0, 1.0) var friction = 0.15
@export_range(0.0 , 1.0) var acceleration = 0.15

signal process_event(event_name)

var can = {
	"move": true,
	"jump": true,
	"run": true,
	"sneak": true,
}

class INPUTS_MAP:
	const MOVE_LEFT = "move_left"
	const MOVE_RIGHT = "move_right"
	const JUMP = "jump"
	const SNEAK = "sneak"
	const RUN = "run"

class STATES:
	const IDLE = "idle"
	const WALKING = "walking"
	const RUNNING = "running"
	const JUMPING = "jumping"
	const FALLING = "falling"
	const LANDING = "landing"

var current_state = STATES.IDLE
var landed = true
var last_direction = 1

func bind_process_event(event_name):
	emit_signal("process_event", event_name)

func bind_set_state(state):
	current_state = state

func _physics_process(delta):
	velocity.y += gravity * delta
	var current_speed = speed
	var direction = Input.get_axis(INPUTS_MAP.MOVE_LEFT, INPUTS_MAP.MOVE_RIGHT)
	if direction != 0:
		last_direction = direction

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

	move_and_slide()

	if can["jump"]:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_speed
			landed = false

	if is_on_floor():
		if (not landed) and (velocity.y > jump_speed * 0.5):
			bind_set_state(STATES.LANDING)
			landed = true
	else:
		if velocity.y < 0:
			bind_set_state(STATES.JUMPING)
		else:
			bind_set_state(STATES.FALLING)

	print(current_state)

	bind_process_event("look_left" if last_direction < 0 else "look_right")

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
