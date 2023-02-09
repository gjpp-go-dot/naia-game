extends Node2D

var start_position = Vector2(0,0)
var modulate_tween = null
var size_tween = null

var on_max_size_y = false

const INCREMENT_CONSTANT = 0.9

func set_start_position(vine_start_position):
	start_position = vine_start_position

func kill_vine():
	if  modulate_tween:
		modulate_tween.kill()
	modulate_tween = create_tween()
	modulate_tween.tween_property(get_node("Vine"), "modulate", Color(1,1,1,0), 0.4)
	queue_free()

func show_vine():
	if  modulate_tween:
		modulate_tween.kill()
	modulate_tween = create_tween()
	modulate_tween.tween_property(get_node("Vine"), "modulate", Color(1,1,1,1), 0.4)

func start_fall_vine():
	on_max_size_y = false

func _ready():
	get_node("Vine").size.y = 0
	get_node("VineArea/CollisionShape2D").shape.size.y = 0
	set_start_position(global_position)
	show_vine()
	start_fall_vine()

func _process(_delta):
	if not on_max_size_y:
		get_node("Vine").size.y += INCREMENT_CONSTANT
		get_node("VineArea/CollisionShape2D").shape.size.y += INCREMENT_CONSTANT * 2
		get_node("VineArea").position.y += INCREMENT_CONSTANT

func _on_vine_area_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	if _body.get_name() == "Naia":
		_body.set("can_rappel", true)
		_body.set("vine_x_position", global_position.x)
	else:
		on_max_size_y = true

func _on_vine_area_body_shape_exited(_body_rid, _body, _body_shape_index, _local_shape_index):
	if _body.get_name() == "Naia":
		_body.set("can_rappel", false)
		_body.set("vine_x_position", global_position.x)
