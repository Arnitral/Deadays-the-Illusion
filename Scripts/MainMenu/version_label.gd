extends Label

var base_version : String = "v1.0."

var glitch_chars : String = "0123456789!?@#$%^&*()_+=-[]{};:<>?,.iLLuSiOn" + \
							"アイウエオカキクケコサシスセソタチツテト" + \
							"▲▼◀▶^_^ᓚᘏᗢ •̀ ω •́ )✧ヾ≧▽≦*)o▀̿Ĺ̯▀" + \
							"░▒▓█║╚╔╩╦╠═╬"

var change_speed : float = 0.02
var time_passed : float = 0.0

func _process(delta: float) -> void:
	time_passed += delta
	if time_passed >= change_speed:
		time_passed = 0.0
		if randf() > 0.1:
			generate_glitch_text()

func generate_glitch_text() -> void:
	var glitch_part = ""
	var length = randi_range(4, 7)
	
	for i in range(length):
		var random_index = randi() % glitch_chars.length()
		glitch_part += glitch_chars[random_index]
		
	text = base_version + glitch_part
