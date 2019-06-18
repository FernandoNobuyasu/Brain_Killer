extends Node

var admob = null
var gpgs = null
var leaderboardID = "CgkIrtrsk40CEAIQAA"
var logado = false
var adIsReal = true
var idBanner = "ca-app-pub-8477867296411992/1474119888"
var idInterstitial = "ca-app-pub-8477867296411992/6273707348"
var idRewarded = "ca-app-pub-8477867296411992/8708298993"
var savedInfo = {"Linguagem": 0, "Scores": 0}

signal statusLogadoChange
signal interstitial_close
signal interstitial_not_loaded
signal rewarded_video_ad_left_application
signal rewarded_video_ad_closed
signal rewarded_video_ad_failed_to_load(errorCode)
signal rewarded(currency, amount)

func mudarLinguagem():
	saveLinguagem(abs(savedInfo["Linguagem"] - 1))

func saveLinguagem(linguagem):
	savedInfo["Linguagem"] = linguagem
	saveInfo()
	pass

func saveOflineScore(score):
	if int(score) > int(savedInfo["Scores"]):
		savedInfo["Scores"] = int(score)
	saveInfo()
	pass

func saveInfo():
	var saveFile = File.new()
	saveFile.open("save.json", File.WRITE)
	saveFile.store_line(to_json(savedInfo))
	saveFile.close()
	pass

func loadInfo():
	var saveFile = File.new()
	if saveFile.open("save.json", File.READ) == 0:
		savedInfo = parse_json(saveFile.get_line())
	pass

func _ready():
	loadInfo()
	if Engine.has_singleton("AdMob"):
		admob = Engine.get_singleton("AdMob")
		admob.init(adIsReal, get_instance_id())
		admob.loadBanner(idBanner, false)
		admob.showBanner()
		loadRewardedVideo()
		loadInterstitial()
	if Engine.has_singleton("GodotPlayGameServices"):
		gpgs = Engine.get_singleton("GodotPlayGameServices")
		gpgs.init(get_instance_id(), false)
		gpgs.signInSilent()
	pass

#-----gpgs
func _on_play_game_services_sign_in_failure(signInType):
	if(signInType == 0):
		gpgs.signInInteractive()
	pass

func _on_play_game_services_sign_in_success(signInType, playerID):
	logado = true
	emit_signal("statusLogadoChange")
	pass

func _on_play_game_services_sign_out(success):
	if success:
		logado = false
		emit_signal("statusLogadoChange")
	pass

func salvarScore(score):
	if Engine.has_singleton("GodotPlayGameServices"):
		gpgs.submitScore(leaderboardID, score)
	pass

#-----admob
func loadRewardedVideo():
	admob.loadRewardedVideo(idRewarded)
	pass

func loadInterstitial():
	admob.loadInterstitial(idInterstitial)
	pass

#--interstitial
func showInterstitial():
	if Engine.has_singleton("AdMob"):
		admob.showInterstitial()
		loadInterstitial()
	pass

func _on_interstitial_close():
	emit_signal("interstitial_close")
	pass
	
func _on_interstitial_not_loaded():
	emit_signal("interstitial_not_loaded")
	pass

#--rewarded
func showRewarded():
	if Engine.has_singleton("AdMob"):
		admob.showRewardedVideo()
		loadRewardedVideo()
	pass

func _on_rewarded_video_ad_left_application():
	emit_signal("rewarded_video_ad_left_application")
	pass

func _on_rewarded_video_ad_closed():
	emit_signal("rewarded_video_ad_closed")
	pass

func _on_rewarded_video_ad_failed_to_load(errorCode):
	emit_signal("rewarded_video_ad_failed_to_load")
	pass

func _on_rewarded(currency, amount):
	emit_signal("rewarded",currency,amount)
	pass