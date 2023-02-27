extends Node2D

@export var lado = "D"
@export var vel = 800

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lado == "D":
		$anim.flip_h = false
		self.position.x += vel*delta
	elif lado == "A":
		$anim.flip_h = true
		self.position.x -= vel*delta
