extends Control

func _ready():
	$Lan.hide()
	$Connections.hide()
	$VBoxContainer.hide()
	$PlayerSetup.show()
	if OS.has_environment("USERNAME"):
		$PlayerSetup/NameEdit.text = OS.get_environment("USERNAME")
	else:
		var desktop_path = OS.get_system_dir(0).replace("\\", "/").split("/")
		$PlayerSetup/NameEdit.text = desktop_path[desktop_path.size() - 2]
	Global.connect("toggle_network_setup", self, "_toggle_network_setup")
	Network.connect("player_list_changed", self, "refresh_lobby")

func _on_Online_pressed():
	Network.ip_address = "24.5.169.14"
	hide()

func _on_Local_pressed():
	$VBoxContainer.hide()
	$Lan.show()
	$Lan/IpShow.text = "Your local IP: "+IP.get_local_addresses()[0]

func _on_IpAddress_text_changed(new_text):
	Network.ip_address = new_text

func _on_Host_pressed():
	Network.create_server()
	$Lan.hide()
	$Connections.show()

func _on_Join_pressed():
	Network.join_server()
	$Lan.hide()
	$Connections/HBoxContainer/StartButton.disabled = true
	$Connections.show()

func _toggle_network_setup(visible_toggle):
	visible = visible_toggle

func _on_ContinueButton_pressed(): #Continues after adding name
	if ($PlayerSetup/NameEdit.text == ""):
		$PlayerSetup/ErrorLabel.text = "Invalid Name!"
	else:
		Network.set_player_name($PlayerSetup/NameEdit.text)
		$PlayerSetup.hide()
		$VBoxContainer.show()
		refresh_lobby()

func _on_StartButton_pressed():
	$Connections.hide()
	Global.emit_signal("instance_player", get_tree().get_network_unique_id())
	rpc_unreliable("spawn_player")

puppet func spawn_player():
	$Connections.hide()
	Global.emit_signal("instance_player", get_tree().get_network_unique_id())

func _on_QuitButton_pressed():
	get_tree().quit()

func refresh_lobby():
	var player_list = Network.get_player_list()
	print(player_list)
	player_list.sort()
	$Connections/PlayerList.clear()
	$Connections/PlayerList.add_item(Network.get_player_name() + "(You)")
	for player in player_list:
		$Connections/PlayerList.add_item(player)
