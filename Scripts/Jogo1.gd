extends Node2D

var jump_speed = -800
var gravity = 1200

var velocity = Vector2()
var jumping = false

func action():
	velocity.x = 0
	if get_node("Player").is_on_floor():
		jumping = true
		velocity.y = jump_speed

func _physics_process(delta):
	for i in range(0,get_node("Player").get_slide_count()):
		if get_node("Player").get_slide_collision(i).collider.is_class("KinematicBody2D"):
			game_over()
	velocity.y += gravity * delta
	if jumping and get_node("Player").is_on_floor():
		jumping = false
	velocity = get_node("Player").move_and_slide(velocity, Vector2(0, -1),false,1)

signal game_over

func game_over():
	emit_signal("game_over")
	pass