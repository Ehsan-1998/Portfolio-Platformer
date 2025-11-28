extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const GRAVITY = 9.8
@onready var animation_tree: AnimationTree = $AnimationTree



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = 0.0

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle movement
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Rotate direction based on camera pivot
	direction = direction.rotated(Vector3.UP, get_tree().get_nodes_in_group("camera_pivot")[0].rotation.y)

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	animate()

func animate():
	var moving = abs(velocity.x) + abs(velocity.z) > 0.1
	$AnimationTree["parameters/conditions/isMoving"] = moving
	$AnimationTree["parameters/conditions/isNotMoving"] = !moving
	
	
	var running = Input.is_action_pressed("sprint")
	$AnimationTree["parameters/conditions/isRunning"] = running
	$AnimationTree["parameters/conditions/isNotRunning"] = !running
	
	
	$AnimationTree["parameters/conditions/isJumpPressed"] = Input.is_action_just_pressed("jump")
	$AnimationTree["parameters/conditions/isGrounded"] = is_on_floor()
	


	


	
	
	
