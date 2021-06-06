extends Node2D

export(int) var velocity_range = 10
export(int) var velocity_min = 5

export(float) var timer_reduction = 0.9

var enemy_class = preload("res://prototypes/Enemy.tscn")

func spawn_enemy():
	$SpawnPath/PathFollow2D.unit_offset = randf()
	var new_enemy = enemy_class.instance()
	new_enemy.position = $SpawnPath/PathFollow2D.position
	var velocity = (Vector2(0, 1) * (velocity_min + (randi() % velocity_range)))
	new_enemy.velocity = velocity
	add_child(new_enemy)
	

func _on_Timer_timeout():
	spawn_enemy()
	$Timer.wait_time *= timer_reduction
