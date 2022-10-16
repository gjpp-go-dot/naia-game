extends KinematicBody2D

var flip = true
var posicaoInicial
var posicaoFinal #distância que o bloco pode percorrer a mais
var velocidade = 2
var limite #intervalo que o bloco pode percorrer

func _ready():
	posicaoInicial = self.position.x #posição atual do bloco no momento em que o jogo está operando
	posicaoFinal = 320
	limite = posicaoInicial + posicaoFinal #posição até onde o corpo pode se mover no eixo x

func _process(_delta):
	if (self.position.x >= limite): #se a posição for maior do que o limite
		flip = true
	elif (self.position.x <= posicaoInicial):
		flip = false
	if (flip):
		self.position.x -= velocidade #altera o sentido da velocidade se o flip for ativo
	else:
		self.position.x += velocidade #permanece inalterado

func collide_with(_collision: KinematicCollision2D, collider: KinematicBody2D):
	collider.sofrer_dano()

func morrer():
	queue_free()
