extends Node3D

@export var sensi := 5.0

# Limits (your requested values)
const PITCH_MAX = deg_to_rad(45)
const PITCH_MIN = deg_to_rad(-45)
const YAW_MAX   = deg_to_rad(45)
const YAW_MIN   = deg_to_rad(-45)

var base_pitch := 0.0
var base_yaw := 0.0

var pitch_offset := 0.0
var yaw_offset := 0.0

func _ready():
	add_to_group("camera_pivot")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	# Store initial rotation (this is based on your screenshot!)
	base_pitch = rotation.x
	base_yaw = rotation.y

func _input(event):
	if event is InputEventMouseMotion:

		# Update offsets based on mouse movement
		pitch_offset -= event.relative.y * sensi * 0.001
		yaw_offset   -= event.relative.x * sensi * 0.001

		# Clamp the offsets
		pitch_offset = clamp(pitch_offset, PITCH_MIN, PITCH_MAX)
		yaw_offset   = clamp(yaw_offset,   YAW_MIN,  YAW_MAX)

		# Apply final rotation = initial_rotation + offset
		rotation = Vector3(
			base_pitch + pitch_offset,
			base_yaw   + yaw_offset,
			0.0  # no roll
		)

	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
