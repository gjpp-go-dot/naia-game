extends KinematicBody2D

var health = 100
var velocity = Vector2(0, 0)
var smooth = 0.1

func die():
	queue_free()

func hit(damage, directionRadians):
	health -= damage

	$AnimationPlayer.play("hit")

	# Set the direction of the hit
	var direction = Vector2(0, 0)
	direction.x = cos(directionRadians)
	direction.y = sin(directionRadians)
	velocity = direction * -256

	#if health <= 0:
	#	die()

func _physics_process(delta):
	velocity = velocity.linear_interpolate(Vector2(0, 0), smooth * (delta * 60))
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body: Node):
	print("Child entered tree: ", body)
	if body.get("damage") != null:
		var directionRadians = atan2(body.global_position.y - global_position.y, body.global_position.x - global_position.x)
		hit(body.get("damage"), directionRadians)
