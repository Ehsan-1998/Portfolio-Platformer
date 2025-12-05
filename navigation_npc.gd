extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

var speed := 4.0

func _ready():
	add_to_group("enemies")
	navigation_agent_3d.velocity_computed.connect(_on_velocity_computed)
	navigation_agent_3d.target_reached.connect(_on_target_reached)

func _physics_process(delta):
	# Get next point along the path
	var next_point: Vector3 = navigation_agent_3d.get_next_path_position()

	# Calculate direction
	var direction: Vector3 = (next_point - global_position).normalized()

	# Desired velocity for NavigationAgent3D
	var desired_velocity := direction * speed

	# Give velocity to NavigationAgent3D (NOT to CharacterBody3D)
	navigation_agent_3d.set_velocity(desired_velocity)

	# We DO NOT directly do move_and_slide() anymore
	# NavigationAgent calculates safe velocity

func update_target_location(target_location: Vector3):
	navigation_agent_3d.set_target_position(target_location)

func _on_velocity_computed(safe_velocity: Vector3):
	# Apply navigation movement safely
	velocity = safe_velocity
	move_and_slide()

func _on_target_reached():
	print("Target reached! Resetting scene.")
	


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("Enemy caught the player!")
		get_tree().change_scene_to_file("res://Game1/Scenes/Platformer.tscn")
