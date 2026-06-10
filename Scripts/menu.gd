extends Control
@onready var start_button: Button = $ColorRect/StartButton
@onready var exit_button: Button = $ColorRect/ExitButton
@onready var knp_click: AudioStreamPlayer = $KnpClick
@onready var start_label: Label = $ColorRect/StartButton/StartLabel
@onready var label_2: Label = $ColorRect/ExitButton/Label2
@onready var settings_label: Label = $ColorRect/SettingsButton/SettingsLabel

@onready var settings_menu: Control = $"../SettingsMenu"
@onready var credits_menu: Control = $"../CreditsMenu"
var game_scene = null

var select_chapter_menu: bool = false

func _ready():
	ResourceLoader.load_threaded_request("res://Scenes/world.tscn")
	$VBC/Quit.pressed.connect(func():
		get_tree().quit()
	)
	$VBC/Settings.pressed.connect(func():
		settings_menu.visible = !settings_menu.visible
		if credits_menu.visible == true:
			credits_menu.hide()
	)
	$VBC/Credits.pressed.connect(func():
		credits_menu.visible = !credits_menu.visible
		if settings_menu.visible == true:
			settings_menu.hide()
	)
	$VBC/SelectChapter.pressed.connect(func():
		select_chapter_menu = true
		$VBCSC.visible = select_chapter_menu
		$VBC.visible = (select_chapter_menu != true)
	)
	# effectss
	$VBC/Quit.mouse_entered.connect(func():
		knp_click.play()
	)
	$VBC/Settings.mouse_entered.connect(func():
		knp_click.play()
	)
	$VBC/Credits.mouse_entered.connect(func():
		knp_click.play()
	)
	$VBC/SelectChapter.mouse_entered.connect(func():
		knp_click.play()
	)
	# Select Chapter Menu
	$VBCSC/Back.pressed.connect(func():
		select_chapter_menu = false
		$VBCSC.visible = select_chapter_menu
		$VBC.visible = (select_chapter_menu != true)
	)
	$VBCSC/Chapter1.pressed.connect(func():
		pass
	)
	$VBCSC/Chapter2.pressed.connect(func():
		pass
	)
	$VBCSC/Chapter3.pressed.connect(func():
		pass
	)
	# Effects
	$VBCSC/Back.mouse_entered.connect(func():
		knp_click.play()
	)
	$VBCSC/Chapter1.mouse_entered.connect(func():
		knp_click.play()
	)
	$VBCSC/Chapter2.mouse_entered.connect(func():
		pass#knp_click.play()
	)
	$VBCSC/Chapter3.mouse_entered.connect(func():
		pass#knp_click.play()
	)

#func _on_start_button_pressed() -> void:
	#if ResourceLoader.load_threaded_get_status("res://Scenes/world.tscn") == ResourceLoader.THREAD_LOAD_LOADED:
		#game_scene = ResourceLoader.load_threaded_get("res://Scenes/world.tscn")
		#get_tree().change_scene_to_packed(game_scene)
