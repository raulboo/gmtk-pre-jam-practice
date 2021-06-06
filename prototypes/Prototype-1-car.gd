extends Node2D

onready var score : int = 0

func _ready():
	randomize()
	$ScoreTimer.start()
	$Enemies/Timer.start()
	$Enemies/WaveTimer.start()
	$UI/FinalScore.hide()
	

func _on_ScoreTimer_timeout():
	score += 1
	$UI/Score.text = String(score)


func _on_Car_dead():
	$ScoreTimer.stop()
	$Enemies/Timer.stop()
	$UI/FinalScore.text = $UI/Score.text
	$UI/FinalScore.show()


func _on_Car_combo_ended(score_got):
	score += score_got
	$UI/Score.text = String(score)
	$UI/Score.modulate = Color.green
	yield(get_tree().create_timer(1), "timeout")
	$UI/Score.modulate = Color.white


