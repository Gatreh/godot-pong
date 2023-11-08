extends RigidBody2D

# Adjust these variables as needed for your game's needs
var speed: float = 200

func _physics_process(delta: float) -> void:
	var direction: float = 0
	if Input.is_action_pressed('up'):
		direction -= 1
	if Input.is_action_pressed('down'):
		direction += 1

	# Move the paddle up or down by adjusting its vertical velocity
	linear_velocity = Vector2(0, speed * direction)
	
	# Keep the paddle within the screen bounds
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)
