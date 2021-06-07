extends Node2D

export(int) var velocity_range = 8
export(int) var velocity_min = 2

export(float) var timer_coefficient = 0.9

var enemy_class = preload("res://script/Enemy.tscn")

func spawn_enemy():
	$SpawnPath/PathFollow2D.unit_offset = randf()
	var new_enemy = enemy_class.instance()
	new_enemy.position = $SpawnPath/PathFollow2D.position
	
	var velocity_magnitude = velocity_min + (randi() % velocity_range)
	new_enemy.velocity = Vector2(0, 1) * velocity_magnitude
	
	if velocity_magnitude < velocity_min + (velocity_range/4):
		new_enemy.get_node("AnimatedSprite").play("purple")
	elif velocity_magnitude < velocity_min + (velocity_range/2):
		new_enemy.get_node("AnimatedSprite").play("green")
	elif velocity_magnitude < velocity_min + (3*velocity_range/4):
		new_enemy.get_node("AnimatedSprite").play("pink")
	elif velocity_magnitude < velocity_min + velocity_range:
		new_enemy.get_node("AnimatedSprite").play("black")
		var new_shape = RectangleShape2D.new()
		new_shape.extents = Vector2(48, 48)
		new_enemy.get_node("CollisionShape2D").shape = new_shape
	
	add_child(new_enemy)


func _on_Timer_timeout():
	spawn_enemy()
	$Timer.wait_time *= timer_coefficient
	print($Timer.wait_time)


func _on_WaveTimer_timeout():
	if timer_coefficient < 1:
		timer_coefficient = 1/sqrt(timer_coefficient)
	else:
		timer_coefficient = 1/timer_coefficient
