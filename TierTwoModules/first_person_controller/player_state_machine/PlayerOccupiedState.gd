extends PlayerState

export (NodePath) var idle_state_path : NodePath
onready var idle_state := get_node(idle_state_path) as BaseState

var cache_state :BaseState = null

func enter() -> void:
	.enter()
	cache_state = null
	Globals.connect("player_occupied_changed", self, "on_occupied")

func exit() -> void:
	# disconnect when not active
	cache_state = null # twice for good measure
	Globals.disconnect("player_occupied_changed", self, "on_occupied")

func on_occupied(value : bool) -> void:
	if not value:
		cache_state = idle_state

func physics_process(delta : float) -> BaseState:
	if cache_state:
		return cache_state
	return null
