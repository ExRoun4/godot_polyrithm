extends Node2D
class_name RotatingBall

onready var body = $"%body"
onready var sfx = $"%SFX"
onready var sprite = $"%sprite"
onready var dang_tween = $"%dang_tween"

var time_multiplier: float = 1
var started: bool


func _ready() -> void:
	# WAIT BEFORE START
	yield(get_tree().create_timer(5), "timeout")
	started = true
	_dang()


func _process(delta):
	sprite.self_modulate = Color.from_hsv(OS.get_ticks_msec() / 10000.0, 1, 1, 1)
	if not started: return
	rotation_degrees -= 50 * time_multiplier * delta


func _dang() -> void:
	var saved_color: Color = sprite.self_modulate
	sfx.play(0.3)
	dang_tween.interpolate_property(sprite, "self_modulate", sprite.self_modulate, Color.white, 0.5)
	dang_tween.start()
	yield(dang_tween, "tween_completed")
	dang_tween.interpolate_property(sprite, "self_modulate", sprite.self_modulate, saved_color, 0.7)
	dang_tween.start()
