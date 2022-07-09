extends Node

const DEFAULT_PORT = 10567
const MAX_CLIENTS = 6
const ip_address = "24.5.169.14"
var server = null

var player_list = {}
var team_size = {"red":0, "blue": 0}

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
	print("unreg")
	team_size[player_list.id.team] -= 1
	player_list.erase(id)

remote func spawn_location_server(id, team):
	team = "red" if team==0 else "blue"
	var cord = [0,0]
	if team_size[team]:
		player_list.id.team = team
		cord = [7, 9.5] if team == "red" else [-7,-9.5]
	else:
		player_list.id.team = team
		cord = [3.5, 11.5] if team == "red" else [-3.5,-11.5]
	team_size[team] += 1
	rpc_id(id,  "recived_spawn", id, cord)
