extends Node2D

var start = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$transition/fill/anim.play("transition_out")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !start:
		await get_tree().create_timer(2).timeout
		start = true
	if $VBoxContainer.position.y != -2025 && start:
		$VBoxContainer.position.y -= 1
	elif $VBoxContainer.position.y == -2025 && start:
		transition()

func transition():
	$transition/fill/anim.play("transition_in")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/hud/MenuIni.tscn")
	

