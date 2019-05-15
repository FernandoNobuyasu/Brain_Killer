extends Node2D

var playerPos = 1
var timeSpawn = 5
var time = 0

func _ready():
	randomize()
	pass

func action(dir): # y
	if dir > 0 and playerPos != 0:
		playerPos -= 1
		get_node("Player").position = get_node("roads/Loc"+String(playerPos)).position
	if dir < 0 and playerPos != 2:
		playerPos += 1
		get_node("Player").position = get_node("roads/Loc"+String(playerPos)).position
	pass

#func _input(event):
#	if event.is_action_pressed("click") and not dragging:
#		dragging = true
#		drag_start = get_global_mouse_position()
#	if event.is_action_released("click") and dragging:
#		dragging = false
#		var drag_end = get_global_mouse_position()
#		var dir = drag_start - drag_end
#		if dir.y > 0 and playerPos != 0:
#			playerPos -= 1
#			get_node("Player").position = get_node("roads/Loc"+String(playerPos)).position
#		if dir.y < 0 and playerPos != 2:
#			playerPos += 1
#			get_node("Player").position = get_node("roads/Loc"+String(playerPos)).position
#	pass

func _physics_process(delta):
	get_node("Player").move_and_slide(Vector2(0,0))
	if(get_node("Player").get_slide_count() >= 1):
		game_over()
	time += delta
	if time >= timeSpawn:
		time = 0
		spawn()
	pass

func spawn():
	var quant = randi()%2 + 1
	var cars = [randi()%3]
	if quant == 2:
		cars.append((cars[0] + randi()%2 + 1) % 3)
	for i in cars:
		var car = get_node("enemy").duplicate()
		car.set_script(preload("res://Scripts/Jogo1/Triangulo.gd"))
		car.position = get_node("spawnLocations/Loc"+String(i)).position
		add_child(car)
	pass

signal game_over

func game_over():
	emit_signal("game_over")
	pass