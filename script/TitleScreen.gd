extends Node2D

export(PackedScene) var next_scene

func _gui_input(event):
	if event.is_action_just_pressed("action"):
		get_tree().change_scene_to(next_scene)
