extends Node2D

var time = 2

func _ready():
	pass
	
func _process(delta):
	time -= delta
	if(time <= 0):
		time = (randi()%3)+2
		print(time)
		var triangulo = get_node("Triangulo").duplicate()
		triangulo.visible = true
		triangulo.set_script(preload("res://Scripts/Jogo1/Triangulo.gd"))
		add_child(triangulo)