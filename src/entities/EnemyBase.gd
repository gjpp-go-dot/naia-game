extends KinematicBody2D

var health = 100
var velocity = Vector2(0, 0)
var smooth = 0.1

func die():
	queue_free()

func hit(damage, directionRadians, strength):
	health -= damage

	$AnimationPlayer.play("hit")

	var direction = Vector2(0, 0)
	direction.x = cos(directionRadians)
	direction.y = sin(directionRadians)
	print(strength)
	strength = clamp(strength, 0, 200)
	velocity = direction * -range_lerp(strength, 0, 200, 0, 368)

	if health <= 0:
		$AnimationPlayer.play("die")
		yield($AnimationPlayer, "animation_finished")
		die()



func _physics_process(delta):
	velocity = velocity.linear_interpolate(Vector2(0, 0), smooth * (delta * 60))
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body: Node):
	if body.get("damage") != null and $AnimationPlayer.get_current_animation() != "hit" and not $AnimationPlayer.is_playing() and $AnimationPlayer.get_current_animation() != "die":
		var directionRadians = atan2(body.global_position.y - global_position.y, body.global_position.x - global_position.x)
		var strength = body.linear_velocity.length()
		hit(body.get("damage"), directionRadians, strength)
