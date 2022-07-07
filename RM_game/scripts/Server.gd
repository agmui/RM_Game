extends Node



func _ready():
	Network.ip_address = "24.5.169.14"
	Network.create_server()
	# may of may not need
	Global.connect("toggle_network_setup", self, "_toggle_network_setup")
	var main = load("res://Main.gd").new()
