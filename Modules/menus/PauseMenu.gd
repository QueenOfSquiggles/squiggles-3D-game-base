extends Popup

export (String) var pause_input := "ui_cancel"

export (String) var options_menu_path := "res://Modules/menus/OptionsMenu.tscn"
export (String) var main_menu_path := "res://Modules/menus/MainMenu.tscn"

func _on_PauseMenu_about_to_show() -> void:
	print("About to show")
	Globals.set_paused(true)
	Globals.unlock_mouse()

func _on_BtnResume_pressed() -> void:
	self.hide()

func _on_BtnOptions_pressed() -> void:
	change_scene(options_menu_path)

func _on_BtnMainMenu_pressed() -> void:
	change_scene(main_menu_path)

func change_scene(path : String) -> void:
	self.hide()
	Globals.unlock_mouse()
	SaveData.save_data()
	print("changing scene to ", path)
	SceneManagement.load_scene(path)

func _on_PauseMenu_popup_hide() -> void:
	print("popup hide")
	Globals.set_paused(false)
	Globals.lock_mouse()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(pause_input):
		print("Input recieved")
		if self.visible:
			self.hide()
		else:
			self.popup_centered()
