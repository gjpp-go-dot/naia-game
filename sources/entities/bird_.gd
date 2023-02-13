extends Node2D


var  velociade = 200


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x += ((velociade)*self.scale.x)*delta

