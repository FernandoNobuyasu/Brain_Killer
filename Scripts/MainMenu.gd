extends Control

func _ready():
	get_tree().paused = false
	carregarTexto()
	pass

func carregarTexto():
	if get_node("/root/Global").linguagem:
		get_node("HighScore").text = "HighScore:"
		get_node("PlayBtn").text = "Play"
		get_node("HSBtn").text = "HighScores"
		get_node("Help").text = "How to Play"
	else:
		get_node("HighScore").text = "Pontuação:"
		get_node("PlayBtn").text = "Jogar"
		get_node("HSBtn").text = "Pontuações"
		get_node("Help").text = "Como Jogar"

func _on_PlayBtn_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")

func _on_voltar_pressed():
	get_node("Panel").visible = false
	pass

func _on_Help_pressed():
	get_node("Panel").visible = true
	pass


func _on_HSBtn_pressed():
	pass # Replace with function body.


func _on_LanguageBtn_pressed():
	get_node("/root/Global").mudarLinguagem();
	carregarTexto()
	pass


func _on_SoundBtn_pressed():
	pass # Replace with function body.
