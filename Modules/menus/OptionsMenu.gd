extends Control

export (String) var main_menu_path : String

func _on_BtnMainMenu_pressed() -> void:
	SceneManagement.load_scene(main_menu_path)
