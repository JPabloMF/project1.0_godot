extends KinematicBody2D

const UP = Vector2(0,-1)
const ACCELERATION = 50
const MAX_SPEED = 300
var motion = Vector2()

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	motion.y += 10
	if Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	elif Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		
	if Input.is_action_pressed("ui_up"):
		if is_on_floor():
			motion.y = -400
	motion = move_and_slide(motion,UP)
