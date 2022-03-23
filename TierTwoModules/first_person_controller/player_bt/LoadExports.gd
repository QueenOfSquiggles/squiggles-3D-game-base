extends ActionLeaf

export (NodePath) var camera_path : NodePath
export (NodePath) var camera_pivot_path : NodePath

func tick(_actor : Node, bb : Blackboard) -> int:

	bb.set("camera", get_node(camera_path))
	bb.set("cam_pivot", get_node(camera_pivot_path))
	
	return SUCCESS
