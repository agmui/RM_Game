extends KinematicBody2D
class_name Actor


export var speed: = Vector2(800.0, 1000.0) #export lets inspecter see var and adjust it
export var gravity: = 3000.0

var velocity: = Vector2.ZERO



func _physics_process(delta: float) -> void: # function to alow gravity? runs every frame
	velocity.y += gravity * delta

