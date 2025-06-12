extends Node3D

@onready var player = $player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

	get_tree().call_group("enemy", "update_current_position", player.global_transform.origin)
