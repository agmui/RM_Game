extends RigidBody

signal hit

var shoot = false

const DAMAGE = 10
const SPEED = 13  # max speed of 30 m/s


# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)  # makes it no longer a chiled of what ever object it is added too
	continuous_cd = true
	set_use_continuous_collision_detection(2)


func _physics_process(delta):
	if shoot:
		apply_impulse(transform.basis.z, -transform.basis.z * SPEED)  # applys a sudden push to bullet
		shoot = false
		# TODO add air resistance


const ERROR_AMOUNT = 0.00001


func _integrate_forces(state):
	var delta = state.get_step()
	var lv = state.get_linear_velocity()
	var heading = lv.normalized()
	var future_distance = lv.length()  # + your_acceleration

	var current_pos = translation
	var destination = current_pos + heading * future_distance

	var cast_result = state.get_space_state().intersect_ray(current_pos, destination, [self])

	if not cast_result.empty():
		var dist_to_wall = (current_pos - cast_result.position).length()

		# Check how many frames it can go at this rate,
		# if it is less than 1, it will pass through.
		if dist_to_wall / (future_distance * delta) < 1.0 + ERROR_AMOUNT:
			# Should put the object inside the wall a little,
			# so it can be detected.
			state.set_transform(Transform.translated(cast_result.position))

			# do_bullet_impact_here()
			queue_free()
			return


func _on_Area_body_entered(body):  # collision detection
	pass
	# if !body.is_in_group("players"):
	# 	# if $Timer.is_stopped():
	# 	print(get_tree().get_network_unique_id(), " says that: ", body, " has been hit")
	# 	queue_free()


func _on_Timer_timeout():
	pass
