extends Node3D

@export var player_scene: PackedScene
# Called when the node enters the scene tree for the first time.
@onready var spawn_marker: Marker3D = $SpwanMarks/PlayerSpawn
func _ready():
	if player_scene and spawn_marker:
		var player_instance = player_scene.instantiate()
		add_child(player_instance)
		player_instance.global_position = spawn_marker.global_position
		player_instance.velocity = Vector3.ZERO  # ✅ no check needed
	else:
		print("ERROR: Player Scene or Spawn Marker missing!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_pressed() -> void:
	SceneManager.change_scene("res://MainMenu/Scenes/main_menu.tscn", {
	})
