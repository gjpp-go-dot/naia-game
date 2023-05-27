extends Node2D

var delay = 1.6

func _on_ready():
	$transition/fill/anim.play("transition_out")
	

func _on_area_2d_body_entered(body):
	$transition/fill/anim.play("transition_in")
	$Timer.start(delay)

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")


func _on_area_2d_2_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	$SpearCombat.visible = false
