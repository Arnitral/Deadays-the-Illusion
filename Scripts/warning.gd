extends Control

func _ready() -> void:
	ResourceLoader.load_threaded_request("res://Scenes/intro.tscn")
	var intro_scene = ResourceLoader.load_threaded_get("res://Scenes/intro.tscn")
	%Continue.pressed.connect(func():
		$AP.play("contunue")
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_packed(intro_scene)
	)
	%Quit.pressed.connect(func():
		get_tree().quit()
	)
	# effects
	%Continue.mouse_entered.connect(func():
		%Continue/ASP.play()
		%Continue/AP.speed_scale = 1.0
		%Continue/AP.play("entered")
	)
	%Quit.mouse_entered.connect(func():
		%Quit/ASP.play()
		%Quit/AP.speed_scale = 1.0
		%Quit/AP.play("entered")
	)
	
	%Continue.mouse_exited.connect(func():
		%Continue/AP.play_backwards("entered")
	)
	%Quit.mouse_exited.connect(func():
		%Quit/AP.play_backwards("entered")
	)
