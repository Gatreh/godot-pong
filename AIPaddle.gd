extends RigidBody2D

var speed := 150
var ball: RigidBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	ball = get_node("../Ball")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = 0
	if ball.global_position.y < global_position.y + 150:
		direction = -0.9
	elif ball.global_position.y > global_position.y:
		direction = 0.9

	linear_velocity = Vector2(0, direction * speed)
##	pass
