extends Node3D

@onready var player = $player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Update all enemies' target positions to the player's position
	get_tree().call_group("enemy", "update_current_position", player.global_transform.origin)
