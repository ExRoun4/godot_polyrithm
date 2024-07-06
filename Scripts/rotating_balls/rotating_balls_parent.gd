extends Node2D

onready var circle = $"%circle"

export(int, 1, 50) var balls_count
export(float, 10, 50) var balls_y_step

const ball_prefab = preload("res://Prefabs/rotation_balls/rotating_ball.tscn")


func _process(delta):
	circle.modulate = Color.from_hsv(OS.get_ticks_msec() / 10000.0, 1, 1, 1)


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	var y_step: float = balls_y_step
	var time_value: float = 1
	
	# SETUP BALLS
	for i in range(1, balls_count+1):
		var new_ball: RotatingBall = ball_prefab.instance()
		add_child(new_ball)
		
		# INGAME SET UP
		if not Engine.is_editor_hint():
			# TIME
			new_ball.sfx.pitch_scale += time_value / 20
			new_ball.time_multiplier = time_value
			time_value += 0.11
			# HSV
			new_ball.sprite.self_modulate = Color.from_hsv(OS.get_ticks_msec() / 10000.0, 1, 1, 1)

		new_ball.body.position.y = -y_step
		y_step += balls_y_step


func _detect_area_got_ball(body: KinematicBody2D):
	body.get_parent()._dang()
