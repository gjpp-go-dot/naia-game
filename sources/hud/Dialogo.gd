extends CanvasLayer

var mys = load("res://assets/sprites/hud/128x128/mystery.png")
var fear = load("res://assets/sprites/hud/128x128/naia_fear.png")
var neutral = load("res://assets/sprites/hud/128x128/naia_neutral.png")
var smile = load("res://assets/sprites/hud/128x128/naia_smile.png")
var surprise = load("res://assets/sprites/hud/128x128/naia_suprise.png")
var spear = load("res://assets/sprites/hud/128x128/spear_spirit.png")

var name1 = ["[color=black]...[/color]","Tainá","[color=black]...[/color]","Tainá","Tainá","[color=black]...[/color]",
"[color=black]...[/color]","[color=#177e75]Lança[/color]","Tainá","[color=#177e75]Lança[/color]","[color=#177e75]Lança[/color]",
"[color=#177e75]Lança[/color]","Tainá","Tainá","[color=#177e75]Lança[/color]","Tainá","[color=#177e75]Lança[/color]","Tainá","."]
var text1 = ["Hã? Quem é você? O que faz aqui?","Espera, de onde vem essa voz? Tem alguém aqui?",
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
"Então levarei você comigo até o meu povo.","."]
var image1 = [mys,surprise,mys,fear,neutral,mys,mys,spear,neutral,spear,spear,spear,surprise,neutral,spear,
fear,spear,neutral,mys]

var name2 = ["[color=#177e75]Lança[/color]","[color=#177e75]Lança[/color]","."]
var text2 = ["Ah, se algum obstáculo aparecer, você pode [color=blue][wave amp=40 freq=2]clicar com o botão direito do mouse[/wave][/color] para mirar e depois [color=blue][wave amp=40 freq=2]clique com o botão esquerdo do mouse[/wave][/color] para me lançar em alguma superfície.",
"Para me pegar de volta, é só [color=blue][wave amp=40 freq=2]clicar com o botão direito do mouse[/wave][/color].","."]
var image2 = [spear,spear,mys]

var name3 = ["[color=#177e75]Lança[/color]","."]
var text3 = ["Hmm acho que posso te ajudar! Ao mirar, selecione a lança verde com o [color=blue][wave amp=40 freq=2]scroll do mouse[/wave][/color], tente me lançar perto do topo da superfície e segure a [color=blue][wave amp=40 freq=2]tecla W[/wave][/color] para subir no rapel.","."]
var image3 = [spear,mys]

var name4 = ["[color=#177e75]Lança[/color]","."]
var text4 = ["Ei, aqui você pode me usar para subir em superfícies mais altas. Ao mirar, selecione a lança vermelha com o [color=blue][wave amp=40 freq=2]scroll do mouse[/wave][/color], atire em algum lugar e [color=blue][wave amp=40 freq=2]segure espaço[/wave][/color] para usar como um trampolim.", "."]
var image4 = [spear,mys]

var name5 = ["[color=#177e75]Lança[/color]","."]
var text5 = ["Para você saber, caso você tenha que quebrar obstáculos, jogue a lança branca neles","."]
var image5 = [spear,mys]

var name6 = ["[color=#177e75]Lança[/color]","."]
var text6 = ["Você sabia que com o meu poder, agora você pode pular entre paredes? Basta pular em uma parede e [color=blue][wave amp=40 freq=2]apertar espaço[/wave][/color]! Sorte sua que estou aqui! ","."]
var image6 = [spear,mys]

var click = 0
var t = 0
var first = [true,true,true,true,true,true]

func apertou():
	if Input.is_action_just_pressed("spear_throw") and $Box.visible == true:
		click += 1

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
	if t == 1 and first[0] == true:
		d1()
	elif t == 2 and first[1] == true:
		d2()
	elif t == 3 and first[2] == true:
		d3()
	elif t == 4 and first[3] == true:
		d4()
	elif t == 5 and first[4] == true:
		d5()
	elif t == 6 and first[5] == true:
		d6()
	
func d1():
	
	$Box.visible = true
	get_tree().paused = true
	if name1[click] != ".":
		sub(name1[click],text1[click],image1[click])
		apertou()
	else:
		$Box.visible = false
		click = 0
		t = 0
		first[0] = false
		get_tree().paused = false
		

func d2():
	$Box.visible = true
	get_tree().paused = true
	if name2[click] != ".":
		sub(name2[click],text2[click],image2[click])
		apertou()
	else:
		$Box.visible = false
		click = 0
		t = 0
		first[1] = false
		get_tree().paused = false

func d3():
	$Box.visible = true
	get_tree().paused = true
	if name3[click] != ".":
		sub(name3[click],text3[click],image3[click])
		apertou()
	else:
		$Box.visible = false
		click = 0
		t = 0
		first[2]
		get_tree().paused = false
	
func d4():
	$Box.visible = true
	get_tree().paused = true
	if name4[click] != ".":
		sub(name4[click],text4[click],image4[click])
		apertou()
	else:
		$Box.visible = false
		click = 0
		t = 0
		first[3]
		get_tree().paused = false

func d5():
	get_tree().paused = true
	$Box.visible = true
	if name5[click] != ".":
		sub(name5[click],text5[click],image5[click])
		apertou()
	else:
		$Box.visible = false
		click = 0
		t = 0
		first[4] = false
		get_tree().paused = false
		
func d6():
	get_tree().paused = true
	$Box.visible = true
	if name6[click] != ".":
		sub(name6[click],text6[click],image6[click])
		apertou()
	else:
		$Box.visible = false
		click = 0
		t = 0
		first[5] = false
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
