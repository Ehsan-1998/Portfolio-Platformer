extends AnimatableBody3D

@export var start: Vector3
@export var stop: Vector3
@export var duration: float = 2.0

enum LAST_FLAG { START, END }
var last_flag := LAST_FLAG.START

func _ready() -> void:
	position = start
	start_animation()

func start_animation() -> void:
	var tween := create_tween()
	var target := stop if last_flag == LAST_FLAG.START else start

	tween.tween_property(self, "position", target, duration)

	tween.finished.connect(func():
		last_flag = LAST_FLAG.END if last_flag == LAST_FLAG.START else LAST_FLAG.START
		start_animation()
	)
