extends Node2D

var inside = false

func _ready():
	if Global.checkpoint[0][0]:
		$personagem.position = Vector2(304,288)
	elif Global.checkpoint[0][1]:
		$personagem.position = Vector2(2480,288)
	elif Global.checkpoint[0][2]:
		$personagem.position = Vector2(5656,288)
	$personagem/Camera2D.limit_left = 0
	$personagem/Camera2D.limit_right = 7168
	Global.checkpoint[0][0] = true

func _process(delta):
	for i in range(1,5):
		if get_node('bloco_vertical'+str(i)).position.y >= 480: 
			get_node('bloco_vertical'+str(i)).position.y = 96
	
	
	



func _on_Area2D_area_entered(area):
	inside = true
	Global.count = Global.points


func _on_Death_area_entered(area):
	get_tree().change_scene("res://scenes/Menus e utilitarios/Gameover.tscn")




func _on_Death2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	get_tree().change_scene("res://scenes/Menus e utilitarios/Gameover.tscn")


func _on_Death3_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	get_tree().change_scene("res://scenes/Menus e utilitarios/Gameover.tscn")


func _on_Death4_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	get_tree().change_scene("res://scenes/Menus e utilitarios/Gameover.tscn")


func _on_Check1_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	Global.checkpoint[0][0] = false
	Global.checkpoint[0][1] = true
	Global.count = Global.points


func _on_Check2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	Global.checkpoint[0][1] = false
	Global.checkpoint[0][2] = true
	Global.count = Global.points
