extends Control
@onready var click_sound = $ClickSound


func _on_button_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Unpause the gameInput.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://main_menu.tscn") # Replace with function body.
