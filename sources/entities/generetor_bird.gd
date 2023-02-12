extends Node2D


var MyNode = load("res://scenes/entities/bird_.tscn")

func time():
	randomize()
	var gap_timer = Vector2(2, 5)
	var gap = randi() % int(gap_timer[1]-gap_timer[0]) + 1 + gap_timer[0]
	$Timer.start(gap)
	
	
func birds(range):
	var obstaculo = MyNode.instantiate()
	obstaculo.position.y = range
	add_child(obstaculo)
	time()


func random():
	randomize()
	var y_range = Vector2(-200, 600)
	var range = randi() % int(y_range[1]-y_range[0]) + 1 + y_range[0]
	return range

func _ready():
	birds(random())

func _on_timer_timeout():
	time()
	birds(random())
