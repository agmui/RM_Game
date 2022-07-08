extends ColorRect

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$ControlsContainer.hide()
	$PauseMenuContainer.show()

func _on_ResumeButton_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hide()

func _on_OptionsButton_pressed():
	pass # Replace with function body.


func _on_ControlsButton_pressed():
	$PauseMenuContainer.hide()
	$ControlsContainer.show()


func _on_BackButton_pressed():
	$ControlsContainer.hide()
	$PauseMenuContainer.show()


func _on_QuitButton_pressed():
	get_tree().quit()
