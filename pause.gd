extends Control


	
	# Optionally notify camera to re-enable mouse_captured if needed


	 # Or change scene if returning to main menu


func _on_button_pressed() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	visible = false
	 # Replace with function body.


func _on_button_2_pressed() -> void:
	get_tree().quit()  # Replace with function body.
