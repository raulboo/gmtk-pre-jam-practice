extends Node2D

const car = preload("res://script/Car.tscn")

var on_retry_screen := false

onready var score : int = 0

func _ready():
	start()
	
func _input(event):
	if on_retry_screen:
		if event.is_action_pressed("action"):
			restart()
	
	
func start():
	randomize()
	$ScoreTimer.start()
	$Enemies/Timer.start()
	$Enemies/WaveTimer.start()
	$UI/EndScreen.hide()
	
	on_retry_screen = false
	score = 0
	
	
func restart():
	var new_car = car.instance()
	new_car.position = Vector2(0, 128)
	new_car.connect("dead", self, "_on_Car_dead")
	new_car.connect("combo_ended", self, "_on_Car_combo_ended")
	add_child(new_car)
	start()
	

func _on_ScoreTimer_timeout():
	score += 1
	$UI/Score.text = String(score)


func _on_Car_dead():
	$ScoreTimer.stop()
	$Enemies/Timer.stop()
	
	$UI/EndScreen.show()
	$UI/EndScreen/FinalScore.text = $UI/Score.text           
	
	on_retry_screen = true


func _on_Car_combo_ended(score_got):
	score += score_got
	$UI/Score.text = String(score)
	$UI/Score.modulate = Color.green
	yield(get_tree().create_timer(1), "timeout")
	$UI/Score.modulate = Color.white


