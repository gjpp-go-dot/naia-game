extends KinematicBody2D

var health = 100
var velocity = Vector2(0, 0)
var smooth = 0.1

func die():
	queue_free()

func effect_hit(damage, directionRadians, strength):
	health -= damage

	$AnimationPlayer.play("hit")

	var direction = Vector2(0, 0)
	direction.x = cos(directionRadians)
	direction.y = sin(directionRadians)

	strength = clamp(strength, 0, 300)
	velocity = direction * -range_lerp(strength, 0, 300, 0, 368)

	if health <= 0:
		$AnimationPlayer.play("die")
		yield($AnimationPlayer, "animation_finished")
		die()


func _physics_process(delta):
	velocity = velocity.linear_interpolate(Vector2(0, 0), smooth * (delta * 60))
	velocity = move_and_slide(velocity)

func hit(body):
	if body.get("damage") != null and $AnimationPlayer.get_current_animation() != "hit" and not $AnimationPlayer.is_playing() and $AnimationPlayer.get_current_animation() != "die":
		var directionRadians = atan2(body.global_position.y - global_position.y, body.global_position.x - global_position.x)
		var strength = 0;
		if body.linear_velocity.length() > 0:
			strength = body.linear_velocity.length() / body.linear_velocity.normalized().dot(Vector2(cos(directionRadians), sin(directionRadians)))
		elif body.linear_velocity.length() == 0:
			strength = 150

		effect_hit(body.get("damage"), directionRadians, abs(strength))
