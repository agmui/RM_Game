extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 1
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

var velocity = Vector3.ZERO
var id
var team
export var health = 100
var revive_health = 100
var fire_cooldown = false
var dead = false
var sensitivity;
var barrel_heat = 0
var barrel_heat_rate = 10
var head_acc = 0 # when the player dies or overheats just have the head exponetaly plop down
var xp = 0
var lv = 1
var num_bullets = 0
var money = 200
var health_packs = 0

var debug = true


var UI = preload("res://scenes/UI.tscn").instance()

var pause_menu = preload("res://scenes/PauseMenu.tscn").instance()
var blue_standard = preload("res://art/player_model/CarBlue.glb").instance()
var red_standard = preload("res://art/player_model/CarRed.glb").instance()

onready var cam = get_node("Head_Pivot")
onready var bullet = preload("res://scenes/Bullet.tscn") # loading in bullet into var

var puppet_position = Vector3()
var puppet_velocity = Vector3()
var puppet_rotation = Vector2()

#export(NodePath) onready var health_bar = get_node(health_bar) as TextureProgress

func _ready():
	# debugging======
	if Global.debug:
		barrel_heat_rate = 1
		num_bullets = 200
	#===============
	if is_network_master():
		# UI = preload("res://scenes/UI.tscn").instance()

		Global.connect("change_health", self, "change_health")
		Global.connect("add_bullets", self, "add_bullets")
		$Head_Pivot/Camera.add_child(UI)
		UI.change_health(health)
		$Head_Pivot/Camera.add_child(pause_menu)
		pause_menu.hide()
		sensitivity = UI.mouse_sensitivity;
	# changes skin color
	$Pivot/CarRed.queue_free()
	$Pivot.add_child(blue_standard if team=="blue" else red_standard)
	$Head_Pivot/Camera.current = is_network_master()

func _input(event):
	if !is_network_master():
		return
	if dead:
		return
	if event is InputEventMouseMotion and !pause_menu.paused and !UI.paused:
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
		if Input.is_action_just_pressed("f12"):
			UI.toggle_tips()
		if (Input.is_action_just_pressed("P")):
			UI.toggle_settings()
			sensitivity = UI.mouse_sensitivity;
	# ==============================================================
		if dead: # power down animation
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
		if Input.is_action_pressed("fire") and !fire_cooldown and !pause_menu.paused and !UI.paused and num_bullets > 0:
			var b = bullet.instance() # making an object b (kinda like Bullet b = new Bullet)
			$Head_Pivot/Barrel_Spawn.add_child(b) # spawning bullet to head
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
				barrel_heat += barrel_heat_rate
				UI.set_heat(barrel_heat)
				num_bullets -= 1
				UI.change_bullet_display(num_bullets)
		if Input.is_action_just_pressed("buy"):
			print("buy")
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
	# tell sentry the position of players
	Global.player_pos[id] = [$PanelHitbox/right.global_translation,
							$PanelHitbox/left.global_translation,
							$PanelHitbox/front.global_translation,
							$PanelHitbox/back.global_translation]

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
	health = revive_health
	UI.change_health(health)
	print("revived")
	rpc_unreliable("revived")

func _on_PanelHitbox_body_entered(body):
# master func _on_PanelHitbox_body_entered(body):
	if Global.server: # TODO disconnect when not LAN
		return
	#TODO check if bullet is moving fast enough
	if is_network_master():
		print("HIT ")
	if body.is_in_group("bullet") and is_network_master():# iff a bullet hits yourself
		# print(body.player_owner)
		if !dead:#if you get hit
			print(Network.player_list[id].name, " is taking dmg from ", body.player_owner)
			health -= 10
			UI.change_health(health)# FIXME should not be posible
			if health == 0:
				#$Head_Pivot.rotation.x = deg2rad(-30) #TODO lock all movement
				print("dead")
				dead = true
				$ReviveTimer.start()
				if $ReviveTimer.wait_time <= 45:
					$ReviveTimer.wait_time += 5
				if !Global.server:
					rpc_unreliable("killed_player", body.player_owner)#FIXME
			#STEP 1
			rpc_unreliable("hit_panel", health, body.player_owner) #tell eveyonelse ui to you getting hit


func _on_rfid_area_entered(area):
	if area.name == team and is_network_master():
		UI.toggle_buy_screen(true)

func _on_rfid_area_exited(area):
	if area.name == team and is_network_master():
		UI.toggle_buy_screen(false)

func add_bullets(add_num):
	num_bullets += add_num
	UI.change_bullet_display(num_bullets)

puppet func hit_panel(current_health, attacker):
	if !is_network_master():
		#STEP 2
		#go to global to find right node
		Global.emit_signal("change_health", 
		get_tree().get_rpc_sender_id(), current_health, attacker)

remote func hit_panel_server(p_id, current_health):
	#STEP 2 for server
	if !is_network_master():
		#STEP 2
		#go to global to find right node
		Global.emit_signal("change_health", 
		p_id, current_health)
	else:
		print(Network.player_list[id].name, " is taking dmg")
		health -= 10
		UI.change_health(health)# FIXME should not be posible

master func change_health(player_id, current_health, attacker):
	#STEP 3
	#after returning from global
	print("changing " ,player_id, "\'s health, got hit by ", attacker)
	match player_id:
		"red_sentry":
			UI.change_sentry(player_id, current_health)
		"blue_sentry":
			UI.change_sentry(player_id, current_health)
		"red_base":
			UI.change_base(player_id, current_health)
		"blue_base":
			UI.change_base(player_id, current_health)
		_:
			# print("changing health for ",Network.player_list[player_id].name)
			UI.change_enemy_health(player_id, current_health)
	if str(attacker) == str(id): # FIXME
		# add xp for attacker
		print("add xp for ", attacker)
		xp += 1
		if current_health <= 0:
			print("you killed ",Network.player_list[player_id].name)
			xp += 10
		if xp >= 30 and lv != 3:# lv up
			print("lv up")
			xp -= 50
			revive_health += 100
			health = revive_health
			barrel_heat_rate -= 2

master func killed_server():
	print("dead")
	dead = true
	$ReviveTimer.start() # TODO make this server side

puppet func fired():
	var b = bullet.instance() # making an object b (kinda like Bullet b = new Bullet)
	$Head_Pivot/head.add_child(b) # spawning bullet to head
	b.shoot = true # lets bullet move
	b.player_owner = id
	# print(id)


puppet func update_beyblade():
	$Pivot.rotation.y -= .08
	$CollisionShape.rotation.y -= .08
	$PanelHitbox.rotation.y -= .08

puppet func overheat():
	print(Network.player_list[get_tree().get_rpc_sender_id()].name," overheated")

puppet func killed_player(killer):
	print(Network.player_list[get_tree().get_rpc_sender_id()].name," was killed by ", killer)

puppet func revived():
	var player_id = get_tree().get_rpc_sender_id()
	print(Network.player_list[player_id].name," revived")
	health = revive_health
	Global.emit_signal("change_health", player_id, health)
	# FIXME update other players when revived
	
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
