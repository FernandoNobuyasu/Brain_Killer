extends Control

func _ready():
	get_tree().paused = false
	pass

func _on_PlayBtn_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")