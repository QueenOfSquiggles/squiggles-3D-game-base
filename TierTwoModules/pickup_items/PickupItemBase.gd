extends RigidBody
class_name PickupItemBase
"""
Base class for all pickup items. 

Extending this will allow for interesting functionality for different objects.
"""

onready var original_parent := get_parent()
onready var original_collision_layer := self.collision_layer
onready var original_collision_mask := self.collision_mask

func interact(player : FirstPersonCharacterBase) -> void:
	print("player interacted with object")
	player.set_held_item(self)

func use_item(player : FirstPersonCharacterBase) -> void:
	print("player used item!")
	player.set_held_item(null) # should call the remove_item func

func pickup_item(player : FirstPersonCharacterBase) -> void:
	self.mode = RigidBody.MODE_KINEMATIC
	self.transform = Transform.IDENTITY # reset position to ensure no weird reactions.
	self.collision_layer = 0
	self.collision_mask = 0

func remove_item(player : FirstPersonCharacterBase) -> void:
	var trans := (get_parent() as Spatial).global_transform
	get_parent().remove_child(self)
	original_parent.add_child(self)
	self.global_transform = trans
	self.mode = RigidBody.MODE_RIGID
	self.collision_layer = original_collision_layer
	self.collision_mask = original_collision_mask
