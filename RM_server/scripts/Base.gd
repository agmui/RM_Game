extends StaticBody

export var team = ""
export var health = 2000
var dead = false

var red_base = preload("res://art/Map/RedThing.glb").instance() 
var blue_base = preload("res://art/Map/BlueThing.glb").instance() 

func _ready():
	$RedThing.queue_free()
	add_child(blue_base if team=="blue" else red_base)

func _on_PanelHitbox_body_entered(body):
	if Global.server: # TODO disconnect when not LAN
		return
	if team == "blue" and Global.blue_sentry_alive:
		print("sentry not dead")
		return
	elif team == "red" and Global.red_sentry_alive:
		print("sentry not dead")
		return

	#TODO check if bullet is moving fast enough
	if body.is_in_group("bullet"):# iff a bullet hits yourself
		if !dead:#if you get hit
			print(team, " Base is taking dmg")
			health -= 10
			if health == 0:
				print("dead")
				dead = true
				rpc_unreliable("killed", team)
			rpc_unreliable("hit_panel", team, health) #tell other base
			Global.emit_signal("change_health", team+"_base", health) #tell master player ui sentry got hit

# puppet func hit_panel(other_team, current_health):
# 	Global.emit_signal("change_health", other_team+"_base", current_health) #tell master player ui sentry got hit

master func killed(t):
	if team == t:
		print("base destroyed")
		dead = true
		health = 0
