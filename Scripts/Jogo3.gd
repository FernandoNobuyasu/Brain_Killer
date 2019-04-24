extends Node2D

var dragging
var drag_start = Vector2()
var playerPos = 1

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("click") and not dragging:
		dragging = true
		drag_start = get_global_mouse_position()
	if event.is_action_released("click") and dragging:
		dragging = false
		var drag_end = get_global_mouse_position()
		var dir = drag_start - drag_end
		if dir.y > 0 and playerPos != 0:
			playerPos -= 1
			get_node("Player").position = get_node("roads/Loc"+String(playerPos)).position
		if dir.y < 0 and playerPos != 2:
			playerPos += 1
			get_node("Player").position = get_node("roads/Loc"+String(playerPos)).position
	pass