extends Control

@onready var click_sound = $ClickSound
@onready var return_button = $Panel/return  # Adjust this path if needed

func _ready():
	# Make mouse visible and free
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_return_pressed() -> void:
	await get_tree().create_timer(0.2).timeout 
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Unpause the gameInput.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://main_menu.tscn") 
