extends Node

"""
Refer to :

https://github.com/Calinou/godot-sponza/blob/master/scripts/settings_gui.gd#L130

for more info on making graphics settings.

"""

signal refresh_settings

var fullscreen := false

var viewport_msaa := Viewport.MSAA_DISABLED

var world_environment := {
	"glow_enabled" : true,
	"ssao_enabled" : false,
	"ss_reflections_enabled" : false,
}

func reload_settings() -> void:
	emit_signal("refresh_settings")
	get_viewport().msaa = viewport_msaa
	OS.window_fullscreen = fullscreen
