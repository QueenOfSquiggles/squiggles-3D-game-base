extends KinematicBody
class_name FirstPersonCharacterBase

onready var bt := $PlayerBehaviourTree
onready var anim_player := $AnimationPlayer
onready var held_item_root := $Pivot/Camera/held_object

func _physics_process(delta: float) -> void:
	bt.tick_tree(delta)

func play_animation(anim : String) -> void:
	anim_player.play(anim)
	
func set_held_item(item : Spatial) -> void:
	if held_item_root.get_child_count() > 0:
		var cur_item := held_item_root.get_child(0)
		if cur_item and cur_item.has_method("remove_item"):
			cur_item.remove_item(self)
	if item:
		# check here so we can pass null to clear held items
		item.get_parent().remove_child(item)
		held_item_root.add_child(item)
		if item.has_method("pickup_item"):
			item.pickup_item(self)

