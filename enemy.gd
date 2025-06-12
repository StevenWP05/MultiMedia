extends CharacterBody3D

var speed = 4.5
@onready var nav_agent = $NavigationAgent3D
var player: Node3D  # Reference to the player node
@onready var visual = $Visual 
func _ready():
	add_to_group("enemy")
	player = get_tree().get_root().get_node("player")

func _physics_process(delta):
	# Look at player
	if player:
		var target_position = player.global_transform.origin
		var my_position = global_transform.origin
		var direction = (target_position - my_position).normalized()
		direction.y = 0
		if direction.length() > 0:
			var target_basis = Basis.looking_at(direction, Vector3.UP)
			visual.global_transform.basis = visual.global_transform.basis.slerp(target_basis, delta * 5.0)
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	velocity = velocity.move_toward(new_velocity, 25)
	move_and_slide()

func update_current_position(target_location):
	nav_agent.set_target_position(target_location)

func _on_navigation_agent_3d_target_reached():
	print("Target reached")

func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, 25)

func _on_kill_body_entered(body):
	if body.name == "player":  # Or use `body.is_in_group("player")` if grouped
		print("Player caught!")
		body.die()
		get_tree().change_scene_to_file("res://gameover.tscn")  # Make a game over screen!
