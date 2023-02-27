extends Node2D
var first = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$DefaultDialogNode.visible = false

func sla():
	$CharacterBody2D.canMove = false
	$DefaultDialogNode.visible = true
	Dialogic.start_timeline("ini",false)
	first = false
	Dialogic.connect("timeline_ended",oi)


func oi():
		$CharacterBody2D.canMove = true


func _on_area_2d_body_entered(body):
	if first == true:
		sla()
