extends Node

const DEFAULT_PORT = 10567
const MAX_CLIENTS = 6

var server = null
var client = null

var ip_address = "127.0.0.1"

var player_name
var player_list = {}

signal player_list_changed()

func _ready():
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	get_tree().connect("connection_failed", self, "_connection_failed")
	get_tree().connect("network_peer_connected", self, "_player_connected")

func create_server():
	print("Creating server")
	server = NetworkedMultiplayerENet.new()
	server.create_server(DEFAULT_PORT, MAX_CLIENTS)
	get_tree().set_network_peer(server)
	
func join_server():
	print("Joining Server")
	
	client = NetworkedMultiplayerENet.new()
	client.create_client(ip_address, DEFAULT_PORT)
	get_tree().set_network_peer(client)

func _connected_to_server():
	print("Successfully connected to the server")

func _server_disconnected():
	print("Disconnected from the server")

	reset_network_connection()

func _connection_failed():
	print("Connection to server failed")
	
	reset_network_connection()
	
func _player_connected(id):
	rpc_id(id, "register_player", player_name)
	print("Player connected " + player_name + " " + str(id))

func _player_disconnected(id):
	unregister_player(id)

func reset_network_connection():
	if get_tree().has_network_peer():
		get_tree().network_peer = null

func get_player_list():
	return player_list.values()

func get_player_name():
	return player_name

func set_player_name(cplayer_name):
	player_name = cplayer_name

remote func register_player(cplayer_name):
	var id = get_tree().get_rpc_sender_id()
	print(id)
	player_list[id] = cplayer_name
	emit_signal("player_list_changed")

func unregister_player(id):
	player_list.erase(id)
	emit_signal("player_list_changed")
