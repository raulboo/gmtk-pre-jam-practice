extends Area2D

var velocity := Vector2(0, 0)

func _physics_process(delta):
	self.position += self.velocity


func _on_Enemy_body_entered(body):
	if body.is_in_group("player"):
		body.die()
