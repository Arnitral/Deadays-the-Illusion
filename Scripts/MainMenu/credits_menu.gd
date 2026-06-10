extends Control

func _ready() -> void:
	$ColorRect2/ColorRect/Panel/CloseButton.pressed.connect(func():
		hide()
	)


func _on_rich_text_label_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))
