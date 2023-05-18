extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$trigger.frame = 0



func desparar(a):
	for n in a:
		$trigger.frame = 1
		var seta_spawn = preload("res://scenes/objects/seta.tscn")
		var seta_ = seta_spawn.instantiate()
		seta_.position.x -= 20
		self.add_child(seta_)
		await get_tree().create_timer(1).timeout
		$trigger.frame = 0
		await get_tree().create_timer(1).timeout


		
