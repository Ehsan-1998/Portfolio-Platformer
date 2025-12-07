extends Area3D

const PARTICLES_SCENE := preload("res://Game1/Scenes/Particles.tscn")
var triggered := false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if triggered:
		return
	if not body.is_in_group("player"):
		return

	triggered = true
	_spawn_fireworks()

func _spawn_fireworks():
	var fireworks := PARTICLES_SCENE.instantiate()

	# Spawn fireworks slightly above the WinZone
	fireworks.global_position = global_position + Vector3(0, 3, 0)

	get_tree().current_scene.add_child(fireworks)
