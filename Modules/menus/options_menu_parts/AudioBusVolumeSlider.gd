tool
extends HBoxContainer

export (int) var audio_bus_index := 0
export (String) var label_text setget set_label_text

onready var audio := $AudioStreamPlayer
onready var label : Label = $Label
onready var slider := $HSlider
onready var muter := $CheckBox

func _ready() -> void:
	audio.bus = AudioServer.get_bus_name(audio_bus_index)
	label.text = label_text
func set_label_text(value : String) -> void:
	label_text = value
	if not label:
		label = $Label
	label.text = label_text

func _on_HSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(audio_bus_index, value)


func _on_CheckBox_toggled(button_pressed: bool) -> void:
	AudioServer.set_bus_mute(audio_bus_index, button_pressed)


func _on_BtnTest_pressed() -> void:
	audio.play()


func _on_BtnReset_pressed() -> void:
	slider.value = 0
	muter.pressed = false
