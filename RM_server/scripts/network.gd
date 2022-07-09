extends Node

const DEFAULT_PORT = 10567
const MAX_CLIENTS = 6
const ip_address = "24.5.169.14"
var server = null

var player_list = {}

func _ready():
	print("Creating server")
	
	server = NetworkedMultiplayerENet.new()
	server.create_server(DEFAULT_PORT, MAX_CLIENTS)
	get_tree().set_network_peer(server)
	
		
func reset_network_connection():
	if get_tree().has_network_peer():
		get_tree().network_peer = null
		

remote func register_player(cplayer_name):
	var id = get_tree().get_rpc_sender_id()
	player_list.id = {"name":cplayer_name, "team":"no_team"}

remote func unregister_player(id):
	player_list.erase(id)

puppet func spawn_location_server(id, team):
	print("deciding spawn")
	for p in player_list.values():
		if p.team == team+"1":
			player_list.id.team = team+"2"
			rpc("spawn_location", id, [10,10])
		else:
			player_list.id.team = team+"1"
			rpc("recived_spawn", id, [-10,10])