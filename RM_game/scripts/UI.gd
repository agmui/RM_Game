extends Node2D

func _ready():
	pass

func change_health(health):
	$Bars/HealthBar.value = health
	$Bars/HealthBar/Health.text = str(health)+"/600"
