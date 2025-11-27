extends StaticBody3D

@onready var _mesh: MeshInstance3D = $MeshInstance3D
@onready var _collision: CollisionShape3D = $CollisionShape3D

@export var start: Vector3
@export var stop: Vector3
@export var duration: float
@export var _size: Vector3 =Vector3.ONE


enum LAST_FLAG { START, END }
var last_flag: LAST_FLAG = LAST_FLAG.START

func _ready() -> void:
	global_position = start
	start_animation()
	assign_size()
	
	
	
func assign_size() -> void:
	var mesh:BoxMesh = _mesh.mesh.duplicate()
	mesh.size = _size
	var collision_shape: BoxShape3D = _collision.shape.duplicate()
	collision_shape.size = _size
	
	_mesh.mesh = mesh
	_collision.shape = collision_shape

func start_animation() -> void:
	var tween: Tween = create_tween()

	if last_flag == LAST_FLAG.START:
		tween.tween_property(self, "global_position", stop, duration)
	else:
		tween.tween_property(self, "global_position", start, duration)

	tween.finished.connect(func():
		# flip the flag
		if last_flag == LAST_FLAG.START:
			last_flag = LAST_FLAG.END
		else:
			last_flag = LAST_FLAG.START

		# ALWAYS restart the animation
		start_animation()
	)
