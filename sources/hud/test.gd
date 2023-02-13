extends Node2D


@export var Balloon: PackedScene
@export var title: String = "start"
@export var dialogue_resource: DialogueResource


func _ready():
	DialogueManager.dialogue_finished.connect(_on_dialogue_finished)
	
	await get_tree().create_timer(0.4).timeout
	show_dialogue(title)


func show_dialogue(key: String) -> void:
	assert(dialogue_resource != null, "\"dialogue_resource\" property needs a to point to a DialogueResource.")

	var balloon: Node = (Balloon).instantiate()
	add_child(balloon)
	balloon.start(dialogue_resource, key)


### Signals


func _on_dialogue_finished():
	await get_tree().create_timer(0.4).timeout
	get_tree().quit()
