extends PlayerState

export(NodePath) var occupied_state_path : NodePath
export (NodePath) var move_state_path : NodePath
export (NodePath) var item_manipulation_path : NodePath

onready var occupied_state := get_node(occupied_state_path) as BaseState
onready var move_state := get_node(move_state_path) as BaseState
onready var item_manipulation := get_node(item_manipulation_path) as BaseState

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
	if value:
		cache_state = occupied_state

func physics_process(delta : float) -> BaseState:
	if cache_state:
		return cache_state
	return null

func input(event : InputEvent) -> BaseState:
	
	return null
