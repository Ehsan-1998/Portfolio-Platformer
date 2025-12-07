extends Area3D

const PARTICLES_SCENE := preload("res://Game1/Scenes/Particles.tscn")
@onready var win_music: AudioStreamPlayer3D = $WinMusic

@onready var you_won_label: Label = $"../../CanvasLayer/YouWonLabel"

var triggered := false

func _ready():
	body_entered.connect(_on_body_entered)

	
	you_won_label.visible = false
	win_music.stop()



func _on_body_entered(body):
	if triggered:
		return
	if not body.is_in_group("player"):
		return

	triggered = true
	activate_win_sequence()


func activate_win_sequence():
	you_won_label.visible = true
	

	win_music.play()
	_spawn_fireworks()


func _spawn_fireworks():
	var fireworks := PARTICLES_SCENE.instantiate()
	fireworks.global_position = global_position + Vector3(0, 3, 0)
	get_tree().current_scene.add_child(fireworks)
