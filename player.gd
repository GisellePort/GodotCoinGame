extends CharacterBody2D

# Movement speed 
const SPEED = 150
#  jump velocity
const JUMP_VELOCITY = -300
# Gravity 
const GRAVITY = 600

func _physics_process(delta):
	var direction = 0

	# Check left/right input
	if Input.is_action_pressed("ui_left"):
		direction -= 1
	if Input.is_action_pressed("ui_right"):
		direction += 1

	# Apply horizontal movement
	velocity.x = direction * SPEED

	# Gravity or Jump logic
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		# If on floor and jump pressed
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY

	# Animation selection 
	var anim = $AnimatedSprite2D
	if not is_on_floor():
		anim.play("jump")
	elif direction != 0:
		anim.play("run")
	else:
		anim.play("idle")

	# Apply 
	move_and_slide()
