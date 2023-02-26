extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.set_text("Aperte novamente para pular")

# check if skip cutscene button was pressed and so how many times
var skipStatus = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("skip_cutscene"):
		skipStatus += 1 
		
		if skipStatus == 1:
			$Label.visible = 1
			
		if skipStatus == 2:
			$Label.set_text("Certeza?")
			
		elif skipStatus == 3:
			get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
