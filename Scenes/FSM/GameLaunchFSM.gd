extends "res://addons/imjp94.yafsm/src/StateMachinePlayer.gd"

const TRIGGER_MAIN_MENU := "main_menu"
const TRIGGER_OPTIONS_MENU := "options_menu"
const TRIGGER_CREDITS_SCREEN := "credits_screen"
const TRIGGER_LOAD_SAVE := "load_save"
const TRIGGER_NEW_GAME := "new_game"
const TRIGGER_PLAY_STATE := "play_state"
const TRIGGER_PAUSE_STATE := "pause_state"
const TRIGGER_CLOSE_GAME := "close_game"
const TRIGGER_ := ""

func trigger(name : String) -> void:
	"""
	Literally only renamed for my convenience
	"""
	self.set_trigger(name)

