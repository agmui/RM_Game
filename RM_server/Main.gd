extends Spatial

var player = preload("res://scenes/Player.tscn")


func _ready():
	if OS.has_feature("Server"): # sets up as deticated server
		get_tree().connect("network_peer_connected", self, "_player_connected")
		get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
		
		Global.connect("instance_player", self, "_instance_player")
		
		if get_tree().network_peer != null:
			Global.emit_signal("toggle_network_setup", false)

func _instance_player(id):
	var player_instance = player.instance()
	player_instance.set_network_master(id)
	player_instance.name = str(id)
	player_instance.id = id
	# player_instance.team = team
	
	add_child(player_instance)
	print("added player")
	
	player_instance.global_transform.origin = Vector3(0, 5, 0)


func _player_connected(id):
	print("Player "+str(id)+ " has connected")
	
	_instance_player(id)
	
func _player_disconnected(id):
	print("Player " + str(id) + " has disconnected")
	Network.unregister_player(id)
	if has_node(str(id)):
		get_node(str(id)).queue_free()
