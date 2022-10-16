extends KinematicBody2D

var velocidade = 1.28 #velocidade horizontal do bloco (mais baixa)

func _process(delta):
		self.position.y += velocidade #permanece inalterado
