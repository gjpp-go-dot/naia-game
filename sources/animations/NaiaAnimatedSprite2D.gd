extends AnimatedSprite2D

class ANIMATIONS_MAP:
	const IDLE = "idle"
	const WALK = "walk"
	const RUN = "run"
	const JUMP = "jump"
	const FALL = "fall"
	const LAND = "land"
	const SPEAR_AIM = "spear_aim"
	const SPEAR_RELEASE = "spear_release"
	const RAPPEL = "rappel"

signal animation_finished_component(animation_name)

var lock = false
var manual_lock = false

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

func SPEAR_AIM():
	self.play(ANIMATIONS_MAP.SPEAR_AIM)
	lock = true
	manual_lock = true

func SPEAR_RELEASE():
	self.play(ANIMATIONS_MAP.SPEAR_RELEASE)
	lock = true

func RAPPEL():
	self.play(ANIMATIONS_MAP.RAPPEL)

func RAPPEL_IDLE():
	self.stop()

func PREPARE_TRAMPOLINE_JUMP():
	self.play(ANIMATIONS_MAP.JUMP)
	self.frame = 0
	self.stop()

var event_manager = preload("res://sources/generics/EventManager.gd").new()

func manual_unlock():
	manual_lock = false

func _on_naia_process_event(event_name):
	if lock or manual_lock:
		#print("naia process event: locked")
		return
	#print("naia process event:", event_name)
	event_manager.process_event(event_name)

func _ready():
	event_manager.add_event_handler("walk", MOVE)
	event_manager.add_event_handler("run", RUN)
	event_manager.add_event_handler("idle", STOP)
	event_manager.add_event_handler("jump", JUMP)
	event_manager.add_event_handler("fall", FALL)
	event_manager.add_event_handler("land", LAND)
	event_manager.add_event_handler("look_left", LOOK_LEFT)
	event_manager.add_event_handler("look_right", LOOK_RIGHT)
	event_manager.add_event_handler("spear_aim", SPEAR_AIM)
	event_manager.add_event_handler("spear_release", SPEAR_RELEASE)
	event_manager.add_event_handler("rappel", RAPPEL)
	event_manager.add_event_handler("rappel_idle", RAPPEL_IDLE)
	event_manager.add_event_handler("prepare_trampoline_jump", PREPARE_TRAMPOLINE_JUMP)

func _on_animation_finished():
	lock = false
	emit_signal("animation_finished_component", String(self.animation))
