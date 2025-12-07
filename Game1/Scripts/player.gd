extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var armature: Node3D = $Armature

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	# Release mouse when pressing ESC
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	# Recapture mouse when clicking anywhere
	if event is InputEventMouseButton and event.pressed:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "forward","backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, get_tree().get_nodes_in_group("Camera_Pivot")[0].rotation.y)

	var sprint_factor = 1
	if direction:
		if Input.is_action_pressed("sprint"):
			sprint_factor = 2
		armature.rotation.y = lerp_angle(armature.rotation.y, atan2(velocity.x, velocity.z), 0.15)
		velocity.x = direction.x * SPEED * sprint_factor
		velocity.z = direction.z * SPEED * sprint_factor
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	handle_animations(input_dir)

func handle_animations(input_dir):
	animation_tree.set("parameters/conditions/Idle", input_dir == Vector2.ZERO && is_on_floor() && !Input.is_action_pressed("sprint"))
	animation_tree.set("parameters/conditions/Walk", input_dir != Vector2.ZERO && is_on_floor() && !Input.is_action_pressed("sprint"))
	animation_tree.set("parameters/conditions/Jumping", Input.is_action_just_pressed("jump"))
	animation_tree.set("parameters/conditions/Running", Input.is_action_pressed("sprint") && input_dir != Vector2.ZERO)
