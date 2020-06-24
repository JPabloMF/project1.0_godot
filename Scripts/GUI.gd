extends MarginContainer

onready var number_coins = $Container/CoinsContainer/Coins
onready var number_lives = $Container/LivesContainer/Lives
var coins_amount = 0
var lives_amount = 3
var _timer = null #checking every second if player is getting damage
var danger_element_entered = false;

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
	number_coins.text = str(coins_amount)
	number_lives.text = str(lives_amount)
	get_timer()

func reduce_lives():
	lives_amount -= 1
	number_lives.text = str(lives_amount)
	
func get_coin():
	coins_amount += 1
	number_coins.text = str(coins_amount)
		
func _on_Area2D_area_entered(area):
	danger_element_entered = true
	if "coin" in area.get_name():
		get_coin()
	elif "DangerPlatform" in area.get_name():
		start_timer()
		if lives_amount-1 > 0:
			reduce_lives()
		else:
			reduce_lives()

func _on_Timer_timeout():
	if danger_element_entered:
		reduce_lives()

func _on_Player_area_exited(area):
	danger_element_entered = false
	stop_timer()
