extends RigidBody

signal hit

var shoot = false

const DAMAGE = 10
const SPEED = 13 # max speed of 30 m/s


# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true) # makes it no longer a chiled of what ever object it is added too

func _physics_process(delta):
	if shoot:
		apply_impulse(-transform.basis.x, transform.basis.x * SPEED) # applys a sudden push to bullet
		shoot = false
		# TODO add air resistance


func _on_Area_body_entered(body): # collision detection
	queue_free()

