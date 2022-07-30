extends Node

const DEFAULT_PORT = 10567
const MAX_CLIENTS = 6
const ip_address = "127.0.0.1" #"24.5.169.14"
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

remote func register_player(cplayer_name, team, host):
	var id = get_tree().get_rpc_sender_id()
	player_list[id] = {"name":cplayer_name, "team":team, "team_id":0, "host": host}
	if player_list.size() == 1:
		rpc_id(id, "set_host", true)
	print("set host")

remote func unregister_player(id):
	team_size[player_list[id].team] -= 1
	player_list.erase(id)

remote func change_player_values(id, values):
	player_list[id] = values

remote func start_game_server():
	var spawn_locations = []
	for id in player_list.keys():
		var cord = [0,0]
		var player=player_list[id]
		if team_size[player.team]:
			cord = [-1.05, -5] if player.team == "red" else [3,3.2]
			player.team_id = 1
		else:
			cord = [-3,-3.2] if player.team == "red" else [1.05, 5]
			player.team_id = 0
		team_size[player.team] += 1
		spawn_locations.append([id, cord])
	rpc("recived_spawn", spawn_locations)
