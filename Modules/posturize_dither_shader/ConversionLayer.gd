extends TextureRect

func _ready() -> void:
	get_tree().connect("screen_resized", self, "on_screen_changed")

func on_screen_changed() -> void:
	var viewport := get_tree().current_scene.get_viewport()
	if viewport:
		(self.material as ShaderMaterial).set_shader_param("screen_size", viewport.size)
