extends Node

"""
SceneManagement.gd
---
An autoload for handling scene loading and unloading.

"""

const DEFAULT_LOADING_SCREEN := "res://Modules/SceneManagement/DefaultLoadingScreen.tscn"

var loading_scene : LoadingScreen

func load_scene(path : String, use_loading_screen : bool = false) -> void:
	"""
	Doesn't use a loading screen by default because we should know whether or not the
	"""
	if use_loading_screen:
		_load_gradual(path)
	else:
		_load_instant(path)


func _load_instant(path: String) -> void:
	get_tree().change_scene(path)

var loader : ResourceInteractiveLoader
var loading_title : String = ""
var current_loading_scene_name := ""
const form_title := "Loading scene [%s] Stage (%d / %d)"
var wait_frames
const time_max := 10
var current_scene

func _load_gradual(path: String) -> void:
	current_loading_scene_name = path
	current_scene = get_tree().current_scene
	loader = ResourceLoader.load_interactive(path)
	assert(loader, "Failed to create resource loader for %s" % path)
	set_process(true)
	current_scene.queue_free()
	_load_instant(DEFAULT_LOADING_SCREEN)
	wait_frames = 1

func _process(delta: float) -> void:
	if loader == null:
		set_process(false)
		return
	if wait_frames > 0:
		wait_frames -= 1
		loading_scene = get_tree().current_scene as LoadingScreen
		assert(loading_scene, "Failed to change to the loading screen!!!")
		return
	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max:
		var err := loader.poll()

		if err == ERR_FILE_EOF:
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			break
		elif err == OK:
			update_progress()
		else:
			assert(false, "Something failed! ErrorCode : %s" % err)
			loader = null
			break
	loading_title = form_title % [current_loading_scene_name, loader.get_stage(), loader.get_stage_count()]


func set_new_scene(scene : PackedScene) -> void:
	current_scene = scene
	get_tree().change_scene_to(scene)

func update_progress() -> void:
	var progress := float(loader.get_stage()) / float(loader.get_stage_count())
	loading_scene.update_progress(loading_title, progress)
