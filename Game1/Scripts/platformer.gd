extends Node3D

@export var player_scene: PackedScene
@onready var spawn_marker: Marker3D = $SpwanMarks/PlayerSpawn

var player: CharacterBody3D = null   # Start as null

func _ready():
	if player_scene and spawn_marker:
		player = player_scene.instantiate()
		add_child(player)
		player.global_position = spawn_marker.global_position
	else:
		print("ERROR: Player Scene or Spawn Marker missing!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player == null:
		return  # Do NOT call enemy AI yet

	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)


func _on_exit_pressed() -> void:
	SceneManager.change_scene("res://MainMenu/Scenes/main_menu.tscn", {
	})


func _on_fallzone_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://Game1/Scenes/Platformer.tscn")
