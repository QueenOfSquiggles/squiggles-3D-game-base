extends Node


var _locks := {
	"default" : false
}

# signature : (String, bool)
signal lock_changed(lock_name, value)

func set_lock(lock_name : String, value : bool) -> void:
	"""
	Assign the value of a lock (creates a new lock if it doesn't already exist) and emits a signal for the name and value of the lock. This signal can be observed externally and used by any door, lock, gate, or structure which has a binary state. This decouples the keys and locks of a system while still allowing specific keys to unlock specific locks.
	The keys and locks need not be a literal key and/or lock but can be anything that would need to be triggered.
	"""
	_locks[lock_name] = value
	emit_signal("lock_changed", lock_name, value)
