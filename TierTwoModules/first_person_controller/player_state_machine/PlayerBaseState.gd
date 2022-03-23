extends BaseState
class_name PlayerState

export (String) var animation_name := ""
var player : KinematicBody
var animator : AnimationPlayer
var camera : Camera

func enter() -> void:
	if animator and not animation_name.empty():
		animator.play(animation_name)
