extends Node

var player_score = 0
var ai_score = 0

# Connect the Area2D signal in the editor or use this in the _ready function
func _ready():
	update_score_ui()

# Signal handler for when the ball enters a goal area
func update_score_ui():
	$PlayerScoreLabel.text = str(player_score)
	$AIScoreLabel.text = str(ai_score)

func _on_left_goal_body_entered(body):
	ai_score += 1
	update_score_ui()
	$Ball.reset_ball(-1)

func _on_right_goal_body_entered(body):
	player_score += 1
	update_score_ui()
	$Ball.reset_ball(1)

func _on_player_paddle_body_entered(body):
	pass # Replace with function body.
