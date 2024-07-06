extends KinematicBody2D
class_name BounceBall

onready var bounce_sfx = $"%bounce_SFX"
onready var sprite = $sprite

var previous_ball: BounceBall
var pin_line: Line2D
var time_multiplier: float
var y_value: float = 100
var bounce_value: float


func _ready() -> void:
	# WAIT BEFORE START
	set_process(false)
	yield(get_tree().create_timer(5), "timeout")
	set_process(true)


func _process(delta) -> void:
	var velocity = Vector2(0, ((y_value - bounce_value) * time_multiplier) * delta)
	var info: KinematicCollision2D = move_and_collide(velocity)
	
	# SETUP PIN LINE
	if pin_line and previous_ball:
		pin_line.points[0] = global_position
		pin_line.points[1] = previous_ball.global_position
	
	# SIMULATE BOUNCE
	if info:
		if bounce_value <= 0:
			bounce_value = y_value * 2
			bounce_sfx.play()

	if bounce_value > 0:
		bounce_value -= (y_value / 10) * time_multiplier * delta


func _pin_line_to_ball(ball: BounceBall, pin_line_parent: Node2D) -> void:
	previous_ball = ball
	pin_line = Line2D.new()
	pin_line_parent.add_child(pin_line)
	
	# SETUP
	pin_line.add_point(Vector2.ZERO)
	pin_line.add_point(Vector2.ZERO)
	pin_line.width = 3
	pin_line.default_color = Color.white

