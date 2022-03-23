extends "res://Modules/state_machine/HStateManager.gd"

export (NodePath) var player_controller_node : NodePath
export (NodePath) var animation_player : NodePath

onready var player := get_node(player_controller_node) as FirstPersonCharacterBase
onready var anim := get_node(animation_player) as AnimationPlayer

func init() -> void:
	for c in get_children():
		if c is PlayerState:
			var ps := c as PlayerState
			ps.player = player
			ps.animator = anim
	.init()
