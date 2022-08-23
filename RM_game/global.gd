extends Node

signal instance_player(id, cord, team)
signal toggle_network_setup(toggle)
signal change_health(id, health)
signal start_sentry()

var server:bool = false
var player_pos = {}

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_1:
			get_tree().quit() # quits game
