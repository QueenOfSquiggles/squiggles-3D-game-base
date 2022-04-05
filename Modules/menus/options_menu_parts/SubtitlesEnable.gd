extends CheckBox



func _on_SubtitlesEnable_toggled(button_pressed: bool) -> void:
	Settings.subtitles_enabled = button_pressed


func _on_SubtitlesEnable_mouse_entered() -> void:
	print("%s detected mouse enter!" % str(self))
