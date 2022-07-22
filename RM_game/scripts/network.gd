extends Node

const DEFAULT_PORT = 10567
const MAX_CLIENTS = 6

var server = null
var client = null

var ip_address = "127.0.0.1"

var player_name
var team = "red"
var is_host = false
# TODO move to global
var player_list = {} # contains all players
var team_size = {"red":0, "blue": 0}

signal player_list_changed()

func _ready():
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	get_tree().connect("connection_failed", self, "_connection_failed")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")

func create_server():
	print("Creating server")
	server = NetworkedMultiplayerENet.new()
	server.create_server(DEFAULT_PORT, MAX_CLIENTS)
	get_tree().set_network_peer(server)
	#register current player
	player_list[get_tree().get_network_unique_id()] = {
		"name":player_name,
		 "team":team, 
		 "team_id": 1,
		 "host":is_host
		}
	
func join_server():
	print("Joining Server")
	client = NetworkedMultiplayerENet.new()
	client.create_client(ip_address, DEFAULT_PORT)
	get_tree().set_network_peer(client)
	#register current player
	player_list[get_tree().get_network_unique_id()] = {
		"name":player_name,
		 "team":team, 
		 "team_id": 1,
		 "host":is_host
		}

func _connected_to_server():
	print("Successfully connected to the server")

func _server_disconnected():
	print("Disconnected from the server")

	reset_network_connection()

func _connection_failed():
	print("Connection to server failed")
	
	reset_network_connection()
	
func _player_connected(id):
	rpc_id(id, "register_player", player_name, team, is_host)
	print("Player connected " + str(id))

func _player_disconnected(id):
	unregister_player(id)
	print("Player " + str(id) + " has disconnected")

func reset_network_connection():
	if get_tree().has_network_peer():
		get_tree().network_peer = null

func get_player_list():
	return player_list.values()

remote func change_player_values(id, values):
	player_list[id] = values
	emit_signal("player_list_changed")

func get_player_name():
	return player_name

func set_player_name(cplayer_name):
	player_name = cplayer_name

func get_team_size_list():
	return team_size.values();
	
func set_player_team(index):
	var id = get_tree().get_network_unique_id()
	player_list[id].team = "red" if index==0 else "blue"
	rpc("change_player_values", id, player_list[id])

remote func set_host(host):
	is_host = host

remote func register_player(player_name, player_team, player_host):
	var id = get_tree().get_rpc_sender_id()
	player_list[id] = {
		"name":player_name,
		"team":player_team,
		"team_id":1,
		"host":player_host}
	emit_signal("player_list_changed")

func unregister_player(id):
	player_list.erase(id)
	emit_signal("player_list_changed")

func start_game():
	# adds current player into player_list
	if Global.server: # ==online==
		rpc_id(1, "start_game_server")
	else: # ==LAN==
		# same code as start_game_server() in server
		var spawn_locations = []
		for id in player_list.keys():
			var cord = [0,0]
			var player=player_list[id]
			if team_size[player.team]:
				cord = [7, 9.5] if player.team == "red" else [-7,-9.5]
			else:
				cord = [3.5, 11.5] if player.team == "red" else [-3.5,-11.5]
			team_size[player.team] += 1
			spawn_locations.append([id, cord])
		rpc("recived_spawn", spawn_locations)
		recived_spawn(spawn_locations)

remote func recived_spawn(cord):
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # keep mouse in the middle of the screen
	Global.emit_signal("toggle_network_setup", false)
	for i in cord:
		Global.emit_signal("instance_player", i[0], i[1], player_list[i[0]].team)
