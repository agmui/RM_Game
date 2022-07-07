extends Node

const DEFAULT_PORT = 10567
const MAX_CLIENTS = 6
const ip_address = "24.5.169.14"
var server = null


func _ready():
	print("Creating server")
	
	server = NetworkedMultiplayerENet.new()
	server.create_server(DEFAULT_PORT, MAX_CLIENTS)
	get_tree().set_network_peer(server)
	
		
func reset_network_connection():
	if get_tree().has_network_peer():
		get_tree().network_peer = null
		
