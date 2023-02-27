extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.frame = 0
	$Area2D/CollisionShape2D.disabled = false
	$StaticBody2D/CollisionShape2D.disabled = false




func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.name == "Spear" and body.spear_type == 0):
		$AnimatedSprite2D.play("default")
		body.call_back(get_node('/root/Naia'))
		$Area2D/CollisionShape2D.set_deferred('disabled',true)
		$Area2D.set_deferred('monitoring',false)
		$Area2D.set_deferred('monitorable',false)
		$StaticBody2D/CollisionShape2D.set_deferred('disabled',true)
		
