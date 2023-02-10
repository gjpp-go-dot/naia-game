extends CanvasLayer

var resource
var lines = {}

@onready var speaker = $Box/Detail/Speaker
@onready var box = $Box
@onready var text = $Box/Detail/Text
@onready var buttons = $Box/Detail/Buttons
@onready var ref = $Box/Ref

var selection = false
var totalchar = 0
var typing = false
var nchar = 0
@export var speed = 40

func _ready():
	DialogueManager.dialogue_finished.connect(end)

func start(dia,star):
	resource = dia
	lines = await DialogueManager.get_next_dialogue_line(resource)
	update()
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if typing == false:
			if selection == false:
				next(lines.next_id)
			else:
				var first = lines.responses[0].next_id
				next(first)
	window(delta)

func window(delta):
	if nchar < totalchar:
		nchar += speed*delta
		text.visible_characters = nchar
	else:
		typing = false

func update():
	if lines.is_empty():
		return
	speaker.text = lines.character
	text.text = lines.text
	clear()
	options()
	totalchar = text.get_total_character_count()
	text.visible_characters = 0
	nchar = 0
	typing = true
	
func options():
	if lines.responses.size() > 0:
		selection = true
	else:
		selection = false
	var response = lines.responses
	for i in response.size():
		var opt = ref.duplicate()
		buttons.add_child(opt)
		opt.show()
		opt.text = response[i].text
		set_response(opt,response[i].next_id)
		if i == 0:
			opt.grab_focus()

func clear():
	for c in buttons.get_children():
		c.queue_free()
		
func set_response(ob,ni):
	ob.pressed.connect(next.bind(ni))
	
func next(ni):
	lines = await DialogueManager.get_next_dialogue_line(resource,ni)
	update()
	


func end():
	queue_free()
