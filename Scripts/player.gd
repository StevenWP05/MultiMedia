extends CharacterBody3D


var SPEED = 5.0
const JUMP_VELOCITY = 4.5
var sprint_slider

func _ready():
	sprint_slider = get_node("/root/" + get_tree().current_scene.name + "/UI/sprint_slider")

func _process(delta):
	if SPEED == 8:
		sprint_slider.value = sprint_slider.value - 0.3 * delta
		if sprint_slider.value < sprint_slider.min_value:
			SPEED -= 3
	if SPEED != 8:
		if sprint_slider.value < sprint_slider.max_value:
			sprint_slider.value = sprint_slider.value + 0.4 * delta
		if sprint_slider.value == sprint_slider.max_value:
			sprint_slider.visible = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	# if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		# velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		if Input.is_action_just_pressed("sprint"):
			sprint_slider.visible = true
			SPEED += 3
		if Input.is_action_just_released("sprint"):
			SPEED -=3
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
