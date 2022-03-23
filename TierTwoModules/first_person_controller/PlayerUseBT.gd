extends KinematicBody

onready var bt := $PlayerBehaviourTree

func _process(delta: float) -> void:
	bt.tick_tree(delta)
