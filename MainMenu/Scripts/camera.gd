extends Node3D


var player
var sensitivity = 5

func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]
	
	
func  _physics_process(delta):
	self.global_position = player.global_position
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#rotation.x -= event.relative.y/1000* sensitivity
		print(rotation.x)
		
		rotation.x = clamp(rotation.x- event.relative.y/1000* sensitivity,-0.6,0.6)
		rotation.y -= event.relative.x/1000* sensitivity
