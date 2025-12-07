extends CharacterBody3D

const WALK_SPEED = 5.0
const RUN_SPEED = 10.0
const JUMP_VELOCITY = 4.5
const GRAVITY = 9.8

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var is_jumping = false

func _ready():
	add_to_group("player")
	animation_tree.active = true
	state_machine.travel("Idle")


func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = 0.0

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		state_machine.travel("Jumping")

	# --- BASIC MOVEMENT (NO CAMERA) ---
	var input_dir = Input.get_vector("left", "right", "backward", "forward")

	# Convert to world space direction based on player's orientation
	var forward = -transform.basis.z
	var right   =  transform.basis.x

	var direction = (right * input_dir.x + forward * input_dir.y).normalized()
	direction = direction.rotated(Vector3.UP, get_tree().get_nodes_in_group("Camera_Pivot")[0].rotation.y)

	# Speed
	var current_speed = WALK_SPEED
	if Input.is_action_pressed("sprint"):
		current_speed = RUN_SPEED

	# Apply movement
	if direction.length() > 0.01:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)
		velocity.z = move_toward(velocity.z, 0, WALK_SPEED)

	move_and_slide()

	# Jump animation control
	if is_jumping:
		state_machine.travel("Jumping")
		if not is_on_floor():
			return
		is_jumping = false

	# Locomotion animation
	if direction.length() > 0.1:
		if Input.is_action_pressed("sprint"):
			state_machine.travel("Running")
		else:
			state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
