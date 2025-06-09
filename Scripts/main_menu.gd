extends Control

@onready var click_sound = $ClickSound

func _on_start_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.2).timeout  # short delay so sound isn't cut off
	get_tree().change_scene_to_file("res://node_3d.tscn")

func _on_settings_pressed() -> void:
	click_sound.play()
	# Add your settings menu logic here

func _on_exit_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()
