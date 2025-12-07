extends RigidBody3D   


func _ready():
	add_to_group("balls")  # optional


func _on_area_3d_body_entered(body: Node3D) -> void:
	if not body.is_in_group("player"):
		return
	
	print("Ball hit the player!")
	queue_free()
	get_tree().change_scene_to_file("res://Game1/Scenes/Platformer.tscn")
