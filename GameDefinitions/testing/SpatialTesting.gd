extends Spatial

export (String) var scene_path : String
export var LOAD_GRADUAL := false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_enter"):
		SceneManagement.load_scene(scene_path, LOAD_GRADUAL)
