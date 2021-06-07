extends KinematicBody2D

signal dead
signal combo_ended(score)

export var acceleration : float = 5
export var friction_coefficient : float = 0.95

onready var velocity := Vector2(0, 0)
onready var direction := Vector2(1, 0) setget _set_direction

onready var can_edge_dodge := false
onready var combo_score := 0.0

func _physics_process(_delta):
	velocity.y += 10 #Gravity
	
	if Input.is_action_pressed("action"):
		#Acceleration
		velocity += self.acceleration * self.direction
	else:
		velocity.x *= self.friction_coefficient
		#Friction
		
	if Input.is_action_just_released("action"):
		self.direction = -self.direction	
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if abs(velocity.x) > 300:
		add_to_combo(abs(velocity.x)/5000, "Going fast!")
	elif abs(velocity.x) < 100 and can_edge_dodge:
		#Only when speed is slow enough
		add_to_combo(10, "Edge Dodge!")
		can_edge_dodge = false
		
		
		
func add_to_combo(amount : float, message : String):
	if combo_score < 1:
		combo_score = 1
	
	combo_score += amount
	
	$ComboTimer.start()
	$ComboUI.show()
	$ComboUI/Message.text = message
	$ComboUI/Counter.text = "+" + String(int(combo_score)) + "!"
		
	
func tilt(angle):
	pass


func die():
	emit_signal("dead")
	self.queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	die()


func _on_ComboTimer_timeout():
	if is_on_floor():
		emit_signal("combo_ended", floor(combo_score))
		combo_score = 0
		$ComboUI.hide()
	else:
		$ComboTimer.start()


func _set_direction(new_direction):
	direction = new_direction
	$Sprite.flip_h = (new_direction.x < 0)
	
