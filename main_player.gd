extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
const GRAVITYCOEFFICIENT = 0.6

var movementSmoothing = 0.2


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAVITYCOEFFICIENT

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED * (movementSmoothing)
		if movementSmoothing < 1:
			movementSmoothing += 0.03
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		movementSmoothing = move_toward(movementSmoothing, 0.2, 0.1)

	move_and_slide()
