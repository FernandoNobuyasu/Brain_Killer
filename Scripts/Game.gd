extends Node2D

var timer = 0

func _ready():
	pass

func _process(delta):
	if delta >= 1:
		game_over()
	else:
		timer += delta
		get_node("score").text = "Score: " + String(int(timer))
	pass

func game_over():
	pass