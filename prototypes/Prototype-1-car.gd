extends Node2D

onready var score : int = 0

func _ready():
	randomize()
	$ScoreTimer.start()
	$Enemies/Timer.start()
	$UI/FinalScore.hide()
	

func _on_ScoreTimer_timeout():
	score += 1
	$UI/Score.text = String(score)


func _on_Car_dead():
	$ScoreTimer.stop()
	$Enemies/Timer.stop()
	$UI/FinalScore.text = $UI/Score.text
	$UI/FinalScore.show()
