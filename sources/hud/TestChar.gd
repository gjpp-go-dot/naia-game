extends CharacterBody2D


@onready var ray = $RayCast2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var canMove = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		$CanvasLayer/Pausa.pause()

func _physics_process(delta):
	if canMove == true:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta

		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
		
		if Input.is_action_just_pressed("dialogic_default_action"):
			interact()
		
func interact():
	if ray.is_colliding() == false:
		return
	var obj = ray.get_collider()
	if obj.is_in_group("npc"):
		obj.start_talk()
		
