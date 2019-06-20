extends Control

func _ready():
	get_tree().paused = false
	carregarTexto()
	pass

func carregarTexto():
	get_node("HighScore/score").text = String(get_node("/root/Global").savedInfo["Scores"])
	if get_node("/root/Global").savedInfo["Linguagem"]:
		get_node("HBoxContainer/LanguageBtn").icon = preload("res://Sprites/us-icon.png")
		get_node("HighScore").text = "Highscore:"
		get_node("PlayBtn").text = "Play"
		get_node("HSBtn").text = "Highscores"
		get_node("Panel/Tutorial1").text = "Tap the screen to jump the triangles"
		get_node("Panel/Tutorial2").text = "Swipe up and down to dodge the squares"
		get_node("Panel/Tutorial3").text = "Swipe diagonally to make the spiral spin, don't let it stand still for 10s"
		get_node("Panel/Tutorial4").text = "Swipe right if the equation is correct and left if it is wrong"
	else:
		get_node("HBoxContainer/LanguageBtn").icon = preload("res://Sprites/br-icon.png")
		get_node("HighScore").text = "Pontuação:"
		get_node("PlayBtn").text = "Jogar"
		get_node("HSBtn").text = "Pontuações"
		get_node("Panel/Tutorial1").text = "Toque na tela para pular os triângulos"
		get_node("Panel/Tutorial2").text = "Arraste para cima e para baixo para desviar dos quadrados"
		get_node("Panel/Tutorial3").text = "Arraste na diagonal para fazer a espiral rodar, não a deixe parada por 10s"
		get_node("Panel/Tutorial4").text = "Arraste para a direita se a equação estiver correta e para a esquerda se estiver incorreta"

func _on_PlayBtn_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")

func _on_voltar_pressed():
	get_node("Panel").visible = false
	pass

func _on_Help_pressed():
	get_node("Panel").visible = true
	pass

func _on_HSBtn_pressed():
	if get_node("/root/Global").gpgs != null:
		get_node("/root/Global").gpgs.showLeaderboardUI(get_node("/root/Global").leaderboardID)
	pass

func _on_LanguageBtn_pressed():
	get_node("/root/Global").mudarLinguagem();
	carregarTexto()
	pass


func _on_SoundBtn_pressed():
	pass # Replace with function body.
