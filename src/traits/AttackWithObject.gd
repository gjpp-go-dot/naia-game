extends Node2D


export (PackedScene) var attackObjectScene = null
export (String) var attackType = "stab"

var direction = Vector2.RIGHT
var attackObject = null

func _process(_delta):
	if Input.is_action_just_pressed("attack_melee") and not is_instance_valid(attackObject):
		attackObject = attackObjectScene.instance()
		add_child(attackObject)

		attackObject.attack(attackType, direction, true)

