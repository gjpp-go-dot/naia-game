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
	if id_npc == 1:
		hide_textbox()
		fila_texto("Siga em frente para conhecer Jaci")
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

