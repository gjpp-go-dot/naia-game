extends Area2D

@export var Dialogue:Resource

func _ready():
	add_to_group("npc")
# Called when the node enters the scene tree for the first time.
func start_talk():
	Inventory
