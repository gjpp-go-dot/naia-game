extends KinematicBody2D
var flip = true
var posicao_inicial
var posicao_final #distância que o bloco pode percorrer a mais 
var velocidade = 1 #velocidade horizontal do bloco (mais baixa)
var limite #intervalo que o bloco pode percorrer 
func _ready():
	posicao_inicial = self.position.y
	posicao_final = 100 
	limite = posicao_inicial + posicao_final #posição até onde o corpo pode se mover no eixo x
func _process(delta):
	if (self.position.y >= limite): #se a posição for maior do que o limite
		flip = true
	elif (self.position.y <= posicao_inicial):
		flip = false
	if (flip): 
		self.position.y -= velocidade #altera o sentido da velocidade se o flip for ativo
	else:
		self.position.y += velocidade #permanece inalterado
