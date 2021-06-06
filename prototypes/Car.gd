extends KinematicBody2D

export var acceleration : float = 5
export var friction_coefficient : float = 0.95

onready var velocity := Vector2(0, 0)
onready var direction := Vector2(1, 0)

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
	
	
	velocity = move_and_slide(velocity)
