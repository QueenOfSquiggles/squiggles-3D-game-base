extends BaseState
class_name PlayerState

export (String) var animation_name := ""
var player : FirstPersonCharacterBase
var animator : AnimationPlayer

func enter() -> void:
	if animator and not animation_name.empty():
		animator.play(animation_name)
