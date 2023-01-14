extends AnimatedSprite2D

class ANIMATIONS_MAP:
	const IDLE = "idle"
	const WALK = "walk"
	const RUN = "run"
	const JUMP = "jump"
	const FALL = "fall"
	const LAND = "land"
	const SPEAR = "spear"

var lock = false

func MOVE():
	self.play(ANIMATIONS_MAP.WALK)

func RUN():
	self.play(ANIMATIONS_MAP.RUN)

func STOP():
	self.play(ANIMATIONS_MAP.IDLE)

func JUMP():
	self.play(ANIMATIONS_MAP.JUMP)

func FALL():
	self.play(ANIMATIONS_MAP.FALL)

func LAND():
	self.play(ANIMATIONS_MAP.LAND)
	lock = true

func LOOK_LEFT():
	self.flip_h = true

func LOOK_RIGHT():
	self.flip_h = false

var event_manager = preload("res://sources/generics/EventManager.gd").new()

func _on_naia_process_event(event_name):
	if lock:
		print("naia process event: locked")
		return
	print("naia process event:", event_name)
	event_manager.process_event(event_name)

func _ready():
	MOVE()

	event_manager.add_event_handler("walk", MOVE)
	event_manager.add_event_handler("run", RUN)
	event_manager.add_event_handler("idle", STOP)
	event_manager.add_event_handler("jump", JUMP)
	event_manager.add_event_handler("fall", FALL)
	event_manager.add_event_handler("land", LAND)
	event_manager.add_event_handler("look_left", LOOK_LEFT)
	event_manager.add_event_handler("look_right", LOOK_RIGHT)

func _on_animation_finished():
	lock = false
