extends Area3D

func _ready() -> void:
	connect("body_entered", _on_body_entered)

func _on_body_entered(body: Node) -> void:
	# Check if the player has the correct name (adjust "Player" if needed)
	if body.name == "player":
		var win_screen = get_tree().get_root().find_child("Win screen", true, false)
		if win_screen:
			
			win_screen.visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().paused = true  # Optional
		# Turn off the flashlight
		var flashlight = body.find_child("Flashlight", true, false)
		if flashlight:
			flashlight.visible = false
