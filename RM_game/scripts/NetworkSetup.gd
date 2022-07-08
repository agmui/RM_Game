extends Control

var teams = ["Red", "Blue"]

func _ready():
	$Lan.hide()
	$Connections.hide()
	$VBoxContainer.hide()
	$PlayerSetup.show()
	$Connections/TeamButton.add_item("Red")
	$Connections/TeamButton.add_item("Blue")
	if OS.has_environment("USERNAME"):
		$PlayerSetup/NameEdit.text = OS.get_environment("USERNAME")
	else:
		var desktop_path = OS.get_system_dir(0).replace("\\", "/").split("/")
		$PlayerSetup/NameEdit.text = desktop_path[desktop_path.size() - 2]
	Global.connect("toggle_network_setup", self, "_toggle_network_setup")
	Network.connect("player_list_changed", self, "refresh_lobby")

func _on_Online_pressed():
	Network.ip_address = "24.5.169.14"
	Global.server = true
	_on_Join_pressed()

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
	Network.set_player_team(get_tree().get_network_unique_id(), 0)
	refresh_lobby()
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
	print("lobby has been refreshed")
	var player_list = Network.get_player_list()
	var team_list = Network.get_player_team_list()
	print(player_list)
	print(team_list)
	player_list.sort()
	$Connections/PlayerList.clear()
	$Connections/PlayerList.add_item(teams[$Connections/TeamButton.get_selected_id()] + " " + Network.get_player_name() + " (You)")
	for i in range(player_list.size()):
		$Connections/PlayerList.add_item(team_list[i] + player_list[i])

#Order of Menus:
#PlayerSetup, Online/Local, Host/Join, Connection
func _on_LanBackButton_pressed():
	$VBoxContainer.show()
	$Lan.hide()

func _on_ServerBack_pressed():
	$PlayerSetup.show()
	$VBoxContainer.hide()

func _on_ConnectBackButton_pressed():
	$Connections.hide()
	$Lan.show()
	Network.unregister_player(get_tree().get_network_unique_id())
	get_tree().network_peer = null

func _on_TeamButton_item_selected(index):
	Network.set_player_team(get_tree().get_network_unique_id(), index)
	Network.emit_signal("player_list_changed")
