extends Area3D

const BALL_SCENE: PackedScene = preload("res://Game1/Scenes/ball.tscn")

var _already_triggered := false

@onready var spawn_points: Array[Marker3D] = [
	$SpawnPoint1,
	$SpawnPoint2,
	$SpawnPoint3,
	$SpawnPoint4,
	$SpawnPoint5,
	$SpawnPoint6,
	$SpawnPoint7
	,
]

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if _already_triggered:
		return

	if not body.is_in_group("player"):
		return

	_already_triggered = true

	for point in spawn_points:
		var ball := BALL_SCENE.instantiate()
		ball.global_position = point.global_position
		get_tree().current_scene.add_child(ball)
