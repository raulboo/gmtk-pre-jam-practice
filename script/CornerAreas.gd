extends Node2D


func _on_Corner_body_entered(body):
	if body.is_in_group("player"):
		body.can_edge_dodge = true


func _on_Corner_body_exited(body):
	if body.is_in_group("player"):
		body.can_edge_dodge = false
