extends Node
class_name AudioLib

func play(name : String = "") -> void:
	var key := name
	var pass_name := ""
	if ":" in name:
		var parts := name.split(":", false, 1)
		key = parts[0]
		pass_name = parts[1]
	if name.empty():
		var c := get_child(randi() % get_child_count())
		assert(c.has_method("play"), "Children of an AudioLib must have a valid 'play' function")
		c.play()
		
	else:
		for c in get_children():
			if c.name == name:
				assert(c.has_method("play"), "Children of an AudioLib must have a valid 'play' function")
				if not pass_name.empty():
					c.play(pass_name)
				else:
					c.play()
		
