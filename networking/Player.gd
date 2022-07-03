extends KinematicBody


var gravity = -40
var speed = 16
var jump_speed = 15
var mouse_sensitivity = 0.08

var velocity = Vector3()

export(NodePath) onready var head = get_node(head) as Spatial
export(NodePath) onready var model = get_node(model) as CSGMesh

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	#model.visible = false

func get_input():
	var input_dir = Vector3()
	
	if Input.is_action_pressed(("move_forward")):
		input_dir += -global_transform.basis.z
	if Input.is_action_pressed(("move_backward")):
		input_dir += global_transform.basis.z
	if Input.is_action_pressed(("move_left")):
		input_dir += -global_transform.basis.x
	if Input.is_action_pressed(("move_right")):
		input_dir += global_transform.basis.x
	
	input_dir = input_dir.normalized()
	return input_dir

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

func _physics_process(delta):
	velocity.y += gravity * delta

	
	var desired_velocity = get_input() * speed
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_speed
	
	velocity = move_and_slide(velocity, Vector3.UP, true)
