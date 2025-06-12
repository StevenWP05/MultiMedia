extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var volume = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$PanelContainer/MarginContainer/VBoxContainer/HSlider.value = volume
func _on_h_slider_mouse_exited() -> void:
	release_focus() # Replace with function body.
