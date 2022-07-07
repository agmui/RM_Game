extends Node

signal instance_player(id)
signal toggle_network_setup(toggle)

var server = true

var public_server = false

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			get_tree().quit()
