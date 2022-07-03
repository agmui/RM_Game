extends KinematicBody


var gravity = -40
var speed = 16
var jump_speed = 15
var mouse_sensitivity = 0.08

var velocity = Vector3()

var puppet_position = Vector3()
var puppet_velocity = Vector3()
var puppet_rotation = Vector2()

export(NodePath) onready var head = get_node(head) as Spatial
export(NodePath) onready var model = get_node(model) as CSGMesh
export(NodePath) onready var camera = get_node(camera) as Camera
export(NodePath) onready var network_tick_rate = get_node(network_tick_rate) as Timer
export(NodePath) onready var movement_tween = get_node(movement_tween) as Tween

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	camera.current = is_network_master()
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
	if !is_network_master():
		pass
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

func _physics_process(delta):
	velocity.y += gravity * delta
	
	if is_network_master():
		var desired_velocity = get_input() * speed
		velocity.x = desired_velocity.x
		velocity.z = desired_velocity.z
		
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y += jump_speed
	else:
		global_transform.origin = puppet_position
		
		velocity.x = puppet_velocity.x
		velocity.y = puppet_velocity.y
		
		rotation.y = puppet_rotation.y
		head.rotation.x = puppet_rotation.x
		
	if !movement_tween.is_active():
		velocity = move_and_slide(velocity, Vector3.UP, true)

puppet func update_state(p_position, p_velocity, p_rotation):
	puppet_position = p_position
	puppet_velocity = p_velocity
	puppet_rotation = p_rotation
	
	movement_tween.interpolate_property(self, "global_transform", global_transform, Transform(global_transform.basis, p_position), 0.1)
	movement_tween.start()
	


func _on_NetworkTickRate_timeout():
	if is_network_master():
		rpc_unreliable("update_state", global_transform.origin, velocity, Vector2(head.rotation.x, rotation.y))
	else:
		network_tick_rate.stop()
