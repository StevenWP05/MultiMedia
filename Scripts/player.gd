extends CharacterBody3D


var SPEED = 5.0
const JUMP_VELOCITY = 4.5
var sprint_slider
@onready var walk_sound = $Walking
@onready var run_sound = $Running

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
		# ✅ Sound playback
		if SPEED > 5:
			if not run_sound.playing:
				run_sound.play()
		else:
			if not walk_sound.playing:
				walk_sound.play()
			run_sound.stop()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		# Stop sounds when not moving
		walk_sound.stop()
		run_sound.stop()

	move_and_slide()

func die():
	# Play death sound
	Soundmanger.get_node("Death").play()
	# Optional: Disable movement or show Game Over screen
	set_physics_process(false)
	# Optional: show Game Over scene
	await get_tree().create_timer(2.8).timeout
	get_tree().change_scene_to_file("res://scenes/gameover.tscn")
