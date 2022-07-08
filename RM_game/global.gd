extends Node

signal instance_player(id)
signal toggle_network_setup(toggle)

var server:bool = false

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_1:
			get_tree().quit() # quits game
