extends Spatial

var player = preload("res://scenes/Player.tscn")

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	
	Global.connect("instance_player", self, "_instance_player")

	# OS.window_fullscreen = true
	
	if get_tree().network_peer != null:
		Global.emit_signal("toggle_network_setup", false)# hide network setup

func _instance_player(id, cord, team):
	if Global.server and id ==1:
		return
	var player_instance = player.instance() # FIXME use the constructor
	player_instance.set_network_master(id)
	player_instance.name = str(id)
	player_instance.id = id
	player_instance.team = team
	
	add_child(player_instance)
	player_instance.global_transform.origin = Vector3(cord[0], 5, cord[1])


func _player_connected(id):
	pass
	
func _player_disconnected(id):
	if has_node(str(id)):
		get_node(str(id)).queue_free()
