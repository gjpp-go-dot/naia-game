extends Node2D
var first = true
var dia = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$DefaultDialogNode.visible = false




func _on_area_2d_body_entered(body):
	$DefaultDialogNode.visible = true
	var a = Dialogic.start_timeline("timeline",false)
	add_child(a)
