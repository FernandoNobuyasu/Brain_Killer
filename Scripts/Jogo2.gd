extends Node2D
	
var dragging
var drag_start = Vector2()
var timer = 0
onready var circulo = get_node("RigidBody2D")

func _ready():
	pass

func _process(delta):
	if get_node("Label").visible == true:
		timer += delta
		var time = int(get_node("Label").text)
		if time == 0:
			game_over()
		else:
			if timer >= 1:
				get_node("Label").text = ("0" if time <= 10 else "") + String(time-int(timer)) + "s"
				timer -= 1
	pass

func game_over():
	pass

func startTimer():
	get_node("Label").visible = true
	get_node("Label").text = "05s"
	pass

func stopTimer():
	get_node("Label").visible = false
	pass

func _physics_process(delta):
	if get_node("RigidBody2D").angular_velocity > 0:
		get_node("RigidBody2D").angular_velocity -= delta * 10
		if get_node("RigidBody2D").angular_velocity <= 0:
			get_node("RigidBody2D").angular_velocity = 0
			startTimer()
	pass

func _input(event):
	print(get_node("RigidBody2D").angular_velocity)
	if event.is_action_pressed("click") and not dragging:
		dragging = true
		drag_start = get_global_mouse_position()
	if event.is_action_released("click") and dragging:
		dragging = false
		var drag_end = get_global_mouse_position()
		var dir = drag_start - drag_end
		if dir.x != 0 and get_node("Label").visible == true:
			stopTimer()
		if get_node("RigidBody2D").angular_velocity + abs(dir.x) < 50:
			get_node("RigidBody2D").add_torque(abs(dir.x))
		else:
			get_node("RigidBody2D").angular_velocity = 50