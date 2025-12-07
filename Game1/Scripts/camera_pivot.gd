extends Node3D


var player

var sen = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("player")[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.global_position = player.global_position
	
func _input(event):
	if event is InputEventMouseMotion:
		rotation.x = clamp(rotation.x-event.relative.y/1000*sen, -0.6 , 0.6)
		
		rotation.y -=event.relative.x/1000*sen
