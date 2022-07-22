extends Node2D

var id_to_enemy = []

func _ready():
	$Bars/enemyBar2.hide()
	for id in Network.player_list.keys():
		if Network.player_list[id].team != Network.player_list[get_tree().get_network_unique_id()].team:
			id_to_enemy.append(id)
	if len(id_to_enemy) == 2:
		$Bars/enemyBar2.show()

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
	if id_to_enemy[0] == id:
		$Bars/enemyBar.value = health
	else:
		$Bars/enemyBar2.value = health
