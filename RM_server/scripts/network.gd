extends Node

const DEFAULT_PORT = 10567
const MAX_CLIENTS = 6

var server = null

var ip_address = "24.5.169.14"


func _ready():
	get_tree().connect("peer_connected", self, "_peer_connected")
	get_tree().connect("peer_disconnected", self, "_peer_disconnected")
	
	print("Creating server")
	
	server = NetworkedMultiplayerENet.new()
	server.create_server(DEFAULT_PORT, MAX_CLIENTS)
	get_tree().set_network_peer(server)
	
func _peer_connected(id):
	print("Player connected " + str(id))
	
	
func _peer_disconnected(id):
	print("Player disconnected " + str(id))
	
	if has_node(str(id)):
		get_node(str(id)).queue_free()
		
func reset_network_connection():
	if get_tree().has_network_peer():
		get_tree().network_peer = null
		
