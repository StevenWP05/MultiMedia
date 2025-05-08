extends Node3D

var sens: float = 0.005  # Sensitivity for mouse movement

func _ready() -> void:
	# Capture the mouse for a better first-person view experience
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Rotate the parent node horizontally (yaw)
		get_parent().rotate_y(-event.relative.x * sens)
		
		# Rotate this node vertically (pitch)
		rotate_x(-event.relative.y * sens)
		
		# Clamp the pitch rotation to avoid flipping
		rotation_degrees.x = clamp(rotation_degrees.x, -90, 90)
