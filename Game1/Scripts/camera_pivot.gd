extends Node3D

@export var sensi := 5.0
@export var tilt_limit := 0.9  # up/down camera angle clamp

func _ready():
	add_to_group("camera_pivot")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotation.x = clamp(rotation.x - event.relative.y / 1000 * sensi, -tilt_limit, tilt_limit)
		rotation.y -= event.relative.x / 1000 * sensi

	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
