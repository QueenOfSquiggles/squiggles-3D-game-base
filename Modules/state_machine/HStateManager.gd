extends Node
class_name StateManager
"""
HStateManager	- Hierarchical State Machine Manager
Handles the states of a state machine in a way befitting of a hierachy of states.
Very little is actually handled through this implementation as it is intended to be extended for specific purposes
"""

export (NodePath) var initial_state : NodePath

var current_state : BaseState

func init() -> void:
	change_state(get_node(initial_state))

func change_state(new_state : BaseState) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()

#
#	Delegations (Note that these still need to be called externally but whatever entity is using this state machine. This lets us stop using the state machine for a time if needed
#
func input(event : InputEvent) -> void:
	var n_state := current_state.input(event)
	if n_state:
		change_state(n_state)

func process(delta : float) -> void:
	var n_state := current_state.process(delta)
	if n_state:
		change_state(n_state)

func physics_process(delta: float) -> void:
	var n_state := current_state.physics_process(delta)
	if n_state:
		change_state(n_state)
