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
