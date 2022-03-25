extends "res://Modules/cutscenes/CutsceneBase.gd"

onready var cam := $Camera


func _on_Area_body_entered(body: Node) -> void:
	if body.is_in_group("player"): # checks are double but worth it
		var current_cam := get_viewport().get_camera()
		cam.global_transform = current_cam.global_transform
		cam.rotation = current_cam.rotation
		._on_Area_body_entered(body) # do normal script
