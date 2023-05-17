extends Node2D

var delay = 1.6

func _on_ready():
	$transition/fill/anim.play("transition_out")


func _on_area_2d_body_entered(body):
	$transition/fill/anim.play("transition_in")
	$Timer.start(delay)

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")


func _process(delta):
	if $CanvasLayer.t == 1:
		$SpearCombat.visible = false



func _on_pressure_desparo():
	$Node2D2/trigger.frame = 1
	print("hit")
