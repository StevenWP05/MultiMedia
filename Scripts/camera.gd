extends Node3D

var sens: float = 0.005  # Sensitivity for mouse movement
var mouse_captured := true
@onready var pause_menu := get_tree().get_root().find_child("Pause_menu", true, false)
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true
	if pause_menu:
		pause_menu.visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		mouse_captured = not mouse_captured
		if mouse_captured:
			resume_game()
		else:
			pause_game()

	elif mouse_captured and event is InputEventMouseMotion:
		get_parent().rotate_y(-event.relative.x * sens)
		rotate_x(-event.relative.y * sens)
		rotation_degrees.x = clamp(rotation_degrees.x, -90, 90)


func pause_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	if pause_menu:
		pause_menu.visible = true

func resume_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	if pause_menu:
		pause_menu.visible = false
		
func force_resume_camera():
	mouse_captured = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
