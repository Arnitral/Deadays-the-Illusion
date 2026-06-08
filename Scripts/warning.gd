extends Control

func _ready() -> void:
	$Continue.pressed.connect(func():
		get_tree().change_scene_to_file("res://Scenes/intro.tscn")
	)
	$Quit.pressed.connect(func():
		get_tree().quit()
	)
