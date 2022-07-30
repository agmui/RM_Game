extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 1
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

var velocity = Vector3.ZERO
var id
export var health = 60
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
	#$Head_Pivot/Camera.add_child(UI)
	UI.change_health(600)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # keep mouse in the middle of the screen
	$Head_Pivot/Camera.current = false#is_network_master()


func _physics_process(delta):
	if dead:
		return
	global_transform.origin = puppet_position
		
	velocity.x = puppet_velocity.x
	velocity.y = puppet_velocity.y
		
	cam.rotation.y = puppet_rotation.y
	cam.rotation.x = puppet_rotation.x
	if !$Tween.is_active():
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
	if body.is_in_group("bullet"):# and !is_network_master():
		if !dead:
			print(Network.player_list[id].name, " is taking dmg")
			health -= 10
			UI.change_health(health)
			rpc_unreliable("hit_panel_server", id, health)
			if health == 0:
				$Head_Pivot.rotation.x = deg2rad(-30) #TODO lock all movement
				print(id, " dead")
				dead = true
				$ReviveTimer.start()
				rpc_unreliable_id(id, "killed_server")
				rpc_unreliable("killed_player")

puppet func fired():
	var b = bullet.instance() # making an object b (kinda like Bullet b = new Bullet)
	$Head_Pivot/Barrel_Spawn.add_child(b) # spawning bullet to head
	b.shoot = true # lets bullet move

puppet func update_beyblade():
	$Pivot.rotation.y -= .08
	$CollisionShape.rotation.y -= .08
	$PanelHitbox.rotation.y -= .08

puppet func killed_player():
	print("killed player")

puppet func revived():
	print("player revived")

puppet func update_state_server(p_position, p_velocity, p_rotation):
	puppet_position = p_position
	puppet_velocity = p_velocity
	puppet_rotation = p_rotation
	
	$Tween.interpolate_property(self, "global_transform", global_transform, Transform(global_transform.basis, p_position), 0.1)
	$Tween.start()
	
	rpc_unreliable("update_state", p_position, p_velocity, p_rotation)
