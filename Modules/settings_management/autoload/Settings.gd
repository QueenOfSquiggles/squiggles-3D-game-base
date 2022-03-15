extends Node

"""
Refer to :

https://github.com/Calinou/godot-sponza/blob/master/scripts/settings_gui.gd#L130

for more info on making graphics settings.

"""

var fullscreen := false

var viewport_msaa := Viewport.MSAA_DISABLED

var world_environment := {
	"glow_enabled" : true,
	"ssao_enabled" : false,
	"ss_reflections_enabled" : false,
}

func reload_settings() -> void:
	var env := get_tree().root.find_world().environment
	assert(env, "Environment was found null!")
	for key in world_environment.keys():
		var value = world_environment[key]
		env.set_indexed(key, value)
		print("World environment [%s] = [%s]" % [str(key), str(value)])
	get_viewport().msaa = viewport_msaa
	OS.window_fullscreen = fullscreen