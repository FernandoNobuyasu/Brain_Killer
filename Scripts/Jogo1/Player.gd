extends KinematicBody2D

var currentPos = 1

func get_input():
	if(event.is_action_pressed("click")):
		if(get_global_mouse_position().y <= 300):
			if(currentPos != 0):
				get_node(
		else:
			

func _physics_process(delta):
    get_input()
    velocity.y += gravity * delta
    if jumping and is_on_floor():
        jumping = false
    velocity = move_and_slide(velocity, Vector2(0, -1))