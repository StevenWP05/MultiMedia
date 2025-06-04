extends Control


func _on_resume_pressed() -> void:
	#print("Resume pressed") 
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	visible = false # Replace with function body.


func _on_leave_pressed() -> void:
	get_tree().paused = false  # Unpause the game
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://main_menu.tscn") # Replace with function body.
