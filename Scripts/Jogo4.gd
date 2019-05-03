extends Node2D

var dragging
var drag_start = Vector2()
var dir = Vector2()
var startPos 
var timer = 0
var certo

func _input(event):
	if event.is_action_pressed("click") and not dragging:
		dragging = true
		drag_start = get_global_mouse_position()
	if event.is_action_released("click") and dragging:
		dragging = false
		var aux
		if(get_node("slide").position.x <= get_node("true").position.x):
			aux = 0
		if(get_node("slide").position.x >= get_node("false").position.x):
			aux = 1
		if(certo == aux):
			get_node("timer").text = "10s"
			nova_equacao()
		else:
			game_over()
		get_node("slide").position = startPos
	pass

func _ready():
	randomize()
	nova_equacao()
	startPos = get_node("slide").position
	pass

func _process(delta):
	if(dragging):
		get_node("slide").position.x = (startPos - drag_start + get_global_mouse_position()).x
		if(get_node("slide").position.x < get_node("true").position.x):
			get_node("slide").position.x = get_node("true").position.x
		if(get_node("slide").position.x > get_node("false").position.x):
			get_node("slide").position.x = get_node("false").position.x
	
	timer += delta
	var time = int(get_node("timer").text)
	if time == 0:
		game_over()
	else:
		if timer >= 1:
			get_node("timer").text = ("0" if time <= 10 else "") + String(time-int(timer)) + "s"
			timer -= 1
	pass

func nova_equacao():
	var a = randi()%200
	var b = randi()%200
	var op = randi()%2
	var result
	if(!op):
		result = a + b
	else:
		result = a - b
	certo = randi()%2
	if(certo):
		result += (-1 if randi()%2 else 1) * (randi()%100 + 1)
	get_node("equacao").text = String(a) + (" + " if !op else " - ") + String(b) + " = " + String(result)
	pass

func game_over():
	print("alo")
	pass