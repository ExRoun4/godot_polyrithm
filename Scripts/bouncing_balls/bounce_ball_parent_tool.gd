extends Node2D

export(int, 1, 50) var balls_count
export(float, 10, 50) var balls_x_step

onready var pin_lines = $"%pin_lines"

const ball_prefab = preload("res://Prefabs/bouncing_balls/bounce_ball.tscn")


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# VALUES
	var x_step: float
	var time_value: float = 1
	var hsv_value: float = 0
	var last_ball: BounceBall
	
	# SETUP BALLS
	for i in range(1, balls_count+1):
		var new_ball: BounceBall = ball_prefab.instance()
		add_child(new_ball)
		
		# TIME
		new_ball.bounce_sfx.pitch_scale -= time_value / 20
		new_ball.time_multiplier = time_value
		time_value += 0.31
			
		# HSV COLOR
		new_ball.sprite.self_modulate = Color.from_hsv(hsv_value, 1, 1)
		hsv_value += 0.02
		# PIN LINES
		if i != balls_count+1:
			new_ball._pin_line_to_ball(last_ball, pin_lines)
		last_ball = new_ball
		
		# SET POS AND HSV COLOR
		new_ball.position.x = x_step
		x_step += balls_x_step
