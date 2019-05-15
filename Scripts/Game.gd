extends Node2D

var timer = 0	
var jogos = [null,null,null,null]
var quantJogos = 0
var dragging = false
var drag_start = Vector2()

func _ready():
	#jogos[3] = createJogo(4)
	pass

func _input(event):
	if event.is_action_pressed("click") and not dragging:
		dragging = true
		drag_start = get_global_mouse_position()
	if event.is_action_released("click") and dragging:
		dragging = false
		var drag_end = get_global_mouse_position()
		var dir = drag_start - drag_end
		if abs(dir.x) <= 5 and abs(dir.y) <= 5:
			if jogos[0] != null: jogos[0].action()
		else:
			if abs(dir.x) <= abs(dir.y/4):
				if jogos[1] != null: jogos[1].action(dir.y)
			else:
				if abs(dir.y) <= abs(dir.x/4):
					if jogos[3] != null: jogos[3].action(dir.x)
				else:
					if jogos[2] != null: jogos[2].action(sqrt(pow(dir.y,2) + pow(dir.x,2)))
	pass

func createJogo(numJogo):
	var jogo
	if numJogo == 1:
		jogo = preload("res://Scenes/Jogo1.tscn").instance()
	else: 
		if numJogo == 2:
			jogo = preload("res://Scenes/Jogo2.tscn").instance()
		else:
			if numJogo == 3:
				jogo = preload("res://Scenes/Jogo3.tscn").instance()
			else:
				jogo = preload("res://Scenes/Jogo4.tscn").instance()
	jogo.position = Vector2(512 if numJogo%2 == 0 else 0,300 if numJogo >= 3 else 0)
	jogo.connect("game_over",self,"_on_game_over")
	jogo.scale = Vector2(0.5,0.5)
	jogo.z_index = -numJogo
	add_child(jogo)
	return jogo

func _process(delta):
	if delta >= 1:
		_on_game_over()
	else:
		timer += delta
		get_node("score").text = "Score: " + String(int(timer))
		if int(timer)%4 == 0 and quantJogos <= 3 and jogos[int(timer)/4] == null:
			quantJogos += 1
			jogos[int(timer)/4] = createJogo(quantJogos)
	pass

func _on_game_over():
	get_tree().paused = true
	get_node("GameOver").visible = true
	pass

func _on_chance_pressed():
	
	pass

func _on_voltar_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	pass
