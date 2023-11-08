extends RigidBody2D

var initial_speed = 400  # The initial speed of the ball
var middle_of_screen = Vector2(575, 325)
var resets = 0
var side = 1
var ignore_next_collision = false
var resetframes := 0

func _ready():
	reset_ball(side)

func reset_ball(newSide: int):
	side = newSide
	linear_damp = 0
	angular_damp = 0
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	position = middle_of_screen
	ignore_next_collision = true
	resetframes = 0
	call_deferred("_set_new_direction")

func _set_new_direction():
	randomize()  # Ensure that the random values are not the same every time you run the scene
	var direction := Vector2(side, randf_range(-1, 1)).normalized()  # Random initial direction
	linear_velocity = direction * initial_speed  # Apply the initial speed in the chosen direction

func _integrate_forces(state):
	if ignore_next_collision:
		resetframes += 1
		if resetframes > 10:
			ignore_next_collision = false  # Reset the flag
			return  # Skip the rest of the method for this frame
		return
	var local_linear_velocity = state.get_linear_velocity()
	var speed = local_linear_velocity.length()  # Get the current speed (magnitude of the velocity)
	
	# Check for bounces and invert the appropriate velocity component
	if state.get_contact_count() > 0:
		for i in range(state.get_contact_count()):
			var collision = state.get_contact_local_normal(i)
			if collision.x != 0:
				local_linear_velocity.x *= -1  # Invert the horizontal component
			if collision.y != 0:
				local_linear_velocity.y *= -1  # Invert the vertical component
				
	state.set_linear_velocity(local_linear_velocity.normalized() * speed)  # Reapply the speed
