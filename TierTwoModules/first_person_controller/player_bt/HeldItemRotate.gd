extends Leaf
# Held Item Rotate

func tick(_actor : Node, bb : Blackboard) -> int:
	if not bb.get("input_toggle_rotate_item", false) as bool:
		return FAILURE
	
	print("Doing held item rotate")
	return SUCCESS
