extends Control


func _ready():
	$Lan.hide()
	Global.connect("toggle_network_setup", self, "_toggle_network_setup")

func _on_Online_pressed():
	Network.ip_address = "24.5.169.14"
	Global.public_server = true
	_on_Join_pressed()


func _on_Local_pressed():
	$VBoxContainer.hide()
	$Lan.show()
	$Lan/IpShow.text = "Your local IP: "+IP.get_local_addresses()[0]

func _on_IpAddress_text_changed(new_text):
	Network.ip_address = new_text

func _on_Host_pressed():
	Network.create_server()
	hide()
	
	Global.emit_signal("instance_player", get_tree().get_network_unique_id())

func _on_Join_pressed():
	Network.join_server()
	hide()
	
	Global.emit_signal("instance_player", get_tree().get_network_unique_id())

func _toggle_network_setup(visible_toggle):
	visible = visible_toggle
