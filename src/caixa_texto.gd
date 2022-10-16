extends CanvasLayer
const CHAR_READ_RATE = 0.05
onready var texto_container = $caixaDeTexto
onready var iniciar = $caixaDeTexto/MarginContainer/HBoxContainer/asterisco
onready var finalizar = $caixaDeTexto/MarginContainer/HBoxContainer/proximo
onready var texto = $caixaDeTexto/MarginContainer/HBoxContainer/texto
#estados da text box
enum State {
	PRONTO,
	LENDO,
	TERMINADO,
	INATIVO
}
var estado_atual = State.INATIVO
var texto_fila = []
var id_npc = 0

#fila de textos
func _txt():
	if id_npc == 0:
		print("Estado inicial: State.PRONTO")
		hide_textbox()
		fila_texto("???: Olá, Presidente! Aperte a barra de espaço para continuar falando comigo")
		fila_texto("???: Senhor presidente? qual o motivo de sua visita à nossa cidade?")
		fila_texto("Presidente: Presidente? onde eu estou????")
		fila_texto("???: Mas hoje é primeiro dia do seu mandato, não lembra?")
		fila_texto("Presidente: Pare com essas brincadeiras, onde eu estou e quem é você?")
		fila_texto("???: Oh, desculpe por não me apresentar, meu nome é Ana")
		fila_texto("Ana: Você é o presidente, acho que seu problema de memória te afetou novamente...")
		fila_texto("Presidente: É, eu realmente tenho problema de memória, acho que tinha esquecido disso também...")
		fila_texto("Ana: Senhor presidente, mesmo com memória ou não, noss país está cheio de problemas e você deve trabalhar duro para nos ajudar....")
		fila_texto("Ana: Que tal começar pela nossa cidade?")

	if id_npc == 1:
		print("Estado inicial: State.PRONTO leleo")
		hide_textbox()
		fila_texto("jacare: oi piranha")
		print("aioablin")
	if id_npc == 2:
		print("Estado inicial: State.PRONTO")
		hide_textbox()
		fila_texto("Joana: Eu adoro comprar neste mercado!")
		fila_texto("Joana: É uma pena que os preços estejam tão caros ultimamente...")
		fila_texto("Joana: No fundo do mercado você pode conferir como os preços estão absurdos ")
	elif id_npc == 2 and Global.indexMercado == 17:
		print("Estado inicial: State.PRONTO")
		hide_textbox()
		fila_texto("Joana: Muito obrigado por resolver nosso problema, presidente!")
	if id_npc == 3:
		print("Estado inicial: State.PRONTO")
		hide_textbox()
		fila_texto("Pablo: Oi! está perdendo muitos pontos durante as problemáticas?")
		fila_texto("Pablo: Caso deseje tentar recuperar seus pontos, entre na porta ao lado e jogue o minigame!")
	if id_npc == 4 and Global.index >= 1:
		hide_textbox()
		fila_texto("Leo: Não sei qual foi seu resultado, mas continue procurando estes pontos de exclamação vermelhos e tente responder da melhor forma")
	elif id_npc == 4:
		print("Estado inicial: State.PRONTO")
		hide_textbox()
		fila_texto("Leo: Quando você encontrar estes pontos de exclamação vermelhos, é possivel entrar no edificio em questão para resolver uma problematica.")
		fila_texto("Leo: Olha só, parece que temos um objetivo logo ao nosso lado!")
		fila_texto("Leo: Porque não entra para conferir?")
	if id_npc == 5:
		print("Estado inicial: State.PRONTO")
		hide_textbox()
		fila_texto("Thainá: Olá presidente, estamos passando por diversos problemas em nossa escola...")
		fila_texto("Thainá: Gostaria de entrar para nos ajudar, certo?")
		fila_texto("Thainá: Vá a porta ao meu lado.")
	if id_npc == 6:
		print("Estado inicial: State.PRONTO")
		hide_textbox()
		fila_texto("Mario: Olá senhor presidente")
		fila_texto("Mario: Sou o prefeito desta cidade!")
		fila_texto("Mario: Precisamos de conversar, sente-se na cadeira, por favor!")
	if id_npc == 7:
		print("Estado inicial: State.PRONTO")
		hide_textbox()
		fila_texto("Eliza: Olá senhor presidente")
		fila_texto("Eliza: Preciso da sua ajuda para orientar os alunos da nossa escola!")
		fila_texto("Eliza: Sente-se na cadeira porque já vamos começar nossa aula.")

#mostrar textos e alterar os estados da text box enquanto os textos são lidos
func _process(delta):
	match estado_atual:
		State.INATIVO:
			Global.textbox = 0
			hide_textbox()
		State.PRONTO:
			Global.textbox = 0
			if !texto_fila.empty():
				mostrar_texto()
				get_tree().paused = true
		State.LENDO:
			Global.textbox = 1
			if Input.is_action_just_pressed("ui_accept"):
				texto.percent_visible = 1.0
				$Tween.remove_all()
				finalizar.text = "v"
				mudar_estado(State.TERMINADO)
		State.TERMINADO:
			Global.textbox = 1
			if Input.is_action_just_pressed("ui_accept"):
				mudar_estado(State.PRONTO)
				hide_textbox()
				get_tree().paused = false
#função passar para o proximo texto
func fila_texto(proximo_texto):
	texto_fila.push_back(proximo_texto)
#esconder a text box após o estado terminado ter sido lido
func hide_textbox():
	iniciar.text = ""
	finalizar.text = ""
	texto.text = ""
	texto_container.hide()

#função mostrar a text box
func show_textbox():
	iniciar.text = "*"
	texto_container.show()

#função mostrar texto dentro da text box
func mostrar_texto():
	var proximo_texto = texto_fila.pop_front()
	texto.text = proximo_texto
	texto.percent_visible = 0.0
	mudar_estado(State.LENDO)
	show_textbox()
	$Tween.interpolate_property(texto, "percent_visible", 0.0, 1.0, len(proximo_texto) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
#Printar o estado atual no terminal
func mudar_estado(proximo_estado):
	estado_atual = proximo_estado
	match estado_atual:
		State.PRONTO:
			print("Estado atual: PRONTO")
		State.LENDO:
			print("Estado atual: LENDO")
		State.TERMINADO:
			print("Estado atual: TERMINADO")
		State.INATIVO:
			print("Estado atual: INATIVO")
#Mudar estado para terminado após o text box ser lido completamente

func _on_Tween_tween_completed(object, key):
	finalizar.text = "v"
	mudar_estado(State.INATIVO)

func _on_Area2D_body_entered(body):
	id_npc = 1
	mudar_estado(State.PRONTO)
	_txt()

