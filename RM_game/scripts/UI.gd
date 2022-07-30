extends Node2D

var id_to_player = {}

func _ready():
	pass
	$Bars/enemyBar2.hide()
	for id in Network.player_list.keys():
		var p = Network.player_list[id]
		var personal_id = get_tree().get_network_unique_id()
		#same team
		if id !=  personal_id && p.team == Network.player_list[personal_id].team:
			id_to_player[id] = $Bars/teamateBar
		#diffrent team
		elif p.team_id == 1:
			id_to_player[id] = $Bars/enemyBar
		else:
			id_to_player[id] = $Bars/enemyBar2
	if len(id_to_player) == 2:
		$Bars/enemyBar2.show()

func change_health(health):
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
	id_to_player[id].value = health
