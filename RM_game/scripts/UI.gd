extends Node2D

var id_to_player = {}
var mouse_sensitivity = 0.2 setget set_mouse_sens, get_mouse_sens
var paused = false

func _ready():
	$SettingsPanel/MouseSensText.text = String(mouse_sensitivity)
	$SettingsPanel/MouseSensSlider.value = mouse_sensitivity
	# pass
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
	if len(id_to_player) >= 2:
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
	print(id)
	id_to_player[id].value = health

func change_sentry(team, health):
	if team=="blue_sentry":
		$BluSentry.text = str(health)
	else:
		$RedSentry.text = str(health)

func change_base(team, health):
	if team=="blue_base":#FIXME
		$Bars/BlueBaseHealth.value = health
	else:
		$Bars/RedBaseHealth.value = health

func toggle_tips():
	if ($TipsPanel.visible):
		$TipsPanel.hide();
	else:
		$TipsPanel.show();

func toggle_settings():
	if ($SettingsPanel.visible):
		paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		$SettingsPanel.hide()
	else:
		paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$SettingsPanel.show();

func set_mouse_sens(sensitivity):
	mouse_sensitivity = sensitivity;
	$SettingsPanel/MouseSensText.text = sensitivity;
	$SettingsPanel/MouseSensSlider.value = sensitivity;

func get_mouse_sens():
	return mouse_sensitivity;

func _on_MouseSensSlider_value_changed(value):
	print("Sensitivity changed to " + String(value))
	mouse_sensitivity = value;
	$SettingsPanel/MouseSensText.text = String(mouse_sensitivity)

func _on_MouseSensText_text_entered(new_text):
	if (new_text.is_float):
		mouse_sensitivity = new_text.to_float()
		$SettingsPanel/MouseSensSlider.value = mouse_sensitivity
	else:
		$SettingsPanel/MouseSensText.text = String(mouse_sensitivity)
