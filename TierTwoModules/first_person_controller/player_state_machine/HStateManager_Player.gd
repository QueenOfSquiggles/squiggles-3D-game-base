extends "res://Modules/state_machine/HStateManager.gd"

export (NodePath) var player_controller_node : NodePath
export (NodePath) var animation_player : NodePath
export (NodePath) var camera_path : NodePath


onready var player := get_node(player_controller_node) as KinematicBody
onready var anim := get_node(animation_player) as AnimationPlayer
onready var camera := get_node(camera_path) as Camera

func init() -> void:
	for c in get_children():
		if c is PlayerState:
			var ps := c as PlayerState
			ps.player = player
			ps.animator = anim
			ps.camera = camera
	.init()
