extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# check if skip cutscene button was pressed and so how many times
var skipStatus = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Enter"):
		skipStatus += 1 
		
		if skipStatus == 1:
			set_text("Confirm?")
		elif skipStatus == 2:
			get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
	
	pass
