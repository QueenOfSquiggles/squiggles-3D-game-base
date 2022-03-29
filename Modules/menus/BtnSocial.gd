extends Button

export (String) var URI := ""

func _ready() -> void:
	self.connect("pressed", self, "on_social_pressed")

func on_social_pressed() -> void:
	OS.shell_open(URI)
