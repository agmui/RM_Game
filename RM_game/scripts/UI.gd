extends Node2D


func _ready():
	pass

func change_health(id, health):
	$Bars/HealthBar.value = health
	$Bars/HealthBar/Health.text = str(health)+"/600"

func set_heat(heat_value):
	#TODO add white
	if heat_value >= 80:
		$overheat.show()
		$overheat.modulate.a8 = pow(2,heat_value/9)
	else:
		$overheat.hide()
		
	if heat_value>=75:
		$Bars/HeatWhite.hide()
		$Bars/HeatRed.show()
		$Bars/HeatRed.value = heat_value
	elif 65 < heat_value and heat_value < 75:
		$Bars/HeatWhite.show()
		$Bars/HeatRed.hide()
		$Bars/HeatWhite.value = heat_value
	else:
		$Bars/HeatWhite.value = heat_value

func change_enemy_health(id, health):
	$Bars/enemyBar.value = health
