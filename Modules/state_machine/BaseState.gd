extends Node
class_name BaseState

"""
Hierarchical state machine based on system created by "The Shaggy Dev" on youtube
Some modifications were made to better generalize this to a module (i.e. not every state has an animation name, let extensions handle that kind of thing)
"""


func enter() -> void:
	"""
	Called when this state is transitioned to from any other state
	"""
	pass

func exit() -> void:
	"""
	Called when exiting this state and transitioning to another state for any reason
	"""
	pass

func input(_event: InputEvent) -> BaseState:
	"""
	The state input, only called on the active state(s).
	@return the state to transition to, or null
	"""
	return null

func process(_delta : float) -> BaseState:
	"""
	The state process function, only called on the active state(s).
	@return the state to transition to, or null
	"""
	return null

func physics_process(_delta : float) -> BaseState:
	"""
	The state physics process function, only called on the active state(s).
	@return the state to transition to, or null
	"""
	return null
