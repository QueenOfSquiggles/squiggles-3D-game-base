extends Node

"""
Refer to :

https://github.com/Calinou/godot-sponza/blob/master/scripts/settings_gui.gd#L130

for more info on making graphics settings.

"""

signal refresh_settings

var fullscreen := false
var use_retro_filter := true
var viewport_msaa := Viewport.MSAA_DISABLED
var subtitles_enabled := false

var world_environment := {
	"glow_enabled" : true,
	"ssao_enabled" : false,
	"ss_reflections_enabled" : false,
}

var audio_bus := {
	"Master" : {
		"muted" : false,
		"volume" : 0
	},
	"SoundEffects" : {
		"muted" : false,
		"volume" : 0
	},
	"VoiceLines" : {
		"muted" : false,
		"volume" : 0
	},
	"Music" : {
		"muted" : false,
		"volume" : 0
	},
	"Misc" : {
		"muted" : false,
		"volume" : 0
	}
}

func reload_settings() -> void:
	emit_signal("refresh_settings")
	get_viewport().msaa = viewport_msaa
	OS.window_fullscreen = fullscreen
	Subtitles.subtitles_enabled = subtitles_enabled
	if not subtitles_enabled:
		# extra precaution to remove accidental subtitles
		Subtitles.call_deferred("clear_subtitles")
	for bus in audio_bus:
		# handle audio server
		var idx := AudioServer.get_bus_index(bus)
		var data = audio_bus[bus]
		AudioServer.set_bus_volume_db(idx, data.volume)
		AudioServer.set_bus_mute(idx, data.muted)
