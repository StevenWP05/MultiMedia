extends Control
@onready var click_sound = $ClickSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	if Input.is_action_just_pressed("next"):
		click_sound.play()
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file("res://node_3d.tscn")
