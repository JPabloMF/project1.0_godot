extends KinematicBody2D

const UP = Vector2(0,-1)
const ACCELERATION = 50
const MAX_SPEED = 300
var motion = Vector2()

var _timer = null #checking every second if player is getting damage
var danger_element_entered = false

var stairs_entered = false

func get_timer():
	_timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.5)
	_timer.set_one_shot(false) # Make sure it loops
	
func start_timer():
	_timer.start()
	
func stop_timer():
	_timer.stop()

func _ready():
	get_timer()

func _physics_process(delta):
	if stairs_entered:
		motion.y = 0
	else:
		motion.y += 10
		
	if Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	elif Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		
	if Input.is_action_pressed("ui_up"):
		if is_on_floor() or stairs_entered:
			motion.y = -400
	elif Input.is_action_pressed("ui_down"):
		motion.y = +400
		
			
	if Input.is_action_pressed("ui_accept"):
		get_tree().paused = false
	motion = move_and_slide(motion,UP)

func _on_Player_area_entered(area):
	danger_element_entered = true
	if "DangerPlatform" in area.get_name():
		$AnimatedSprite.play("damage")
		start_timer()
	elif "StairsArea" in area.get_name():
		stairs_entered = true

func _on_Timer_timeout():
	if danger_element_entered:
		$AnimatedSprite.play("damage")

func _on_Player_area_exited(area):
	danger_element_entered = false
	$AnimatedSprite.play("idle")
	stop_timer()
	if "StairsArea" in area.get_name():
		stairs_entered = false
