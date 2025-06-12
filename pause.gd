extends Control

@onready var click_sound = $ClickSound
@onready var settings_panel = preload("res://Settings.tscn").instantiate()

func _ready():
	add_child(settings_panel)
	settings_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	settings_panel.hide()

func _on_resume_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	visible = false

	var camera = get_tree().get_root().find_child("Camera3D", true, false)
	if camera:
		print("Camera found:", camera)
		if camera.has_method("force_resume_camera"):
			camera.force_resume_camera()
		else:
			print("Method not found on camera!")
	else:
		print("Camera node not found!")


func _on_leave_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.2).timeout 
	get_tree().paused = false  # Unpause the game
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://main_menu.tscn") # Replace with function body.


func _on_settings_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.2).timeout
	settings_panel.show()
