extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 1

const rail_len = 100

var velocity = Vector3.ZERO
var team
export var health = 60
var fire_cooldown = false
var dead = false
var sensitivity = .2
var head_acc = 0 # when the player dies or overheats just have the head exponetaly plop down
var rng = RandomNumberGenerator.new()
var current_offset = 0
var offset = 0
var move = 0

onready var bullet = preload("res://scenes/Bullet.tscn") # loading in bullet into var

var puppet_position = Vector3.ZERO
var puppet_velocity = Vector3.ZERO
var puppet_rotation = Vector2.ZERO

func _ready():
	Global.connect("change_enemy_health", self, "change_health")
	rng.randomize()

	# changes skin color
	#$Pivot.add_child(blue_standard if team=="blue" else red_standard)

func _physics_process(delta):
	if true:#is_network_master(): #FIXME
		if dead: # power down animation
			if $Spatial/Pivot.rotation_degrees.x > -30:
				head_acc-= deg2rad(35)*delta
				$Spatial/Pivot.rotation.x += head_acc
			return
		# We create a local variable to store the input direction.
		var body_dir = Vector3.ZERO

		var random_number = 0#rng.randf_range(-10.0, 10.0)	
		# randomly change offset
		if random_number<1 and random_number>-1:
			offset = random_number#Vector2(random_number, random_number).dot(Vector2.RIGHT)
		if offset+current_offset>rail_len/2 or offset+current_offset<(-rail_len+24)/2:
			offset = -offset

		if offset > 0:
			body_dir.x += offset
			body_dir.z -= offset
		else:
			body_dir.x += offset
			body_dir.z -= offset
		current_offset += offset
		
		"""
		if !fire_cooldown:
			var b = bullet.instance() # making an object b (kinda like Bullet b = new Bullet)
			$Spatial/Pivot/Barrel.add_child(b) # spawning bullet to head
			rpc_unreliable("fired")
			b.shoot = true # lets bullet move
			$FireCooldown.start()
			fire_cooldown = true
		"""

		
		# Ground velocity
		velocity.x = body_dir.x
		velocity.z = body_dir.z
	else:
		# global_transform.origin = puppet_position
		
		velocity.x = puppet_velocity.x
		velocity.y = puppet_velocity.y
		
		$Spatial/Pivot.rotation.y = puppet_rotation.y
		$Spatial/Pivot.rotation.x = puppet_rotation.x
	if !$Tween.is_active():
		# Moving the character	
		velocity = move_and_slide(velocity, Vector3.UP)

func _on_FireCooldown_timeout():
	fire_cooldown = false

"""
func _on_ReviveTimer_timeout():
	head_acc = 0
	dead = false
	$ReviveTimer.stop()
	health = 100
	# UI.change_health(health)
	print("revived")
	rpc_unreliable("revived")

func _on_PanelHitbox_body_entered(body):
	if Global.server: # TODO disconnect when not LAN
		return
	#TODO check if bullet is moving fast enough
	if body.is_in_group("bullet") and is_network_master():# iff a bullet hits yourself
		if !dead:#if you get hit
			print(Network.player_list[id].name, " is taking dmg")
			health -= 10
			UI.change_health(health)# FIXME should not be posible
			if health == 0:
				#$Head_Pivot.rotation.x = deg2rad(-30) #TODO lock all movement
				print("dead")
				dead = true
				$ReviveTimer.start()
				if !Global.server:
					rpc_unreliable("killed_player")
			#STEP 1
			rpc_unreliable("hit_panel", health) #tell eveyonelse ui to you getting hit

puppet func hit_panel(current_health):
	if !is_network_master():
		#STEP 2
		#go to global to find right node
		Global.emit_signal("change_enemy_health", 
		get_tree().get_rpc_sender_id(), current_health)

remote func hit_panel_server(p_id, current_health):
	#STEP 2 for server
	if !is_network_master():
		#STEP 2
		#go to global to find right node
		Global.emit_signal("change_enemy_health", 
		p_id, current_health)
	else:
		print(Network.player_list[id].name, " is taking dmg")
		health -= 10
		UI.change_health(health)# FIXME should not be posible

master func change_health(player_id, current_health):
	#STEP 3
	#after returning from global
	print("changing health for ",Network.player_list[player_id].name)
	UI.change_enemy_health(player_id, current_health)

master func killed_server():
	print("dead")
	dead = true
	$ReviveTimer.start() # TODO make this server side

puppet func fired():
	var b = bullet.instance() # making an object b (kinda like Bullet b = new Bullet)
	$Head_Pivot/head.add_child(b) # spawning bullet to head
	b.shoot = true # lets bullet move

puppet func overheat():
	print(Network.player_list[get_tree().get_rpc_sender_id()]," overheated")

puppet func killed_player():
	print(Network.player_list[get_tree().get_rpc_sender_id()].name," was killed")

puppet func revived():
	var player_id = get_tree().get_rpc_sender_id()
	print(Network.player_list[player_id].name," revived")
	health = 100
	Global.emit_signal("change_enemy_health", player_id, health)

puppet func update_state(p_position, p_velocity, p_rotation):
	puppet_position = p_position
	puppet_velocity = p_velocity
	puppet_rotation = p_rotation
	$Tween.interpolate_property(self, "global_transform", global_transform, Transform(global_transform.basis, p_position), 0.1)
	$Tween.start()

func _on_NetworkTickRate_timeout():
	if is_network_master():
		if Global.server:
			rpc_unreliable_id(1,"update_state_server", global_transform.origin, velocity, Vector2($Spatial/Pivot.rotation.x, $Spatial/Pivot.rotation.y))
		else:
			rpc_unreliable("update_state", global_transform.origin, velocity, Vector2($Spatial/Pivot.rotation.x, $Spatial/Pivot.rotation.y))

	else:
		$NetworkTickRate.stop()

"""
