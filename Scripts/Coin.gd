extends AnimatedSprite

func _ready():
	pass # Replace with function body.

func _on_coin_area_entered(area):
	if "Player" in area.get_name():
		queue_free()
