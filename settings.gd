extends Control
@onready var click_sound = $ClickSound
@onready var volume_slider = $Options/PanelContainer/MarginContainer/VBoxContainer/HSlider

const CONFIG_PATH = "user://audio_settings.cfg"
var BUS_INDEX = AudioServer.get_bus_index("Master")

func _ready():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		# Volume
		var volume = config.get_value("settings", "volume", 1.0)
		$Options/PanelContainer/MarginContainer/VBoxContainer/HSlider.value = volume
		AudioServer.set_bus_volume_db(0, linear_to_db(volume))

		# Mute
		var is_muted = config.get_value("settings", "is_muted", false)
		$Options/PanelContainer/MarginContainer/VBoxContainer/CheckBox.button_pressed = is_muted
		AudioServer.set_bus_mute(0, is_muted)

		# Resolution
		var res_index = config.get_value("settings", "resolution_index", 0)
		$Options/PanelContainer/MarginContainer/VBoxContainer/resolutions.select(res_index)
		_set_resolution(res_index)

		# Fullscreen (optional)
		var fullscreen = config.get_value("settings", "fullscreen", false)
		if fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_check_box_toggled(toggled_on: bool) -> void:
	click_sound.play()
	await get_tree().create_timer(0.2).timeout
	AudioServer.set_bus_mute(BUS_INDEX, toggled_on)

func _on_resolutions_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600, 900))
		2:
			DisplayServer.window_set_size(Vector2i(1280, 720))
func _set_resolution(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600, 900))
		2:
			DisplayServer.window_set_size(Vector2i(1280, 720))

func _on_back_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.2).timeout
	hide()
	var config = ConfigFile.new()

	# Get current values
	var slider_value = $Options/PanelContainer/MarginContainer/VBoxContainer/HSlider.value
	var resolution_index = $Options/PanelContainer/MarginContainer/VBoxContainer/resolutions.get_selected_id()
	var is_muted = $Options/PanelContainer/MarginContainer/VBoxContainer/CheckBox.button_pressed
	var is_fullscreen = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN

	# Save them
	config.set_value("settings", "volume", slider_value)
	config.set_value("settings", "resolution_index", resolution_index)
	config.set_value("settings", "is_muted", is_muted)
	config.set_value("settings", "fullscreen", is_fullscreen)

	# Actually apply volume and mute
	AudioServer.set_bus_volume_db(0, linear_to_db(slider_value))
	AudioServer.set_bus_mute(0, is_muted)

	config.save("user://settings.cfg")
	

	
func save_audio_settings():
	var config = ConfigFile.new()
	config.set_value("audio", "volume", volume_slider.value)
	config.save(CONFIG_PATH)

func load_audio_settings():
	var config = ConfigFile.new()
	if config.load(CONFIG_PATH) == OK:
		var volume = config.get_value("audio", "volume", 0.5)
		volume_slider.value = volume
		AudioServer.set_bus_volume_db(BUS_INDEX, linear_to_db(volume))
	else:
		# Default volume if config doesn't exist
		AudioServer.set_bus_volume_db(BUS_INDEX, linear_to_db(0.5))
