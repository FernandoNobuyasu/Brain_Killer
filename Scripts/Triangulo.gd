extends Node2D

var velocidade = -200;

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	translate(Vector2(velocidade,0)*delta)
	if(position[0] <= -20):
		free()