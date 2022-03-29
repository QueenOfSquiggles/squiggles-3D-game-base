extends Control

export (PackedScene) var game_scene_path : PackedScene
export (PackedScene) var options_menu : PackedScene
export (PackedScene) var credits_menu : PackedScene

func _ready() -> void:
	if not game_scene_path:
		return
	var temp = game_scene_path.instance()
	SaveData.does_save_data_exist_for(temp.name)

func _on_BtnContinue_pressed() -> void:
	if game_scene_path:
		SceneManagement.load_scene(game_scene_path.resource_path, true)


func _on_BtnNewGame_pressed() -> void:
	if not game_scene_path:
		return
	SaveData.delete_data()
	yield(VisualServer, "frame_post_draw") # one frame
	SceneManagement.load_scene(game_scene_path.fil, true)


func _on_BtnOptions_pressed() -> void:
	if options_menu:
		SceneManagement.load_scene(options_menu.resource_path)


func _on_BtnCredits_pressed() -> void:
	if credits_menu:
		SceneManagement.load_scene(credits_menu.resource_path)


func _on_BtnQuit_pressed() -> void:
	get_tree().quit()
