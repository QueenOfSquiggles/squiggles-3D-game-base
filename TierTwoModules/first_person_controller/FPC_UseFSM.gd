extends KinematicBody

export (NodePath) var state_machine_path : NodePath

onready var state_machine := get_node(state_machine_path) as StateManager

func _ready() -> void:
	state_machine.init()

func _process(delta: float) -> void:
	state_machine.process(delta)
func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)
func _input(event: InputEvent) -> void:
	state_machine.input(event)
