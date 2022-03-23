extends Node
"""
Globals handles some common global attributes that can affect other scripts across the game.
Kindof acts as a middle-man between certain modules
"""

"""
		Player Occupied
"""
signal player_occupied_changed(value)

var player_occupied := false setget _set_player_occupied

func _set_player_occupied(value : bool) -> void:
	player_occupied = value
	print("Player Occupied = ", value)
	emit_signal("player_occupied_changed", player_occupied)

func set_player_occupied_dialogue(value : Array) -> void:
	var val := bool(value[0])
	player_occupied = val
