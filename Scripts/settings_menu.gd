extends Control

@onready var settings = get_node("/root/Settings")
@export var menu: Control
@onready var fov_slider: HSlider = $ColorRect2/ColorRect/GamePage/VBC/FOVLabel/FovSlider
@onready var sense_slider: HSlider = $ColorRect2/ColorRect/GamePage/VBC/SenseLabel/SenseSlider
@onready var music_volume_slider: HSlider = $ColorRect2/ColorRect/SoundPage/VBC/MusicVolume/MusicVolumeSlider
@onready var player_volume_slider: HSlider = $ColorRect2/ColorRect/SoundPage/VBC/PlayerVolume/PlayerVolumeSlider
@onready var zombie_volume_slider: HSlider = $ColorRect2/ColorRect/SoundPage/VBC/ZombieVolume/ZombieVolumeSlider
@onready var weapon_volume_slider: HSlider = $ColorRect2/ColorRect/SoundPage/VBC/WeaponVolume/WeaponVolumeSlider
@onready var master_volume_slider: HSlider = $ColorRect2/ColorRect/SoundPage/VBC/MasterVolume/MasterVolumeSlider
var crosshair_visible_toogle = true
@onready var crosshair: TextureRect = $"../../WeaponManager/Weapons/Knife/Crosshair"
@onready var aim_point_label: Label = $ColorRect2/ColorRect/GamePage/VBC/AimPointLabel
@onready var aim_label: Label = $ColorRect2/ColorRect/GamePage/VBC/AimPointLabel/AimButton/AimLabel
@onready var sound_page: Control = $ColorRect2/ColorRect/SoundPage
@onready var game_page: Control = $ColorRect2/ColorRect/GamePage
@onready var fps_limit_value_label: Label = $ColorRect2/ColorRect/GamePage/VBC/FPSLimitLabel/FPSLimitValueLabel
@onready var fps_limit_slider: HSlider = $ColorRect2/ColorRect/GamePage/VBC/FPSLimitLabel/FPSLimitSlider

@onready var selection_hover: Panel = $ColorRect2/ColorRect/SelectionHover
@onready var game_vbc: VBoxContainer = $ColorRect2/ColorRect/GamePage/VBC
@onready var sound_vbc: VBoxContainer = $ColorRect2/ColorRect/SoundPage/VBC
@onready var selection_hover_control: Control = $ColorRect2/ColorRect/SelectionHoverControl

func _ready():
	#visible = false
	fps_limit_slider.value = settings.limit_FPS
	fov_slider.value = settings.FOV
	sense_slider.value = settings.mouse_sense
	master_volume_slider.value = settings.master_volume
	music_volume_slider.value = settings.music_volume
	player_volume_slider.value = settings.player_volume
	zombie_volume_slider.value = settings.zombie_volume
	weapon_volume_slider.value = settings.shooting_volume
	crosshair_visible_toogle = settings.crosshair_visible
	
	_setup_hover_selection()

func _setup_hover_selection() -> void:
	selection_hover.hide()
	
	for item in game_vbc.get_children():
		if item is Label:
			item.mouse_filter = Control.MOUSE_FILTER_STOP
			item.mouse_entered.connect(func(): _highlight_item(item))
			
	for item in sound_vbc.get_children():
		if item is Label:
			item.mouse_filter = Control.MOUSE_FILTER_STOP
			item.mouse_entered.connect(func(): _highlight_item(item))

	fps_limit_slider.mouse_filter = Control.MOUSE_FILTER_PASS
	fov_slider.mouse_filter = Control.MOUSE_FILTER_PASS
	sense_slider.mouse_filter = Control.MOUSE_FILTER_PASS

	var aim_btn = $ColorRect2/ColorRect/GamePage/VBC/AimPointLabel/AimButton
	if aim_btn:
		aim_btn.mouse_filter = Control.MOUSE_FILTER_PASS

	game_vbc.mouse_exited.connect(func(): selection_hover.hide())
	sound_vbc.mouse_exited.connect(func(): selection_hover.hide())

func _highlight_item(item: Control) -> void:
	if not item.is_visible_in_tree():
		return
		
	selection_hover.show()
	
	selection_hover.global_position.y = item.global_position.y
	
	selection_hover.global_position.x = selection_hover_control.global_position.x 
	
	selection_hover.size.x = selection_hover_control.size.x
	selection_hover.size.y = item.size.y

func _on_sense_slider_value_changed(value: float) -> void:
	settings.mouse_sense = value
	settings.save_settings()
	_apply_to_player_if_exists()

func _on_fov_slider_value_changed(value: int) -> void:
	settings.FOV = value
	settings.save_settings()
	_apply_to_player_if_exists()
	
func _on_volume_slider_value_changed(value: float) -> void:
	settings.master_volume = value
	settings.apply_audio_settings()
	settings.save_settings()

func _on_music_volume_slider_value_changed(value: float) -> void:
	settings.music_volume = value
	settings.apply_audio_settings()
	settings.save_settings()

func _on_player_volume_slider_value_changed(value: float) -> void:
	settings.player_volume = value
	settings.apply_audio_settings()
	settings.save_settings()
	
func _on_zombie_volume_slider_value_changed(value: float) -> void:
	settings.zombie_volume = value
	settings.apply_audio_settings()
	settings.save_settings()

func _on_weapon_volume_slider_value_changed(value: float) -> void:
	settings.shooting_volume = value
	settings.apply_audio_settings()
	settings.save_settings()

func _on_exit_button_pressed() -> void:
	hide()

func _on_aim_button_pressed() -> void:
	if crosshair_visible_toogle:
		crosshair_visible_toogle = false
		settings.crosshair_visible = crosshair_visible_toogle
		settings.save_settings()
		_apply_to_player_if_exists()
		aim_label.text = tr("ON")
	else:
		crosshair_visible_toogle = true
		settings.crosshair_visible = crosshair_visible_toogle
		settings.save_settings()
		_apply_to_player_if_exists()
		aim_label.text = tr("OFF")

func _on_sound_button_pressed() -> void:
	sound_page.show()
	game_page.hide()
	selection_hover.hide()

func _on_game_button_pressed() -> void:
	sound_page.hide()
	game_page.show()
	selection_hover.hide()

func _on_fps_limit_slider_value_changed(value: float) -> void:
	settings.limit_FPS = int(value)
	Engine.max_fps = settings.limit_FPS
	settings.save_settings()
	fps_limit_value_label.text = "%s" % value + " "

func _apply_to_player_if_exists():
	var player = get_tree().get_first_node_in_group("player")
	if player and player.has_method("update_settings_from_manager"):
		player.update_settings_from_manager()
