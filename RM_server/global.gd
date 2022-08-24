extends Node

signal instance_player(id)
signal toggle_network_setup(toggle)
signal change_health(id, health)
signal start_sentry()

var server = true
var player_pos = {}

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			get_tree().quit()
