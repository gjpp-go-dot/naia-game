extends KinematicBody2D

const up = Vector2(0, -1) #Essa constante aqui serve para definir onde está o chão
const gravidade = 20 #Força da gravidade
const velocidade = 220 #Velocidade do personagem
const jump_force = -600 #Força do pulo do personagem
onready var spear_attack = $Area2D
var time_attack = 0
enum {CALM, ATTACK}
var state = CALM
var motion = Vector2() #Vector2 é um tipo que aceita dois números do tipo float. Usado sempre que falamos de movimentação... pq é basicamente o X e o Y
var initial_pos
var invulnerabilidade
var direction
func _ready():
	initial_pos = self.position
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"): #movimentaçãoo para a direita
		motion.x = velocidade
	elif Input.is_action_pressed("ui_left"):#movimentação para a esquerda
		motion.x = -velocidade
	else:
		motion.x = 0  #para o personagem
	if is_on_floor(): #Verifica se o avatar está em contato com o chão
		if Input.is_action_pressed("ui_up"):
			$jumpfx.play()
			impulso()

	else:
		motion.y += gravidade
	motion = move_and_slide(motion, up) #Função que move e mantem movendo o objeto enquanto o jogador aperta o botão / Colocando que motion é igual a essa função ele vai ta zerando a gravidade toda vez que essa função for chamada

	if Input.is_action_just_pressed("ui_accept"):
		state = ATTACK

	match state:
		CALM:
			spear_attack.visible = false

		ATTACK:
			spear_attack.visible = true
			time_attack += delta
			if time_attack >= 0.4:
				time_attack = 0
				state = CALM


	# detectar contato com plataformas
	for platforms in get_slide_count():
		var collision = get_slide_collision(platforms)
		if collision.collider.has_method("collide_with"):
			collision.collider.collide_with(collision, self)

	if Global.vida == 0:
		game_over()

func impulso(num = 1):
	motion.y = num * jump_force

func sofrer_dano():
	if invulnerabilidade != true:
		Global.vida -=1
	invulnerabilidade = true
	yield(get_tree().create_timer(0.7), "timeout")
	invulnerabilidade = false

func game_over():
	get_tree().change_scene("res://scenes/Menus e utilitarios/Gameover.tscn")

func _process(delta):
	$jumpfx.volume_db = GlobalOpcoes.controlSFX(5,-35)
