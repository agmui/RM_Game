extends Node2D

func _ready():
	pass

func change_health(health):
	$Bars/HealthBar.value = health
	$Bars/HealthBar/Health.text = str(health)+"/600"

func set_heat(heat_value):
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
