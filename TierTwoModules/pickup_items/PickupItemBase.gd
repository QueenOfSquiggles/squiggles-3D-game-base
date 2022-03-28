extends RigidBody
class_name PickupItemBase
"""
Base class for all pickup items. 

Extending this will allow for interesting functionality for different objects.
"""

enum RigidModeStart {
	RIGID_UNTIL_PICKUP,
	START_STATIC,
}

enum StaticStyle {
	ONLY_AFTER_DROPPED,
	ALWAYS_ON_SLEEP,
	NEVER
}

export (RigidModeStart) var rigid_mode_start := RigidModeStart.RIGID_UNTIL_PICKUP
export (StaticStyle) var static_mode_style := StaticStyle.ONLY_AFTER_DROPPED
export (bool) var keep_rotation := false
export (NodePath) var audio_lib_path : NodePath
export (String) var sfx_impact := "impact"
export (String) var sfx_pickup := "pickup"
export (String) var sfx_drop := "drop"

onready var original_parent := get_parent()
onready var original_collision_layer := self.collision_layer
onready var original_collision_mask := self.collision_mask
onready var audio_lib := get_node(audio_lib_path) as Node

var has_been_dropped_before := false

func _ready() -> void:
	match rigid_mode_start:
		RigidModeStart.RIGID_UNTIL_PICKUP:
			self.mode = RigidBody.MODE_RIGID
		RigidModeStart.START_STATIC:
			self.mode = RigidBody.MODE_STATIC
		

func interact(player : FirstPersonCharacterBase) -> void:
	print("player interacted with object")
	player.set_held_item(self)

func use_item(player : FirstPersonCharacterBase) -> void:
	print("player used item!")
	player.set_held_item(null) # should call the remove_item func

func pickup_item(_player : FirstPersonCharacterBase) -> void:
	self.mode = RigidBody.MODE_STATIC
	self.transform = Transform.IDENTITY # reset position to ensure no weird reactions.
	self.collision_layer = 0
	self.collision_mask = 0
	audio_lib.play(sfx_pickup)

func remove_item(_player : FirstPersonCharacterBase) -> void:
	set_as_toplevel(true)
	var glob_rot := self.rotation
	set_as_toplevel(false)
	var trans := (get_parent() as Spatial).global_transform
	get_parent().remove_child(self)
	original_parent.add_child(self)
	self.global_transform = trans
	self.rotation = glob_rot # retain held item rotation?
	self.mode = RigidBody.MODE_RIGID
	self.collision_layer = original_collision_layer
	self.collision_mask = original_collision_mask
	has_been_dropped_before = true
	audio_lib.play(sfx_drop)


func _on_sleeping_state_changed() -> void:
	if self.sleeping:
		match(static_mode_style):
			StaticStyle.ALWAYS_ON_SLEEP:
				self.mode = RigidBody.MODE_STATIC
			StaticStyle.ONLY_AFTER_DROPPED:
				if has_been_dropped_before:
					self.mode = RigidBody.MODE_STATIC



func _on_self_body_entered(body: Node) -> void:
	# called when any collision is detected
	if audio_lib and audio_lib.has_method("play"):
		audio_lib.play(sfx_impact)
