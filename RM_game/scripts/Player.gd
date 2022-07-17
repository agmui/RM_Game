extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 1
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

var velocity = Vector3.ZERO
var id
var team
export var health = 60
var fire_cooldown = false
var dead = false
var sensitivity = .2
var barrel_heat = 0
var head_acc = 0 # when the player dies or overheats just have the head exponetaly plop down

var UI = preload("res://scenes/UI.tscn").instance()
var pause_menu = preload("res://scenes/PauseMenu.tscn").instance()
#var blue_standard = preload("res://art/blue_standard.glb").instance()
#var red_standard = preload("res://art/red_standard.glb").instance()

onready var cam = get_node("Head_Pivot")
onready var bullet = preload("res://scenes/Bullet.tscn") # loading in bullet into var

var puppet_position = Vector3()
var puppet_velocity = Vector3()
var puppet_rotation = Vector2()

#export(NodePath) onready var health_bar = get_node(health_bar) as TextureProgress

func _ready():
	if is_network_master():
		# Global.connect("change_enemy_health", self, "_change_enemy_health")
		#var camera = Camera.new()
		#camera.name = "Camera"
		#camera.translate(Vector3(0, 0.2, -0.218))
		#$Head_Pivot.add_child(camera)
		$Head_Pivot/Camera.add_child(UI)
		UI.change_health(health, id)
		$Head_Pivot/Camera.add_child(pause_menu)
		pause_menu.hide()
		
	# changes skin color
	#$Pivot.add_child(blue_standard if team=="blue" else red_standard)
	$Head_Pivot/Camera.current = is_network_master()

func _change_enemy_health(id, health):
	UI._change_enemy_health(id, health)

func _input(event):
	if !is_network_master():
		return
	if dead:
		return
	if event is InputEventMouseMotion and !pause_menu.paused:
		var movement = event.relative
		cam.rotation.x += -deg2rad(movement.y*sensitivity) # rotating virticaly
		cam.rotation.x = clamp(cam.rotation.x, deg2rad(-40), deg2rad(60)) #limit cam rotation
		cam.rotation.y += -deg2rad(movement.x*sensitivity) # rotating horizontaly


func _physics_process(delta):
	if is_network_master():
		if Input.is_action_just_pressed("pause_menu"):
			if !pause_menu.paused:
				pause_menu.show()
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			else:
				pause_menu.hide()
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			pause_menu.paused = !pause_menu.paused
# ==============================================================
		if dead:
			if $Head_Pivot.rotation_degrees.x > -30:
				head_acc-= deg2rad(35)*delta
				$Head_Pivot.rotation.x += head_acc
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
		if Input.is_action_pressed("fire") and !fire_cooldown and !pause_menu.paused:
			var b = bullet.instance() # making an object b (kinda like Bullet b = new Bullet)
			$Head_Pivot/head.add_child(b) # spawning bullet to head
			rpc_unreliable("fired")
			b.shoot = true # lets bullet move
			$FireCooldown.start()
			fire_cooldown = true
			if barrel_heat >= 100:
				#overhead shut down
				print("overheating")
				dead = true
				$OverheatTimer.start()
				rpc_unreliable("overheat")
			else:
				barrel_heat += 10
				UI.set_heat(barrel_heat)

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

func _on_OverheatTimer_timeout():
	head_acc = 0
	dead = false
	rpc_unreliable("revived")

func _on_FireCooldown_timeout():
	fire_cooldown = false

func _on_ReviveTimer_timeout():
	head_acc = 0
	dead = false
	$ReviveTimer.stop()
	health = 600
	UI.change_health(health, id)
	print("revived")
	rpc_unreliable("revived")

func _on_PanelHitbox_body_entered(body):
	if Global.server: # TODO disconnect when not LAN
		return
	#TODO check if bullet is moving fast enough
	if body.is_in_group("bullet") and is_network_master():# iff a bullet hits yourself
		hit_panel()#change your ui to being hit
		rpc_unreliable("hit_panel") #tell eveyonelse ui to you getting hit

remote func hit_panel():
	if !is_network_master():#if enemy gets hit
		#might not be root ui node to display
		pass
	elif !dead:#if you get hit
		print(Network.player_list[id].name, " is taking dmg")
		health -= 10
		UI.change_health(health, id)# FIXME should not be posible
		if health == 0:
			# TODO use lerp
			#$Head_Pivot.rotation.x = deg2rad(-30) #TODO lock all movement
			print("dead")
			dead = true
			$ReviveTimer.start()
			if !Global.server:
				rpc_unreliable("killed_player")

puppet func fired():
	var b = bullet.instance() # making an object b (kinda like Bullet b = new Bullet)
	$Head_Pivot/head.add_child(b) # spawning bullet to head
	b.shoot = true # lets bullet move


puppet func update_beyblade():
	$Pivot.rotation.y -= .08
	$CollisionShape.rotation.y -= .08
	$PanelHitbox.rotation.y -= .08

puppet func overheat():
	print(Network.player_list[get_tree().get_rpc_sender_id()]," overheated")

puppet func killed_player():
	print(Network.player_list[get_tree().get_rpc_sender_id()]," was killed")

puppet func revived():
	print(Network.player_list[get_tree().get_rpc_sender_id()]," revived")
	health = 100
	UI.change_health(health)
	
# may cause problems when running LAN because it is suppose to be puppet
remote func update_state(p_position, p_velocity, p_rotation):
	if is_network_master():
		return
	puppet_position = p_position
	puppet_velocity = p_velocity
	puppet_rotation = p_rotation
	$Tween.interpolate_property(self, "global_transform", global_transform, Transform(global_transform.basis, p_position), 0.1)
	$Tween.start()

func _on_NetworkTickRate_timeout():
	if is_network_master():
		if Global.server:
			rpc_unreliable_id(1,"update_state_server", global_transform.origin, velocity, Vector2(cam.rotation.x, cam.rotation.y))
		else:
			rpc_unreliable("update_state", global_transform.origin, velocity, Vector2(cam.rotation.x, cam.rotation.y))
		if barrel_heat > 0:
			barrel_heat -= .5
			UI.set_heat(barrel_heat)
	else:
		$NetworkTickRate.stop()
