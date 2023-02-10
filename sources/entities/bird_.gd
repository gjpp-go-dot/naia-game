extends Node2D


var  velociade = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate = Color(1, 1, 1, self.scale.x)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x += ((velociade)*self.scale.x)*delta

