extends Control

func _read():
	Global.connect("toggle_network_setup", self, "_toggle_network_setup")

func _on_ipAddress_text_changed(new_text):
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
