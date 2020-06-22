extends MarginContainer

onready var number_coins = $Container/CoinsContainer/Coins
onready var number_lives = $Container/LivesContainer/Lives
var coins_amount = 0
var lives_amount = 3

signal printOk

func _ready():
	number_coins.text = str(coins_amount)
	number_lives.text = str(lives_amount)

func _on_Area2D_area_entered(area):
	if "coin" in area.get_name():
		coins_amount += 1
		number_coins.text = str(coins_amount)
	elif "DangerPlatform" in area.get_name():
		lives_amount -= 1
		number_lives.text = str(lives_amount)
