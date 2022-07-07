extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 1
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

var velocity = Vector3.ZERO
export var health = 600
var fire_cooldown = false
var dead = false
onready var cam = get_node("Head_Pivot")
onready var bullet = preload("res://scenes/Bullet.tscn") # loading in bullet into var
var UI = preload("res://scenes/UI.tscn").instance()

var sensitivity = .2
var track = true

var puppet_position = Vector3()
var puppet_velocity = Vector3()
var puppet_rotation = Vector2()

#export(NodePath) onready var health_bar = get_node(health_bar) as TextureProgress

func _ready():
	if is_network_master():
		$Head_Pivot/Camera.add_child(UI)
	UI.change_health(600)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # keep mouse in the middle of the screen
	$Head_Pivot/Camera.current = is_network_master()

	
func _input(event):
	if !is_network_master():
		return
	if dead:
		return
	if event is InputEventMouseMotion and track:
		var movement = event.relative
		cam.rotation.x += -deg2rad(movement.y*sensitivity) # rotating virticaly
		cam.rotation.x = clamp(cam.rotation.x, deg2rad(-30), deg2rad(60)) #limit cam rotation
		cam.rotation.y += -deg2rad(movement.x*sensitivity) # rotating horizontaly


func _physics_process(delta):
	if is_network_master():
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()
		if Input.is_key_pressed(KEY_TAB):
			track = !track
			if track:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		if dead:
			return
		# We create a local variable to store the input direction.
		var body_dir = Vector3.ZERO
	
		# We check for each move input and update the direction accordingly.
		speed = 1
		if Input.is_action_pressed("boost"):
			speed = 3 # top speed
		if Input.is_action_pressed("move_right"):
			body_dir.x += 1
		if Input.is_action_pressed("move_left"):
			body_dir.x -= 1
		if Input.is_action_pressed("move_back"):
			body_dir.z += 1
		if Input.is_action_pressed("move_forward"):
			body_dir.z -= 1
		if Input.is_action_pressed("beyblade"):
			$Pivot.rotation.y -= .08
			$CollisionShape.rotation.y -= .08
			$PanelHitbox.rotation.y -= .08
			rpc_unreliable("update_beyblade")
		if Input.is_action_pressed("fire") and !fire_cooldown:
			var b = bullet.instance() # making an object b (kinda like Bullet b = new Bullet)
			$Head_Pivot/head.add_child(b) # spawning bullet to head
			rpc_unreliable("fired")
			b.shoot = true # lets bullet move
			$FireCooldown.start()
			fire_cooldown = true
		
		body_dir = body_dir.normalized()
		body_dir = body_dir.rotated(Vector3.UP, cam.rotation.y) # rotating the vector we are moving in
		
		# Ground velocity
		velocity.x = body_dir.x * (2 if speed == 3 else 1)#max translational speed is 2 m/s
		velocity.z = body_dir.z * speed
		# Vertical velocity
		velocity.y -= fall_acceleration * delta
	else:
		global_transform.origin = puppet_position
		
		velocity.x = puppet_velocity.x
		velocity.y = puppet_velocity.y
		
		cam.rotation.y = puppet_rotation.y
		cam.rotation.x = puppet_rotation.x
	if !$Tween.is_active():
		# Moving the character	
		velocity = move_and_slide(velocity, Vector3.UP)


func _on_FireCooldown_timeout():
	fire_cooldown = false

func _on_ReviveTimer_timeout():
	dead = false
	$ReviveTimer.stop()
	print("revived")
	rpc_unreliable("revived")

func _on_PanelHitbox_body_entered(body):
	#TODO check if bullet is moving fast enough
	if body.is_in_group("bullet") and is_network_master():
		print("hit")
		if !dead:
			print("taking dmg")
			health -= 10
			UI.change_health(health)
			if health == 0:
				$Head_Pivot.rotation.x = deg2rad(-30) #TODO lock all movement
				print("dead")
				dead = true
				$ReviveTimer.start()
				rpc_unreliable("killed_player")

puppet func fired():
	var b = bullet.instance() # making an object b (kinda like Bullet b = new Bullet)
	$Head_Pivot/head.add_child(b) # spawning bullet to head
	b.shoot = true # lets bullet move

puppet func update_beyblade():
	$Pivot.rotation.y -= .08
	$CollisionShape.rotation.y -= .08
	$PanelHitbox.rotation.y -= .08

puppet func killed_player():
	print("killed player")

puppet func revived():
	print("player revived")



puppet func update_state(p_position, p_velocity, p_rotation):
	puppet_position = p_position
	puppet_velocity = p_velocity
	puppet_rotation = p_rotation
	
	$Tween.interpolate_property(self, "global_transform", global_transform, Transform(global_transform.basis, p_position), 0.1)
	$Tween.start()

func _on_NetworkTickRate_timeout():
	if is_network_master():
		rpc_unreliable("update_state", global_transform.origin, velocity, Vector2(cam.rotation.x, cam.rotation.y))
	else:
		$NetworkTickRate.stop()


