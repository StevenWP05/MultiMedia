extends Control

@onready var click_sound = $ClickSound
@onready var settings_panel = preload("res://Settings.tscn").instantiate()
func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	add_child(settings_panel)
	settings_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	settings_panel.hide()
func _on_start_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.2).timeout  # short delay so sound isn't cut off
	get_tree().change_scene_to_file("res://cotrols.tscn")

func _on_settings_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.2).timeout
	settings_panel.show()
	# Add your settings menu logic here

func _on_exit_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()
