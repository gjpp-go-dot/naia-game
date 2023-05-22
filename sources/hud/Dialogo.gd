extends CanvasLayer

var mys = load("res://assets/sprites/hud/128x128/mystery.png")
var fear = load("res://assets/sprites/hud/128x128/naia_fear.png")
var neutral = load("res://assets/sprites/hud/128x128/naia_neutral.png")
var smile = load("res://assets/sprites/hud/128x128/naia_smile.png")
var surprise = load("res://assets/sprites/hud/128x128/naia_suprise.png")
var spear = load("res://assets/sprites/hud/128x128/spear_spirit.png")

var diag = {
	1 : {
		"name": ["[color=black]...[/color]",
			"Tainá",
			"[color=black]...[/color]",
			"Tainá",
			"Tainá",
			"[color=black]...[/color]",
			"[color=black]...[/color]",
			"[color=#177e75]Lança[/color]",
			"Tainá",
			"[color=#177e75]Lança[/color]",
			"[color=#177e75]Lança[/color]",
			"[color=#177e75]Lança[/color]",
			"Tainá",
			"Tainá",
			"[color=#177e75]Lança[/color]",
			"Tainá",
			"[color=#177e75]Lança[/color]",
			"Tainá",
			"."],
		"text": ["Hã? Quem é você? O que faz aqui?","Espera, de onde vem essa voz? Tem alguém aqui?",
			"Hmm, que estranho, não vejo pessoas aqui há tanto tempo... Apenas responda, qual o seu nome?",
			"Isso é muito estranho...", "Bem, meu nome é Tainá, eu nem sei se deveria estar te contando quem eu sou, se não sei quem você é.",
			"Tainá... Eu sou aquele que foi amaldiçoado com a existência eterna, fui condenado com a missão de acompanhar grandes guerreiras ao longo dos milênios, eu vi a guerra e também a paz.",
			"Mas no final, todas têm o mesmo destino.","Eu sou o espírito que habita esta lança. E o que você faz aqui?",
			"Na verdade, eu não sei... Eu estava a caminho da minha vila mas me perdi, até que eu encontrei este lugar e senti que deveria entrar... como se algo neste lugar me atraísse.",
			"Não me surpreende, este lugar é sagrado. Uma lenda rege a existência deste lugar... Durante os milênios, sempre que a Lua é ameaçada, uma guerreira é escolhida para defender a nossa sociedade e trazer a paz.",
			"O meu destino sempre foi acompanhá-las, mas o final da jornada nunca se tornou mais fácil. Existem pedaços de suas histórias perdidas por essa terra, talvez você as encontre em algum momento.",
			"A verdade é que eu não tenho mais utilidade, minha missão parece ter se encerrado, mas eu continuo aqui.",
			"Nossa, eu nunca ouvi falar nessa lenda...","Enfim, já está tarde e eu preciso voltar para minha vila, você quer que eu lhe deixe onde o encontrei?",
			"Eu não tenho mais utilidade nesse local, seria mais útil ir lhe acompanhando... Sinto que o perigo está se aproximando nessa noite.",
			"Perigo???... Como assim?","Aconteceram coisas ruins em todas as vezes que despertei.",
			"Então levarei você comigo até o meu povo.",
			"."],
		"image": [mys,surprise,mys,fear,neutral,mys,mys,spear,neutral,spear,spear,spear,surprise,neutral,spear,fear,spear,neutral,mys]
	},
	2:{
		"name": ["[color=#177e75]Lança[/color]",
			"[color=#177e75]Lança[/color]",
			"."],
		"text": ["Ah, se algum obstáculo aparecer, você pode [color=blue][wave amp=40 freq=2]clicar com o botão direito do mouse[/wave][/color] para mirar e depois [color=blue][wave amp=40 freq=2]clique com o botão esquerdo do mouse[/wave][/color] para me lançar em alguma superfície.",
			"Para me pegar de volta, é só [color=blue][wave amp=40 freq=2]clicar com o botão direito do mouse[/wave][/color].",
			"."],
		"image": [spear,spear,mys]
	},
	3:{
		"name": ["[color=#177e75]Lança[/color]",
			"."],
		"text": ["Hmm acho que posso te ajudar! Ao mirar, selecione a lança verde com o [color=blue][wave amp=40 freq=2]scroll do mouse[/wave][/color], tente me lançar perto do topo da superfície e segure a [color=blue][wave amp=40 freq=2]tecla W[/wave][/color] para subir no rapel.",
			"."],
		"image": [spear,mys]
	},
	4:{
		"name":["[color=#177e75]Lança[/color]",
			"."],
		"text": ["Ei, aqui você pode me usar para subir em superfícies mais altas. Ao mirar, selecione a lança vermelha com o [color=blue][wave amp=40 freq=2]scroll do mouse[/wave][/color], atire em algum lugar e [color=blue][wave amp=40 freq=2]segure espaço[/wave][/color] para usar como um trampolim.",
			"."],
		"image": [spear,mys]
	},
	5:{
		"name":["[color=#177e75]Lança[/color]",
			"."],
		"text": ["Para você saber, caso você tenha que quebrar obstáculos, jogue a lança branca neles",
			"."],
		"image": [spear,mys]
	},
	6:{
		"name":["[color=#177e75]Lança[/color]",
			"."],
		"text": ["Você sabia que com o meu poder, agora você pode pular entre paredes? Basta pular em uma parede e [color=blue][wave amp=40 freq=2]apertar espaço[/wave][/color]! Sorte sua que estou aqui! ",
			"."],
		"image": [spear,mys]
	}
}

var click = 0
var t = 1
var first = [true,true,true,true,true,true]
var count = 0
var inter = 0




func apertou():
	if Input.is_action_just_pressed("spear_throw") and $Box.visible == true:
		click += 1
		await get_tree().create_timer(0.2).timeout 

func sub(name,text,img):
	$Box/Text.visible = false
	$Box/Name.visible = false
	$Box/Image.visible = false
	$Box/Text.text = text
	$Box/Name.text = name
	$Box/Image.texture = img
	$Box/Text.visible = true
	$Box/Name.visible = true
	$Box/Image.visible = true
	
func _process(delta):
	if t > 0 and first[t-1] == true:
		displayDiag(t,delta)
	

func nextChar(i,delta,time):
	var step = int(time*60)
	if count%step == 0 and $Box/Text.visible_characters != len(diag[i]["text"][click]):
		$Box/Text.visible_characters = count/step
	elif click != inter:
		$Box/Text.visible_characters = 0
		inter = click
		count = 0
	count += 1
	
func displayDiag(i,delta):
	if $Box != null:
		$Box.visible = true
		get_tree().paused = true
		if diag[i]["name"][click] != ".":
			sub(diag[i]["name"][click], diag[i]["text"][click], diag[i]["image"][click])
			nextChar(i,delta,0.05)
			apertou()
		else:
			$Box.visible = false
			click = 0
			t = 0
			first[i-1] = false
			get_tree().paused = false
	
func _on_area_2d_2_body_entered(body):
	t = 1


func _on_area_2d_3_body_entered(body):
	t = 2


func _on_area_2d_4_body_entered(body):
	t = 3


func _on_area_2d_5_body_entered(body):
	t = 4


func _on_area_2d_6_body_entered(body):
	t = 5


func _on_area_2d_7_body_entered(body):
	t = 6
